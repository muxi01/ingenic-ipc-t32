#!/bin/sh

wpa_supplicant -Dnl80211 -iwlan0 -c/config/wpa_supplicant.conf > /tmp/wpa.log &

for i in $(seq 1 60); do
    sleep 1
    if [ -e /tmp/wpa.log ] ; then 
        if cat /tmp/wpa.log | grep -q "CTRL-EVENT-CONNECTED" ; then 
            udhcpc -i wlan0 -t 10 -T 3 -n
            break
        fi
    fi
done


