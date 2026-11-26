#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <stdint.h>
#include <stdarg.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <signal.h>
#include <pthread.h>
#include <sys/socket.h>
#include <sys/wait.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <getopt.h>
#include <time.h>
#include <openssl/ssl.h>
#include <openssl/err.h>
#include <openssl/pem.h>

/* 默认参数（可通过命令行选项覆盖） */
#define DEFAULT_HTTP_PORT 8080

static char g_rtsp_host[128] = "192.168.172.1";
static int  g_rtsp_port       = 554;
static char g_base_url[512]   = "rtsp://192.168.172.1:554/ch0";
static char g_ffmpeg[256]     = "/usr/bin/ffmpeg";

static const unsigned char STREAM_START[4] = { 0x00, 0x00, 0x00, 0x01 };

/* 编译期内嵌资源（由 Makefile 中的 ld -r -b binary 生成） */
extern const unsigned char _binary_index_html_start[];
extern const unsigned char _binary_index_html_end[];

extern const unsigned char _binary_config_plain_cert_ca_cert_pem_start[];
extern const unsigned char _binary_config_plain_cert_ca_cert_pem_end[];
extern const unsigned char _binary_config_plain_cert_cam_cert_pem_start[];
extern const unsigned char _binary_config_plain_cert_cam_cert_pem_end[];
extern const unsigned char _binary_config_plain_cert_cam_key_pem_start[];
extern const unsigned char _binary_config_plain_cert_cam_key_pem_end[];

static volatile sig_atomic_t running = 1;
static int g_listen_fd = -1;

static pthread_mutex_t state_mutex = PTHREAD_MUTEX_INITIALIZER;
static pthread_cond_t  state_cond  = PTHREAD_COND_INITIALIZER;
static unsigned char *latest_jpeg = NULL;
static size_t          latest_jpeg_len = 0;
static uint64_t        frame_seq = 0;

static SSL_CTX *g_ctx = NULL;

static long g_cseq = 0;

/* 客户端并发数限制（先来先断：新连接挤掉最旧的连接） */
static int g_max_clients = 3;
static int *g_client_fds = NULL;
static int g_client_count = 0;
static pthread_mutex_t client_mutex = PTHREAD_MUTEX_INITIALIZER;

/* ------------------------------------------------------------------ */
/* growable byte buffer                                                */
/* ------------------------------------------------------------------ */
typedef struct {
    unsigned char *data;
    size_t len;
    size_t cap;
} buf_t;

static int buf_append(buf_t *b, const unsigned char *p, size_t n) {
    if (n == 0)
        return 0;
    if (b->len + n > b->cap) {
        size_t nc = b->cap ? b->cap : 256;
        while (nc < b->len + n)
            nc *= 2;
        unsigned char *nd = realloc(b->data, nc);
        if (!nd)
            return -1;
        b->data = nd;
        b->cap = nc;
    }
    memcpy(b->data + b->len, p, n);
    b->len += n;
    return 0;
}

static void buf_free(buf_t *b) {
    free(b->data);
    b->data = NULL;
    b->len = b->cap = 0;
}

/* ------------------------------------------------------------------ */
/* H.264 RTP depayload (same logic as stream_server.py)                */
/* ------------------------------------------------------------------ */
static unsigned char *depayload_h264(const unsigned char *payload, size_t plen,
                                     size_t *outlen) {
    *outlen = 0;
    if (plen < 2)
        return NULL;

    int nal_type = payload[0] & 0x1F;
    buf_t b = { 0, 0, 0 };

    if (nal_type >= 1 && nal_type <= 23) {
        buf_append(&b, STREAM_START, 4);
        buf_append(&b, payload, plen);
    } else if (nal_type == 28) {
        unsigned char fu_ind  = payload[0];
        unsigned char fu_head = payload[1];
        if (fu_head & 0x80) {
            unsigned char nal = (fu_ind & 0xE0) | (fu_head & 0x1F);
            buf_append(&b, STREAM_START, 4);
            buf_append(&b, &nal, 1);
            buf_append(&b, payload + 2, plen - 2);
        } else {
            buf_append(&b, payload + 2, plen - 2);
        }
    } else if (nal_type == 24) {
        size_t i = 1;
        while (i + 2 <= plen) {
            size_t sz = ((size_t)payload[i] << 8) | payload[i + 1];
            i += 2;
            if (plen - i < sz)
                break;
            buf_append(&b, STREAM_START, 4);
            buf_append(&b, payload + i, sz);
            i += sz;
        }
    }

    *outlen = b.len;
    return b.data;
}

