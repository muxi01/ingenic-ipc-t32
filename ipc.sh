#!/bin/bash

sudo ifconfig $1 up
sudo ifconfig $1 192.168.172.2

telnet 192.168.172.1

