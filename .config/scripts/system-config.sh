#!/bin/sh

## check if script is run as root
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi

## Enable SSD trimming
systemctl enable --now fstrim.timer
systemctl enable --now systemd-oomd.service