/* ------------------------------------------------------------------ */
/* write helper                                                        */
/* ------------------------------------------------------------------ */
static int write_all(int fd, const unsigned char *data, size_t len) {
    while (len > 0) {
        ssize_t n = write(fd, data, len);
        if (n < 0) {
            if (errno == EINTR)
                continue;
            return 0;
        }
        data += n;
        len -= (size_t)n;
    }
    return 1;
}

/* ------------------------------------------------------------------ */
/* RTSP over TLS                                                       */
/* ------------------------------------------------------------------ */
/* 从内嵌的 PEM 字节加载证书链（等价于 SSL_CTX_use_certificate_chain_file） */
static int use_cert_chain_mem(SSL_CTX *ctx, const unsigned char *p, size_t len) {
    BIO *bio = BIO_new_mem_buf(p, (int)len);
    if (!bio)
        return 0;

    X509 *cert = PEM_read_bio_X509(bio, NULL, NULL, NULL);
    if (!cert) {
        BIO_free(bio);
        return 0;
    }
    if (SSL_CTX_use_certificate(ctx, cert) != 1) {
        X509_free(cert);
        BIO_free(bio);
        return 0;
    }
    X509_free(cert);

    /* 证书链中剩余的中间证书 */
    while ((cert = PEM_read_bio_X509(bio, NULL, NULL, NULL)) != NULL) {
        if (SSL_CTX_add1_chain_cert(ctx, cert) != 1) {
            X509_free(cert);
            BIO_free(bio);
            return 0;
        }
        X509_free(cert);
    }
    BIO_free(bio);
    return 1;
}

/* 从内嵌的 PEM 字节加载私钥（等价于 SSL_CTX_use_PrivateKey_file） */
static int use_privkey_mem(SSL_CTX *ctx, const unsigned char *p, size_t len) {
    BIO *bio = BIO_new_mem_buf(p, (int)len);
    if (!bio)
        return 0;

    EVP_PKEY *pkey = PEM_read_bio_PrivateKey(bio, NULL, NULL, NULL);
    BIO_free(bio);
    if (!pkey)
        return 0;

    int ok = SSL_CTX_use_PrivateKey(ctx, pkey);
    EVP_PKEY_free(pkey);
    return ok == 1;
}

static SSL *new_conn(void) {
    struct addrinfo hints, *res;
    memset(&hints, 0, sizeof hints);
    hints.ai_family   = AF_INET;
    hints.ai_socktype = SOCK_STREAM;

    char port[16];
    snprintf(port, sizeof port, "%d", g_rtsp_port);
    if (getaddrinfo(g_rtsp_host, port, &hints, &res) != 0)
        return NULL;

    int fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol);
    if (fd < 0) {
        freeaddrinfo(res);
        return NULL;
    }

    struct timeval tv = { 8, 0 };
    setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof tv);
    setsockopt(fd, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof tv);
    fcntl(fd, F_SETFD, FD_CLOEXEC);

    if (connect(fd, res->ai_addr, res->ai_addrlen) != 0) {
        freeaddrinfo(res);
        close(fd);
        return NULL;
    }
    freeaddrinfo(res);

    SSL *ssl = SSL_new(g_ctx);
    if (!ssl) {
        close(fd);
        return NULL;
    }
    SSL_set_fd(ssl, fd);
    SSL_set_tlsext_host_name(ssl, g_rtsp_host);
    if (SSL_connect(ssl) != 1) {
        SSL_free(ssl);
        close(fd);
        return NULL;
    }
    return ssl;
}

static char *rtsp_send(SSL *ssl, const char *method, const char *url,
                       const char *hdrs) {
    char req[2048];
    long cseq = g_cseq++;
    int n = snprintf(req, sizeof req, "%s %s RTSP/1.0\r\nCSeq: %ld\r\n%s\r\n",
                     method, url, cseq, hdrs);
    if (n < 0 || (size_t)n >= sizeof req)
        return NULL;
    SSL_write(ssl, req, n);

    buf_t b = { 0, 0, 0 };
    char tmp[4096];
    while (1) {
        if (b.len >= 4 && memmem(b.data, b.len, "\r\n\r\n", 4))
            break;
        if (b.len >= 65536)
            break;
        int r = SSL_read(ssl, tmp, sizeof tmp);
        if (r <= 0)
            break;
        if (buf_append(&b, (unsigned char *)tmp, (size_t)r) != 0)
            break;
    }
    buf_append(&b, (const unsigned char *)"", 1);
    return (char *)b.data;
}

