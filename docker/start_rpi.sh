#!/bin/bash
sudo modprobe -r dvb_usb_rtl28xxu
sudo modprobe -r rtl2832
docker-compose -f docker-compose-rpi.yml up -d
