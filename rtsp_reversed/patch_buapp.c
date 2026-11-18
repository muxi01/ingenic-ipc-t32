/*
 * patch_buapp.c —— 修改 bu_app.bin 中硬编码的 RTSP 视频编码参数。
 *
 * 编译：
 *     gcc -O2 -Wall -Wextra -o patch_buapp patch_buapp.c
 *
 * 用法示例：
 *     ./patch_buapp --width 1920 --height 1080 --fps 25 --bitrate 3000
 *     ./patch_buapp -i bu_app.bin -o bu_app_patched --width 1280 --height 720
 *
 * 说明：
 *   * 默认输入 bu_app.bin，默认输出 输入名 + "_patched"
 *   * 默认不改任何参数（纯备份）
 *   * width 须 16 对齐，height 须 2 对齐
 *   * 拒绝覆盖输入文件，拒绝覆盖已存在的输出文件
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <errno.h>
#include <unistd.h>
#include <sys/stat.h>

#define VERSION "1.0.0"

/* fileoff = VA - 0x400000 */
#define VA_FILE_BASE 0x400000u

typedef struct {
    const char *name;
    uint32_t va;
    int32_t  def;
    int      expected_rt;
} patch_slot_t;

static const patch_slot_t PATCH_SLOTS[] = {
    { "width",   0x436c38, 864,  4 },
    { "height",  0x436c40, 480,  4 },
    { "bitrate", 0x436c48, 1200, 4 },
    { "fps",     0x436c68, 20,   3 },
};
#define NUM_SLOTS (sizeof(PATCH_SLOTS) / sizeof(PATCH_SLOTS[0]))

/* ---------------- 参数解析 ---------------- */

typedef struct {
    const char *input;
    const char *output;
    int has_width, has_height, has_fps, has_bitrate;
    int32_t width, height, fps, bitrate;
} options_t;


static void usage(const char *prog) {
    fprintf(stderr,
        "用法: %s [选项]\n"
        "选项:\n"
        "  -i, --input PATH      输入二进制 (默认 bu_app.bin)\n"
        "  -o, --output PATH     输出二进制 (默认 <input>_patched)\n"
        "      --width N         编码宽度 (须 16 对齐)\n"
        "      --height N        编码高度 (须 2 对齐)\n"
        "      --fps N           帧率\n"
        "      --bitrate N       码率 (kbps)\n"
        "  -h, --help            显示帮助\n"
        "  -V, --version         显示版本\n"
        "\n"
        "说明:\n"
        "  * 未指定的参数保持原厂默认 (864x480@20fps, 1200kbps)\n"
        "  * 默认输出名 = <input>_patched，绝不改写原文件\n"
        "  * width 须 16 对齐，height 须 2 对齐\n"
        "\n"
        "常见用法（分辨率 / 帧率 / 码率）:\n"
        "\n"
        "  # 1080p (1920x1080) @25fps / 3 Mbps\n"
        "  %s --width 1920 --height 1080 --fps 25 --bitrate 3000\n"
        "\n"
        "  # 720p  (1280x720)  @25fps / 1.6 Mbps\n"
        "  %s --width 1280 --height 720 --fps 25 --bitrate 1600\n"
        "\n"
        "  # 480p  (864x480)   @20fps / 1.2 Mbps（原厂等价参数）\n"
        "  %s --width 864 --height 480 --fps 20 --bitrate 1200\n",
        prog, prog, prog, prog);
}


static int parse_int(const char *s, int32_t *out) {
    char *end = NULL;
    errno = 0;
    long v = strtol(s, &end, 10);
    if (errno || end == s || *end != '\0') return -1;
    if (v < INT32_MIN || v > INT32_MAX) return -1;
    *out = (int32_t)v;
    return 0;
}