static char *header_value(const char *resp, const char *name) {
    const char *p = strstr(resp, name);
    if (!p)
        return NULL;
    p += strlen(name);
    while (*p == ' ' || *p == '\t')
        p++;
    const char *e = p;
    while (*e && *e != '\r' && *e != '\n' && *e != ';')
        e++;
    if (e == p)
        return NULL;
    return strndup(p, (size_t)(e - p));
}

static char *find_interleaved(const char *resp) {
    const char *p = strstr(resp, "Transport:");
    if (!p)
        return NULL;
    p = strstr(p, "interleaved=");
    if (!p)
        return NULL;
    p += strlen("interleaved=");
    const char *e = p;
    while (*e >= '0' && *e <= '9')
        e++;
    if (e == p)
        return NULL;
    return strndup(p, (size_t)(e - p));
}

static int find_controls(const char *r, char tracks[][128], int max) {
    int n = 0;
    const char *p = r;

    /* first try a=control:trackID=<digits> */
    while (n < max && (p = strstr(p, "a=control:trackID=")) != NULL) {
        p += strlen("a=control:trackID=");
        const char *e = p;
        while (*e >= '0' && *e <= '9')
            e++;
        if (e > p) {
            snprintf(tracks[n], 128, "trackID=%.*s", (int)(e - p), p);
            n++;
        }
        p = e;
    }

    /* fallback: a=control:<non-space> */
    if (n == 0) {
        p = r;
        while (n < max && (p = strstr(p, "a=control:")) != NULL) {
            p += strlen("a=control:");
            const char *e = p;
            while (*e && *e != '\r' && *e != '\n' && *e != ' ' && *e != '\t')
                e++;
            if (e > p && (size_t)(e - p) < 128) {
                snprintf(tracks[n], 128, "%.*s", (int)(e - p), p);
                n++;
            }
            p = e;
        }
    }

    return n;
}

/* ------------------------------------------------------------------ */
/* ffmpeg subprocess                                                   */
/* ------------------------------------------------------------------ */
typedef struct {
    pid_t pid;
    int   in_fd;   /* parent writes h264 -> child stdin  */
    int   out_fd;  /* parent reads mjpeg <- child stdout */
} proc_t;

static int start_ffmpeg(proc_t *pr) {
    int inpipe[2], outpipe[2];
    if (pipe(inpipe) != 0 || pipe(outpipe) != 0)
        return -1;

    pid_t pid = fork();
    if (pid < 0) {
        close(inpipe[0]); close(inpipe[1]);
        close(outpipe[0]); close(outpipe[1]);
        return -1;
    }

    if (pid == 0) {
        dup2(inpipe[0], 0);
        dup2(outpipe[1], 1);
        close(inpipe[0]); close(inpipe[1]);
        close(outpipe[0]); close(outpipe[1]);
        int dn = open("/dev/null", O_WRONLY);
        if (dn >= 0) {
            dup2(dn, 2);
            close(dn);
        }

        char *argv[] = {
            g_ffmpeg,
            "-hide_banner", "-y", "-loglevel", "error",
            "-f", "h264", "-i", "pipe:0",
            "-c:v", "mjpeg", "-q:v", "4", "-f", "mjpeg", "pipe:1",
            NULL
        };
        execv(g_ffmpeg, argv);
        _exit(127);
    }

    close(inpipe[0]);
    close(outpipe[1]);
    pr->pid    = pid;
    pr->in_fd  = inpipe[1];
    pr->out_fd = outpipe[0];
    return 0;
}

