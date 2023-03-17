#!/bin/bash
source ./common.sh
echo SCENARIO-tcplbcps

$dexec llb1 /root/llb_cfg_add.sh
sleep 5
echo "loxilb-cps perf"
echo "1 Stream"
$hexec l3h1 ./netperf.sh 1 TCP_CRR
echo "100 Stream"
$hexec l3h1 ./netperf.sh 100 TCP_CRR
sleep 20
echo "Latency"
$hexec l3h1 netperf -L 10.10.10.1 -H 20.20.20.1 -t TCP_RR -- -P ,12866 -o min_latency,max_latency,mean_latency
sleep 5
echo "loxilb-rps perf"
$hexec l3h1 ./netperf.sh 100 TCP_RR
$dexec llb1 /root/llb_cfg_del.sh

sleep 20

echo "ipvs-cps perf"
$dexec llb1 /root/ipvs_cfg_add.sh
sleep 10
echo "1 Stream"
$hexec l3h1 ./netperf.sh 1 TCP_CRR
echo "100 Stream"
$hexec l3h1 ./netperf.sh 100 TCP_CRR
sleep 20
echo "Latency"
$hexec l3h1 netperf -L 10.10.10.1 -H 20.20.20.1 -t TCP_RR -- -P ,12866 -o min_latency,max_latency,mean_latency
sleep 5
echo "ipvs-rps perf"
$hexec l3h1 ./netperf.sh 100 TCP_RR
sleep 5
$dexec llb1 /root/ipvs_cfg_del.sh

sleep 20
echo "haproxy-cps perf"
$dexec llb1 /root/haproxy_cfg_add.sh
sleep 10
echo "1 Stream"
$hexec l3h1 ./netperf.sh 1 TCP_CRR
echo "100 Stream"
$hexec l3h1 ./netperf.sh 100 TCP_CRR
sleep 20
echo "Latency"
$hexec l3h1 netperf -L 10.10.10.1 -H 20.20.20.1 -t TCP_RR -- -P ,12866 -o min_latency,max_latency,mean_latency
sleep 5
echo "haproxy-rps perf"
$hexec l3h1 ./netperf.sh 100 TCP_RR
sleep 5
$dexec llb1 /root/haproxy_cfg_del.sh

echo SCENARIO-tcplbcps [OK]
