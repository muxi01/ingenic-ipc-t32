
# 一、以太网信息:
```
usb0      Link encap:Ethernet  HWaddr 2A:73:D7:CC:68:B6  
          inet addr:192.168.172.1  Bcast:192.168.172.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

wlan0     Link encap:Ethernet  HWaddr 74:52:CE:03:30:C7  
          inet addr:192.168.170.1  Bcast:192.168.170.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:539 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000 
          RX bytes:0 (0.0 B)  TX bytes:22638 (22.1 KiB)
```
# 二、主线程
```
 707     1 root     S     197m479.3   0 19.1 ./bu_app 1
 ```
- kill -9 707 杀死主线程防止日志过多，干扰串口。telnet登陆无需执行
 
# 三、telnet 登陆
- ifconfig usb0 up 
- ifconfig usb0 192.168.172.2 #rndis USB 以太网配置为 192.168.172.2
- telnet 192.168.172.1        #即可使用root 登陆，无密码

# 四、分区信息查看

[root@Ingenic-uc1_1:proc]# cat mtd
```
dev:    size   erasesize  name
mtd0: 00200000 00020000 "uboot"
mtd1: 00500000 00020000 "kernel_a"
mtd2: 00500000 00020000 "kernel_b"
mtd3: 01400000 00020000 "root_a"
mtd4: 01400000 00020000 "root_b"
mtd5: 02000000 00020000 "lullaby"
mtd6: 00100000 00020000 "info"
mtd7: 00080000 00020000 "flag"
mtd8: 00080000 00020000 "flag1"
mtd9: 02a00000 00020000 "config"
```

[root@Ingenic-uc1_1:proc]# cat partitions
```
major minor  #blocks  name
  31        0       2048 mtdblock0
  31        1       5120 mtdblock1
  31        2       5120 mtdblock2
  31        3      20480 mtdblock3
  31        4      20480 mtdblock4
  31        5      32768 mtdblock5
  31        6       1024 mtdblock6
  31        7        512 mtdblock7
  31        8        512 mtdblock8
  31        9      43008 mtdblock9

```

# 五、文件备份
## 1.拉起tftpd 服务,下载fdt设备树文件
### 1.1 设备端
- cd /sys/firmware/
- udpsvd -vE 0.0.0.0 69 tftpd ./
### 1.2 PC 端
- xxx:~/ipc$ tftp 192.168.172.1
- tftp> binary
- tftp> get fdt 

## 2.备份分区
### 2.1 设备端 (多次执行直到文件全部备份完成)
```
dd if=/dev/mtdblock0 of=uboot.img bs=1k
dd if=/dev/mtdblock1 of=kernel_a.img bs=1k
dd if=/dev/mtdblock2 of=kernel_b.img bs=1k
dd if=/dev/mtdblock3 of=root_a.img bs=1k
dd if=/dev/mtdblock4 of=root_b.img bs=1k
dd if=/dev/mtdblock5 of=lullaby.img bs=1k
dd if=/dev/mtdblock6 of=info.img bs=1k
dd if=/dev/mtdblock7 of=flag.img bs=1k
dd if=/dev/mtdblock8 of=flag1.img bs=1k
dd if=/dev/mtdblock9 of=config.img bs=1k
```
- cd /config
- dd if=/dev/mtdblock0 of=uboot.img bs=1k
- udpsvd -vE 0.0.0.0 69 tftpd ./
- rm uboot.img 

### 2.2 PC端
- xxx:~/ipc$ tftp 192.168.172.1
- tftp> binary
- tftp> get uboot.img


## 2.3 使用adb备份
### 设备端
- 使用wget 下载pc端的adbd.bin 文件
- ./adbd.bin 

### PC端
- adb connect 192.168.172.1
- adb pull /dev/mtdblock0