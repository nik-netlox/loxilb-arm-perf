#!/bin/bash
apt update
apt -y install haproxy 
apt -y install systemctl
cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bk
for ((i=1,port=12865;i<=150;i++,port++)); do echo "frontend nperf$port
  bind *:$port
  mode tcp
  option tcplog
  use_backend nperf-endpoints$port

backend nperf-endpoints$port
  mode tcp
  balance roundrobin
  server server1 31.31.31.1:$port
" >> /etc/haproxy/haproxy.cfg; done
mkdir /run/haproxy/
systemctl enable haproxy
ip addr add 20.20.20.1/32 dev lo
systemctl restart haproxy