/* ------------------------------------------------------------------ */
/* mjpeg reader thread                                                 */
/* ------------------------------------------------------------------ */
static void *mjpeg_reader(void *arg) {
    int fd = (int)(intptr_t)arg;
    buf_t buf = { 0, 0, 0 };
    unsigned char chunk[65536];

    while (running) {
        ssize_t n = read(fd, chunk, sizeof chunk);
        if (n <= 0)
            break;
        buf_append(&buf, chunk, (size_t)n);

        while (1) {
            unsigned char *s = memmem(buf.data, buf.len, "\xff\xd8", 2);
            size_t s_idx = s ? (size_t)(s - buf.data) : (size_t)-1;
            size_t e_idx = (size_t)-1;
            if (s_idx != (size_t)-1) {
                unsigned char *e = memmem(buf.data + s_idx + 2,
                                          buf.len - s_idx - 2, "\xff\xd9", 2);
                if (e)
                    e_idx = (size_t)(e - buf.data);
            }

            if (s_idx == (size_t)-1 || e_idx == (size_t)-1) {
                if (s_idx != (size_t)-1 && s_idx > 0) {
                    memmove(buf.data, buf.data + s_idx, buf.len - s_idx);
                    buf.len -= s_idx;
                }
                break;
            }

            size_t jlen = e_idx + 2 - s_idx;
            unsigned char *jpg = malloc(jlen);
            if (jpg) {
                memcpy(jpg, buf.data + s_idx, jlen);
            }

            size_t consumed = e_idx + 2;
            memmove(buf.data, buf.data + consumed, buf.len - consumed);
            buf.len -= consumed;

            if (jpg) {
                pthread_mutex_lock(&state_mutex);
                free(latest_jpeg);
                latest_jpeg = jpg;
                latest_jpeg_len = jlen;
                frame_seq++;
                pthread_cond_broadcast(&state_cond);
                pthread_mutex_unlock(&state_mutex);
            }
        }
    }

    buf_free(&buf);
    return NULL;
}

/* ------------------------------------------------------------------ */
/* stream worker thread                                                */
/* ------------------------------------------------------------------ */
static void *stream_worker(void *arg) {
    (void)arg;

    while (running) {
        SSL *ssl = NULL;
        proc_t pr;
        memset(&pr, 0, sizeof pr);
        pr.in_fd = -1;
        pr.out_fd = -1;
        pthread_t reader;
        int reader_started = 0;

        ssl = new_conn();
        if (!ssl) {
            if (running) {
                printf("[!] RTSP 连接失败\n");
                printf("[*] 3s 后重连...\n");
                sleep(3);
            }
            continue;
        }

        g_cseq = 1;

        char *opt = rtsp_send(ssl, "OPTIONS", g_base_url, "User-Agent: stream_proxy\r\n");
        free(opt);

        char *desc = rtsp_send(ssl, "DESCRIBE", g_base_url, "Accept: application/sdp\r\n");
        char tracks[16][128];
        int ntracks = desc ? find_controls(desc, tracks, 16) : 0;
        char sess[256] = { 0 };
        int vid_chan = 0;

        for (int i = 0; i < ntracks; i++) {
            char url[640];
            snprintf(url, sizeof url, "%s/%.127s", g_base_url, tracks[i]);
            char transport[256];
            snprintf(transport, sizeof transport,
                     "Transport: RTP/AVP/TCP;unicast;interleaved=%d-%d\r\n",
                     i * 2, i * 2 + 1);
            char *rr = rtsp_send(ssl, "SETUP", url, transport);
            if (rr) {
                char *s = header_value(rr, "Session:");
                if (s) {
                    strncpy(sess, s, sizeof sess - 1);
                    free(s);
                }
                char *tr = find_interleaved(rr);
                if (tr) {
                    if (i == 0)
                        vid_chan = atoi(tr);
                    free(tr);
                }
                free(rr);
            }
        }
        free(desc);

        char play[320];
        snprintf(play, sizeof play, "Session: %s\r\n", sess);
        char *prr = rtsp_send(ssl, "PLAY", g_base_url, play);
        free(prr);

        printf("[*] RTSP PLAY ok, video ch = %d\n", vid_chan);

        if (start_ffmpeg(&pr) != 0) {
            printf("[!] ffmpeg 启动失败\n");
            goto cleanup;
        }
        if (pthread_create(&reader, NULL, mjpeg_reader, (void *)(intptr_t)pr.out_fd) != 0) {
            printf("[!] 读取线程创建失败\n");
            goto cleanup;
        }
        reader_started = 1;

        {
            buf_t lb = { 0, 0, 0 };
            unsigned char tmp[65536];
            while (running) {
                if (lb.len == 0) {
                    int n = SSL_read(ssl, tmp, sizeof tmp);
                    if (n <= 0)
                        break;
                    if (buf_append(&lb, tmp, (size_t)n) != 0)
                        break;
                }

                if (lb.len < 4) {
                    int n = SSL_read(ssl, tmp, sizeof tmp);
                    if (n <= 0)
                        break;
                    if (buf_append(&lb, tmp, (size_t)n) != 0)
                        break;
                    continue;
                }

                unsigned chan = lb.data[1];
                unsigned plen = ((unsigned)lb.data[2] << 8) | lb.data[3];

                if (lb.len < 4 + plen) {
                    int n = SSL_read(ssl, tmp, sizeof tmp);
                    if (n <= 0)
                        break;
                    if (buf_append(&lb, tmp, (size_t)n) != 0)
                        break;
                    continue;
                }

                unsigned char *pkt = lb.data + 4;
                int write_failed = 0;

                if (chan != (unsigned)vid_chan || plen < 12) {
                    /* skip */
                } else if ((pkt[1] & 0x7F) != 96) {
                    /* skip */
                } else {
                    size_t outlen = 0;
                    unsigned char *out = depayload_h264(pkt + 12, plen - 12, &outlen);
                    if (out && outlen) {
                        if (!write_all(pr.in_fd, out, outlen))
                            write_failed = 1;
                    }
                    free(out);
                }

                size_t consumed = 4 + plen;
                memmove(lb.data, lb.data + consumed, lb.len - consumed);
                lb.len -= consumed;

                if (write_failed)
                    break;
            }
            buf_free(&lb);
        }

cleanup:
        if (pr.in_fd >= 0) {
            close(pr.in_fd);
            pr.in_fd = -1;
        }
        if (reader_started)
            pthread_join(reader, NULL);
        if (pr.pid > 0)
            waitpid(pr.pid, NULL, 0);
        if (pr.out_fd >= 0)
            close(pr.out_fd);

        if (ssl) {
            int fd = SSL_get_fd(ssl);
            SSL_free(ssl);
            if (fd >= 0)
                close(fd);
        }

        if (running) {
            printf("[*] 3s 后重连...\n");
            sleep(3);
        }
    }

    return NULL;
}

