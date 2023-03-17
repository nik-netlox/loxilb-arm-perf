#!/bin/bash

systemctl stop haproxy
mv /etc/haproxy/haproxy.cfg.bk /etc/haproxy/haproxy.cfg

ip addr del  20.20.20.1/32 dev lo
ip link del llb0

nohup /root/loxilb-io/loxilb/loxilb >> /dev/null 2>&1 &