static int parse_args(int argc, char **argv, options_t *o) {
    memset(o, 0, sizeof(*o));
    o->input = "bu_app.bin";

    for (int i = 1; i < argc; i++) {
        const char *a = argv[i];
        const char *val = NULL;
        const char *eq = strchr(a, '=');

        /* 支持 --key=value 与 --key value 两种形式 */
        char keybuf[64];
        if (eq && a[0] == '-' && a[1] == '-') {
            size_t klen = (size_t)(eq - a);
            if (klen >= sizeof(keybuf)) return -1;
            memcpy(keybuf, a, klen);
            keybuf[klen] = '\0';
            a = keybuf;
            val = eq + 1;
        }

        if (!strcmp(a, "-h") || !strcmp(a, "--help")) {
            usage(argv[0]);
            exit(0);
        } else if (!strcmp(a, "-V") || !strcmp(a, "--version")) {
            printf("patch_buapp %s\n", VERSION);
            exit(0);
        } else if (!strcmp(a, "-i") || !strcmp(a, "--input")) {
            o->input = val ? val : (++i < argc ? argv[i] : NULL);
            if (!o->input) { fprintf(stderr, "缺少 --input 参数值\n"); return -1; }
        } else if (!strcmp(a, "-o") || !strcmp(a, "--output")) {
            o->output = val ? val : (++i < argc ? argv[i] : NULL);
            if (!o->output) { fprintf(stderr, "缺少 --output 参数值\n"); return -1; }
        } else if (!strcmp(a, "--width") || !strcmp(a, "--height") ||
                   !strcmp(a, "--fps")   || !strcmp(a, "--bitrate")) {
            const char *sv = val ? val : (++i < argc ? argv[i] : NULL);
            if (!sv) { fprintf(stderr, "缺少 %s 参数值\n", a); return -1; }
            int32_t n;
            if (parse_int(sv, &n) != 0) {
                fprintf(stderr, "%s 需要整数，得到 '%s'\n", a, sv);
                return -1;
            }
            if      (!strcmp(a, "--width"))   { o->width   = n; o->has_width   = 1; }
            else if (!strcmp(a, "--height"))  { o->height  = n; o->has_height  = 1; }
            else if (!strcmp(a, "--fps"))     { o->fps     = n; o->has_fps     = 1; }
            else if (!strcmp(a, "--bitrate")) { o->bitrate = n; o->has_bitrate = 1; }
        } else {
            fprintf(stderr, "未知参数: %s\n", a);
            usage(argv[0]);
            return -1;
        }
    }
    return 0;
}

/* ---------------- 文件 I/O ---------------- */

static uint8_t *read_file(const char *path, size_t *out_size) {
    FILE *f = fopen(path, "rb");
    if (!f) return NULL;
    if (fseek(f, 0, SEEK_END) != 0) { fclose(f); return NULL; }
    long sz = ftell(f);
    if (sz < 0) { fclose(f); return NULL; }
    rewind(f);
    uint8_t *buf = malloc((size_t)sz ? (size_t)sz : 1);
    if (!buf) { fclose(f); return NULL; }
    if (sz > 0 && fread(buf, 1, (size_t)sz, f) != (size_t)sz) {
        free(buf); fclose(f); return NULL;
    }
    fclose(f);
    *out_size = (size_t)sz;
    return buf;
}

static int write_file(const char *path, const uint8_t *buf, size_t sz) {
    FILE *f = fopen(path, "wb");
    if (!f) return -1;
    if (sz && fwrite(buf, 1, sz, f) != sz) { fclose(f); return -1; }
    if (fclose(f) != 0) return -1;
    return 0;
}

static int same_path(const char *a, const char *b) {
    char ra[4096], rb[4096];
    if (!realpath(a, ra) || !realpath(b, rb)) {
        /* realpath 对不存在路径会失败，退化到字符串比较 */
        return strcmp(a, b) == 0;
    }
    return strcmp(ra, rb) == 0;
}

/* ---------------- 指令处理 ---------------- */

typedef struct {
    uint32_t op, rs, rt;
    int32_t  imm;
    size_t   off;
} ins_t;

static int load_ins(const uint8_t *data, size_t size, uint32_t va, ins_t *out) {
    if (va < VA_FILE_BASE) return -1;
    size_t off = (size_t)(va - VA_FILE_BASE);
    if (off + 4 > size) return -1;

    uint32_t ins = (uint32_t)data[off]
                 | ((uint32_t)data[off + 1] << 8)
                 | ((uint32_t)data[off + 2] << 16)
                 | ((uint32_t)data[off + 3] << 24);

    out->op  = ins >> 26;
    out->rs  = (ins >> 21) & 0x1f;
    out->rt  = (ins >> 16) & 0x1f;
    uint32_t u = ins & 0xffff;
    out->imm = (u & 0x8000u) ? (int32_t)(u - 0x10000u) : (int32_t)u;
    out->off = off;
    return 0;
}