/* ------------------------------------------------------------------ */
/* HTTP helpers                                                        */
/* ------------------------------------------------------------------ */
static int send_all(int fd, const void *data, size_t len) {
    const char *p = data;
    while (len > 0) {
        ssize_t n = send(fd, p, len, MSG_NOSIGNAL);
        if (n <= 0)
            return 0;
        p += n;
        len -= (size_t)n;
    }
    return 1;
}

static void send_line(int fd, const char *fmt, ...) {
    char buf[1024];
    va_list ap;
    va_start(ap, fmt);
    int n = vsnprintf(buf, sizeof buf, fmt, ap);
    va_end(ap);
    if (n > 0)
        send_all(fd, buf, (size_t)n);
}

static void hdr(int fd, const char *name, const char *val) {
    send_line(fd, "%s: %s\r\n", name, val);
}

static int header_has_value(const char *req, const char *name, const char *val) {
    const char *p = req;
    size_t nlen = strlen(name);
    size_t vlen = strlen(val);
    while (*p) {
        const char *eol = strstr(p, "\r\n");
        if (!eol)
            break;
        size_t linelen = (size_t)(eol - p);
        if (linelen == 0)
            break; /* end of headers */
        if (linelen > nlen && strncasecmp(p, name, nlen) == 0) {
            const char *v = p + nlen;
            while (*v == ' ' || *v == '\t')
                v++;
            if (strncasecmp(v, val, vlen) == 0)
                return 1;
        }
        p = eol + 2;
    }
    return 0;
}

