#!/bin/bash

sudo ifconfig usb0 up
sudo ifconfig usb0 192.168.172.2

telnet 192.168.172.1

