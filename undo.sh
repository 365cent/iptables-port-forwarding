#!/bin/bash

IPTBL=/sbin/iptables

IF_IN=eth0
PORT_IN=22

IP_OUT=172.16.93.128
PORT_OUT=22

# Disabling IP forwarding
echo "0" > /proc/sys/net/ipv4/ip_forward

# Removing specific rules
$IPTBL -D PREROUTING -t nat -i $IF_IN -p tcp --dport $PORT_IN -j DNAT --to-destination ${IP_OUT}:${PORT_OUT}
$IPTBL -D FORWARD -p tcp -d $IP_OUT --dport $PORT_OUT -j ACCEPT
$IPTBL -t nat -D POSTROUTING -j MASQUERADE
