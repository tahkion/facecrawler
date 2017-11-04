#!/bin/bash
#Initial Scans

netstat -rn;
netstat -tulpn;

arp-l;
arp-scan -l;

#Assign third octet of gateway IP (Usually 0 or 1) to variable

IP=`ip route | grep default | head -1 | sed 's/.*via *//; s/ .*//'`
OCTET3=`echo $IP | cut -d . -f 3`

#Scans using OCTET3 Variable

nbtscan 192.168.0.1-192.168.$OCTET3.255;

#Nmap - Best run as superuser

nmap -sn 192.168.$OCTET3.0/24;
nmap --script smb-os-discovery -p 445 192.168.$OCTET3.0/24;
