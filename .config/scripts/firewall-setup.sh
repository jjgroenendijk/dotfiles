#!/bin/sh

## check if script is run as root
if [ "$(id -u)" -ne 0 ]; then echo "Please run as root." >&2; exit 1; fi

## get name of current interface
interface=$(ip route | grep default | awk '{print $5}')

## install firewall package
pacman -S firewalld

## enable and start firewall service
systemctl enable --now firewalld.service

## configure firewall to use home configuration
firewall-cmd --zone=home --change-interface=$interface --permanent

## reload firewall to make change active
firewall-cmd --reload

## let user know the firewall configuration is done
echo "Firewalld install and config is done!"