static void stream_mjpeg(int fd) {
    send_line(fd, "HTTP/1.1 200 OK\r\n");
    hdr(fd, "Content-Type", "multipart/x-mixed-replace; boundary=frame");
    hdr(fd, "Cache-Control", "no-cache");
    hdr(fd, "Connection", "close");
    send_line(fd, "\r\n");

    uint64_t last_sent = UINT64_MAX;
    while (running) {
        unsigned char *data = NULL;
        size_t dlen = 0;

        pthread_mutex_lock(&state_mutex);
        if (frame_seq != last_sent) {
            last_sent = frame_seq;
            if (latest_jpeg) {
                data = malloc(latest_jpeg_len);
                if (data) {
                    memcpy(data, latest_jpeg, latest_jpeg_len);
                    dlen = latest_jpeg_len;
                }
            }
            pthread_mutex_unlock(&state_mutex);
        } else {
            struct timespec ts;
            clock_gettime(CLOCK_REALTIME, &ts);
            ts.tv_sec += 2;
            int rc = pthread_cond_timedwait(&state_cond, &state_mutex, &ts);
            pthread_mutex_unlock(&state_mutex);
            if (rc == ETIMEDOUT) {
                /* 无新帧时，检查连接是否已被服务端 shutdown（踢除） */
                char b;
                ssize_t r = recv(fd, &b, 1, MSG_PEEK | MSG_DONTWAIT);
                if (r == 0)
                    break;
            }
            continue;
        }

        if (data) {
            char head[256];
            int hl = snprintf(head, sizeof head,
                              "--frame\r\nContent-Type: image/jpeg\r\n"
                              "Content-Length: %zu\r\n\r\n", dlen);
            int ok = send_all(fd, head, (size_t)hl) &&
                     send_all(fd, data, dlen) &&
                     send_all(fd, "\r\n", 2);
            free(data);
            if (!ok)
                break;  /* 对端断开或被服务端主动踢除 */
        }
    }
}

#define HTML_PAGE   _binary_index_html_start
#define HTML_LEN    ((size_t)(_binary_index_html_end - _binary_index_html_start))

static void handle_get(int fd, const char *path, int *close_conn) {
    if (strcmp(path, "/") == 0 || strcmp(path, "/index.html") == 0) {
        send_line(fd, "HTTP/1.1 200 OK\r\n");
        hdr(fd, "Content-Type", "text/html; charset=utf-8");
        send_line(fd, "Content-Length: %zu\r\n", HTML_LEN);
        send_line(fd, "\r\n");
        send_all(fd, HTML_PAGE, HTML_LEN);
        return;
    }

    if (strcmp(path, "/stream") == 0) {
        *close_conn = 1;
        stream_mjpeg(fd);
        return;
    }

    if (strcmp(path, "/snapshot.jpg") == 0) {
        unsigned char *snap = NULL;
        size_t slen = 0;
        pthread_mutex_lock(&state_mutex);
        if (latest_jpeg) {
            snap = malloc(latest_jpeg_len);
            if (snap) {
                memcpy(snap, latest_jpeg, latest_jpeg_len);
                slen = latest_jpeg_len;
            }
        }
        pthread_mutex_unlock(&state_mutex);

        if (!snap) {
            send_line(fd, "HTTP/1.1 503 Service Unavailable\r\n");
            send_line(fd, "\r\n");
            return;
        }

        send_line(fd, "HTTP/1.1 200 OK\r\n");
        hdr(fd, "Content-Type", "image/jpeg");
        send_line(fd, "Content-Length: %zu\r\n", slen);
        hdr(fd, "Cache-Control", "no-cache");
        send_line(fd, "\r\n");
        send_all(fd, snap, slen);
        free(snap);
        return;
    }

    send_line(fd, "HTTP/1.1 404 Not Found\r\n");
    send_line(fd, "\r\n");
}

static void handle_head(int fd, const char *path) {
    (void)path;
    send_line(fd, "HTTP/1.1 200 OK\r\n");
    hdr(fd, "Content-Type", "text/html; charset=utf-8");
    send_line(fd, "\r\n");
}

static int http_read_request(int fd, char *buf, size_t bufsz) {
    size_t len = 0;
    while (len < bufsz - 1) {
        ssize_t n = read(fd, buf + len, bufsz - 1 - len);
        if (n <= 0)
            return -1;
        len += (size_t)n;
        buf[len] = '\0';
        if (memmem(buf, len, "\r\n\r\n", 4))
            return 0;
    }
    return -1;
}

/* ------------------------------------------------------------------ */
/* 客户端连接数管理                                                    */
/* ------------------------------------------------------------------ */
/* 登记一个新客户端。若已达上限，则 shutdown 最旧的连接将其踢除。
   注意：这里只 shutdown 不 close，避免 fd 号被复用；由被踢客户端线程
   自行检测失败后关闭并注销。 */
