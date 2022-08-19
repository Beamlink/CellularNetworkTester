#!/bin/bash

#This is a startup script to connect sim7600x with Raspberry  pi
#LTE Connection is established 

#See: https://raspberrypi.stackexchange.com/questions/68978/loading-kernel-module-qmi-wwan-before-option-to-get-dev-cdc-wdm0-automatica
#Removes the option driver and then forces the module to utilize the qmi_wwan
sudo modprobe -r option
sudo modprobe -r qmi_wwan
sudo modprobe qmi_wwan

sudo ifconfig wwan0 mtu 1430 up   #Temporaryly changes the  MTU of wwan0 from default 1500 to 1430 

sudo qmicli -d /dev/cdc-wdm0 --dms-set-operating-mode='online' 

sudo qmicli -d /dev/cdc-wdm0 --dms-get-operating-mode 

sudo qmicli -d /dev/cdc-wdm0 --nas-get-signal-strength 

sudo qmicli -d /dev/cdc-wdm0 --nas-get-home-network 

sudo ip link set wwan0 down

echo 'Y' | sudo tee /sys/class/net/wwan0/qmi/raw_ip

sudo ip link set wwan0 up 

sudo ip link set wlan0 down 

sudo qmicli -p -d /dev/cdc-wdm1 --device-open-net='net-raw-ip|net-no-qos-header' --wds-start-network="ip-type=4" --client-no-release-cid 

sudo udhcpc -i wwan0

ip a s wwan0 
