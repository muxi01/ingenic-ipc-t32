#!/bin/sh

echo "APP Init..."

/system/init/sled.sh &

export LD_LIBRARY_PATH=/system/lib/:$LD_LIBRARY_PATH

#wifi reset pc8
echo 72 > /sys/class/gpio/export        
echo high > /sys/class/gpio/gpio72/direction

cd /system/lib/modules/4.4.94/
insmod ATBM6x6x_wifi_usb.ko
insmod tx-isp-PRJ007.ko 
insmod sensor_gc2083_PRJ007.ko
insmod audio.ko spk_level=-1

network =`ifconfig -a | grep wlan0`
trial=0
maxtrycnt=100
while [ -z "$network" ] && [ $trial -le $maxtrycnt ]
do 
    sleep 0.1
    #echo currect try $trial...
    trial=$(($trial + 1 ))
    network=`ifconfig -a | grep wlan0`
done
if [ $trial -le $maxtrycnt ]; then
    echo try wlan0 $trial times
fi
if [ $trial -gt $maxtrycnt ];then
    echo wlan0 not found
    exit -1
fi

ifconfig p2p0 up
ifconfig wlan0 up

if [ ! -d "/config/cert" ]; then	
    mkdir -p /config/cert
fi

cd /system/bin/
if [ "$FACTORY_FLAG" = "1" ]; then
    echo "Factory mode: bu_app logs will show on serial console"
    ./bu_app "$FACTORY_FLAG" &
else
    echo "Normal mode: bu_app logs suppressed"
    ./bu_app "$FACTORY_FLAG" >/dev/null 2>&1 &
fi

if [ "$FACTORY_FLAG" = "1" ]; then
    echo "Start rndis for factory test..."
    /system/init/rndis.sh
fi

if [ -e "/config/wpa_supplicant.conf" ]; then	
    wpa_supplicant -Dnl80211 -ip2p0 -c /config/wpa_supplicant.conf &
fi

if [ -e "/config/hostapd.conf" ]; then	
    ifconfig wlan0 192.168.170.1 netmask 255.255.255.0 up
    hostapd  /config/hostapd.conf &
fi

if [ -e "/config/udhcpd.conf" ]; then	
    touch /tmp/udhcpd.leases
    udhcpd  /config/udhcpd.conf &
fi

#test iperf3 server
#iperf3 -s &

#test web server
#cd /system/bin/
#./web_server_demo &