static void client_register(int fd) {
    pthread_mutex_lock(&client_mutex);
    if (g_client_count >= g_max_clients && g_client_count > 0) {
        int oldest = g_client_fds[0];
        shutdown(oldest, SHUT_RDWR);
        memmove(&g_client_fds[0], &g_client_fds[1],
                (size_t)(g_client_count - 1) * sizeof(int));
        g_client_count--;
        printf("[*] 客户端数已达上限(%d)，已断开最旧连接\n", g_max_clients);
    }
    g_client_fds[g_client_count++] = fd;
    pthread_mutex_unlock(&client_mutex);
}

/* 注销客户端。fd 可能已被 client_register 踢除，因此查找失败时静默忽略。 */
static void client_deregister(int fd) {
    if (!g_client_fds)
        return;
    pthread_mutex_lock(&client_mutex);
    for (int i = 0; i < g_client_count; i++) {
        if (g_client_fds[i] == fd) {
            memmove(&g_client_fds[i], &g_client_fds[i + 1],
                    (size_t)(g_client_count - i - 1) * sizeof(int));
            g_client_count--;
            break;
        }
    }
    pthread_mutex_unlock(&client_mutex);
}

static void *client_handler(void *arg) {
    int fd = (int)(intptr_t)arg;
    struct timeval tv = { 30, 0 };
    setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof tv);

    char req[16384];
    int close_conn = 1;

    do {
        if (http_read_request(fd, req, sizeof req) != 0)
            break;

        char *line_end = strstr(req, "\r\n");
        if (!line_end)
            break;
        *line_end = '\0';

        char method[16] = { 0 }, path[1024] = { 0 }, ver[16] = { 0 };
        sscanf(req, "%15s %1023s %15s", method, path, ver);

        close_conn = 1;
        if (strncmp(ver, "HTTP/1.1", 8) == 0 &&
            header_has_value(req, "Connection:", "keep-alive")) {
            close_conn = 0;
        }

        if (strcmp(method, "GET") == 0) {
            handle_get(fd, path, &close_conn);
        } else if (strcmp(method, "HEAD") == 0) {
            handle_head(fd, path);
        } else {
            send_line(fd, "HTTP/1.1 501 Unsupported method\r\n");
            send_line(fd, "Content-Length: 0\r\n");
            send_line(fd, "\r\n");
            close_conn = 1;
        }
    } while (!close_conn && running);

    client_deregister(fd);
    close(fd);
    return NULL;
}

/* ------------------------------------------------------------------ */
/* main                                                                */
/* ------------------------------------------------------------------ */
static void on_signal(int sig) {
    (void)sig;
    running = 0;
    if (g_listen_fd >= 0)
        close(g_listen_fd);
}

static void usage(const char *prog) {
    printf(
        "用法: %s [选项] [http端口]\n"
        "\n"
        "Baby Monitor RTSP-over-TLS 转 MJPEG HTTP 流媒体服务\n"
        "\n"
        "选项:\n"
        "  -H, --host HOST        RTSP 服务器地址        (默认: %s)\n"
        "  -P, --rtsp-port PORT   RTSP 端口              (默认: %d)\n"
        "  -u, --base-url URL     RTSP 基础 URL          (默认: %s)\n"
        "  -f, --ffmpeg PATH      ffmpeg 可执行文件路径   (默认: %s)\n"
        "  -p, --http-port PORT   HTTP 监听端口          (默认: %d)\n"
        "  -m, --max-clients N    同时允许的客户端数      (默认: %d)\n"
        "  -h, --help             显示本帮助\n"
        "\n"
        "示例:\n"
        "  %s\n"
        "  %s --host 192.168.1.100 --rtsp-port 554 \\\n"
        "      --base-url rtsp://192.168.1.100:554/ch0\n"
        "  %s -p 9000\n"
        "  %s -m 5\n",
        prog,
        g_rtsp_host, g_rtsp_port, g_base_url, g_ffmpeg, DEFAULT_HTTP_PORT,
        g_max_clients,
        prog, prog, prog, prog);
}

