#!/bin/bash

echo ____________________SYSTEM_________________________
whoami


echo ___________________________IP_______________________
echo

ip addr | grep "eth0"| grep "inet"| awk '{print $2}'

echo ____________________ROUTE_______________________________
echo

gateway=$(ip route | grep default | awk '{print $3}')

echo "Gateway: $gateway"

echo
echo ________________________MAC ADDRESS_______________________
echo
arp -a | awk '{print $4}'


echo ________________________PING_______________________
echo

if ping -c 1 google.com > /dev/null 2>&1; then
    echo "Network works"
else
    echo "Network does not work"
fi

loss=$(ping -c 4 8.8.8.8 | grep "packet loss" | awk -F',' '{print $3}' | awk '{print $1}')

echo "Packet loss: $loss"

echo ________________________MEMORY_______________________
echo


free

echo ________________________NETSTAT_______________________
echo

netstat | grep "tcp"

echo

echo ______________________CURL TEST____________________________
echo

curl -o /dev/null -s -w "%{http_code}\n" https://example.com
