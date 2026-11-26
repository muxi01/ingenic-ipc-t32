CC      ?= gcc
CFLAGS  ?= -O2 -g -Wall -Wextra
LDLIBS  ?= -lssl -lcrypto -lpthread

TARGET  := stream_server
SRC     := stream_server.c
OBJDIR  := obj

# 内嵌资源：HTML 页面与安全认证文件
EMBED_FILES := index.html \
               config/plain_cert/ca_cert.pem \
               config/plain_cert/cam_cert.pem \
               config/plain_cert/cam_key.pem

# 每个文件通过 ld -r -b binary 生成 .o，符号名由输入文件路径派生
EMBED_OBJS := $(addprefix $(OBJDIR)/, $(addsuffix .o, $(notdir $(EMBED_FILES))))

all: $(TARGET)

$(OBJDIR)/index.html.o: index.html
	@mkdir -p $(OBJDIR)
	ld -r -b binary -o $@ $<

$(OBJDIR)/ca_cert.pem.o: config/plain_cert/ca_cert.pem
	@mkdir -p $(OBJDIR)
	ld -r -b binary -o $@ $<

$(OBJDIR)/cam_cert.pem.o: config/plain_cert/cam_cert.pem
	@mkdir -p $(OBJDIR)
	ld -r -b binary -o $@ $<

$(OBJDIR)/cam_key.pem.o: config/plain_cert/cam_key.pem
	@mkdir -p $(OBJDIR)
	ld -r -b binary -o $@ $<

$(TARGET): $(SRC) $(EMBED_OBJS)
	$(CC) $(CFLAGS) -o $@ $(SRC) $(EMBED_OBJS) $(LDLIBS)

clean:
	rm -rf $(TARGET) $(OBJDIR)

.PHONY: all clean