int main(int argc, char **argv) {
    static const struct option long_opts[] = {
        { "host",        required_argument, NULL, 'H' },
        { "rtsp-port",   required_argument, NULL, 'P' },
        { "base-url",    required_argument, NULL, 'u' },
        { "ffmpeg",      required_argument, NULL, 'f' },
        { "http-port",   required_argument, NULL, 'p' },
        { "max-clients", required_argument, NULL, 'm' },
        { "help",        no_argument,       NULL, 'h' },
        { NULL, 0, NULL, 0 }
    };

    int http_port = DEFAULT_HTTP_PORT;
    int c;
    while ((c = getopt_long(argc, argv, "H:P:u:f:p:m:h", long_opts, NULL)) != -1) {
        switch (c) {
        case 'H':
            snprintf(g_rtsp_host, sizeof g_rtsp_host, "%s", optarg);
            break;
        case 'P':
            g_rtsp_port = atoi(optarg);
            break;
        case 'u':
            snprintf(g_base_url, sizeof g_base_url, "%s", optarg);
            break;
        case 'f':
            snprintf(g_ffmpeg, sizeof g_ffmpeg, "%s", optarg);
            break;
        case 'p':
            http_port = atoi(optarg);
            break;
        case 'm':
            g_max_clients = atoi(optarg);
            if (g_max_clients < 1)
                g_max_clients = 1;
            break;
        case 'h':
            usage(argv[0]);
            return 0;
        default:
            usage(argv[0]);
            return 2;
        }
    }
    /* 兼容旧用法：位置参数作为 HTTP 监听端口 */
    if (optind < argc)
        http_port = atoi(argv[optind]);

    /* 按最大客户端数分配连接登记表 */
    g_client_fds = calloc((size_t)g_max_clients, sizeof(int));
    if (!g_client_fds) {
        fprintf(stderr, "[!] 内存分配失败\n");
        return 1;
    }

    signal(SIGPIPE, SIG_IGN);
    signal(SIGINT, on_signal);
    signal(SIGTERM, on_signal);

    g_ctx = SSL_CTX_new(TLS_client_method());
    if (!g_ctx) {
        fprintf(stderr, "[!] SSL_CTX_new 失败\n");
        return 1;
    }
    SSL_CTX_set_verify(g_ctx, SSL_VERIFY_NONE, NULL);

    use_cert_chain_mem(g_ctx,
                       _binary_config_plain_cert_cam_cert_pem_start,
                       (size_t)(_binary_config_plain_cert_cam_cert_pem_end -
                                _binary_config_plain_cert_cam_cert_pem_start));
    use_privkey_mem(g_ctx,
                    _binary_config_plain_cert_cam_key_pem_start,
                    (size_t)(_binary_config_plain_cert_cam_key_pem_end -
                             _binary_config_plain_cert_cam_key_pem_start));
    SSL_CTX_check_private_key(g_ctx);

    pthread_t worker;
    if (pthread_create(&worker, NULL, stream_worker, NULL) == 0)
        pthread_detach(worker);

    int lfd = socket(AF_INET, SOCK_STREAM, 0);
    if (lfd < 0) {
        fprintf(stderr, "[!] socket 失败\n");
        return 1;
    }
    int yes = 1;
    setsockopt(lfd, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof yes);

    struct sockaddr_in addr;
    memset(&addr, 0, sizeof addr);
    addr.sin_family      = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port        = htons((uint16_t)http_port);

    if (bind(lfd, (struct sockaddr *)&addr, sizeof addr) != 0) {
        fprintf(stderr, "[!] bind 失败\n");
        close(lfd);
        return 1;
    }
    if (listen(lfd, 128) != 0) {
        fprintf(stderr, "[!] listen 失败\n");
        close(lfd);
        return 1;
    }
    g_listen_fd = lfd;

    printf("[*] HTTP 服务已启动: http://0.0.0.0:%d  (Ctrl-C 停止)\n", http_port);
    printf("[*] 最大并发客户端数: %d\n", g_max_clients);

    while (running) {
        struct sockaddr_in cli;
        socklen_t clen = sizeof cli;
        int cfd = accept(lfd, (struct sockaddr *)&cli, &clen);
        if (cfd < 0) {
            if (!running)
                break;
            continue;
        }
        client_register(cfd);
        pthread_t th;
        if (pthread_create(&th, NULL, client_handler, (void *)(intptr_t)cfd) != 0) {
            client_deregister(cfd);
            close(cfd);
        } else {
            pthread_detach(th);
        }
    }

    running = 0;
    if (lfd >= 0)
        close(lfd);
    sleep(1);
    SSL_CTX_free(g_ctx);
    printf("[*] 已停止\n");
    return 0;
}