static int patch_value(uint8_t *data, size_t size, uint32_t va,
                       int32_t new_imm, int expected_rt, int32_t *old_out) {
    ins_t in;
    if (load_ins(data, size, va, &in) != 0) {
        fprintf(stderr, "VA %#x: 无法读取（文件过短或基址不对）\n", va);
        return -1;
    }
    if (!(in.op == 0x09 && in.rs == 0 && (in.rt == 3 || in.rt == 4)) ||
        in.rt != (uint32_t)expected_rt) {
        fprintf(stderr,
            "VA %#x: 目标地址并非 addiu rt,$zero 指令 "
            "(op=%u rs=%u rt=%u), 文件可能已被修改或基址不对。\n",
            va, in.op, in.rs, in.rt);
        return -1;
    }
    if (new_imm < 0 || new_imm > 0x7fff) {
        fprintf(stderr,
            "VA %#x: 立即数 %d 超出 addiu 正立即数范围 [0, 32767]。\n",
            va, new_imm);
        return -1;
    }

    uint32_t nins = (0x24000000u | (in.rt << 16)) & 0xffffffffu;
    nins |= (uint32_t)new_imm & 0xffffu;

    data[in.off + 0] = (uint8_t)(nins & 0xff);
    data[in.off + 1] = (uint8_t)((nins >> 8) & 0xff);
    data[in.off + 2] = (uint8_t)((nins >> 16) & 0xff);
    data[in.off + 3] = (uint8_t)((nins >> 24) & 0xff);

    if (old_out) *old_out = in.imm;
    return 0;
}

/* ---------------- main ---------------- */

int main(int argc, char **argv) {
    options_t opt;
    if (parse_args(argc, argv, &opt) != 0) return 2;

    struct stat st;
    if (stat(opt.input, &st) != 0) {
        fprintf(stderr, "找不到输入文件: %s\n", opt.input);
        return 1;
    }

    size_t size = 0;
    uint8_t *data = read_file(opt.input, &size);
    if (!data) {
        fprintf(stderr, "读取输入文件失败: %s\n", opt.input);
        return 1;
    }

    /* 决定输出路径 */
    char *output = NULL;
    if (opt.output) {
        output = strdup(opt.output);
    } else {
        size_t n = strlen(opt.input) + strlen("_patched") + 1;
        output = malloc(n);
        if (output) snprintf(output, n, "%s_patched", opt.input);
    }
    if (!output) { free(data); fprintf(stderr, "内存不足\n"); return 1; }

    if (same_path(output, opt.input)) {
        fprintf(stderr, "拒绝：输出路径 %s 与输入相同，会覆盖原文件。\n", output);
        free(output); free(data); return 1;
    }
    if (stat(output, &st) == 0) {
        fprintf(stderr,
            "拒绝：输出文件 %s 已存在，为避免覆盖旧补丁请先移除或改用 -o 指定其它路径。\n",
            output);
        free(output); free(data); return 1;
    }

    /* 目标值 */
    int32_t width   = opt.has_width   ? opt.width   : PATCH_SLOTS[0].def;
    int32_t height  = opt.has_height  ? opt.height  : PATCH_SLOTS[1].def;
    int32_t bitrate = opt.has_bitrate ? opt.bitrate : PATCH_SLOTS[2].def;
    int32_t fps     = opt.has_fps     ? opt.fps     : PATCH_SLOTS[3].def;

    if (width % 16 != 0) {
        fprintf(stderr, "宽度 %d 未 16 对齐（固件约束 width align 16）。\n", width);
        free(output); free(data); return 1;
    }
    if (height % 2 != 0) {
        fprintf(stderr, "高度 %d 未 2 对齐（固件约束 height align 2）。\n", height);
        free(output); free(data); return 1;
    }

    int32_t desired[NUM_SLOTS];
    desired[0] = width;
    desired[1] = height;
    desired[2] = bitrate;
    desired[3] = fps;

    printf("输入 : %s (%zu bytes)\n", opt.input, size);

    int patched = 0;
    int failed  = 0;
    for (size_t i = 0; i < NUM_SLOTS; i++) {
        const patch_slot_t *s = &PATCH_SLOTS[i];
        ins_t in;
        if (load_ins(data, size, s->va, &in) != 0) {
            fprintf(stderr, "  ! %-7s VA %#08x: 读取失败\n", s->name, s->va);
            failed = 1;
            continue;
        }
        int32_t newv = desired[i];
        if (in.imm == newv) {
            printf("  - %-7s VA %#08x: 保持 %d\n", s->name, s->va, in.imm);
            continue;
        }
        int32_t old = 0;
        if (patch_value(data, size, s->va, newv, s->expected_rt, &old) != 0) {
            failed = 1;
            continue;
        }
        printf("  * %-7s VA %#08x: %d -> %d\n", s->name, s->va, old, newv);
        patched = 1;
    }

    if (failed) {
        fprintf(stderr, "存在错误，未写出输出文件。\n");
        free(output); free(data); return 1;
    }

    if (!patched)
        printf("无任何参数需要修改，原样写出: %s\n", output);
    else
        printf("写出补丁后二进制: %s\n", output);

    if (write_file(output, data, size) != 0) {
        fprintf(stderr, "写出文件失败: %s\n", output);
        free(output); free(data); return 1;
    }

    free(output);
    free(data);
    return 0;
}

