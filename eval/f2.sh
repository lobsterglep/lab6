#!/usr/bin/env bash

# Evaluate lab 6 part F (2)
# 評分標準:
# 1. (1 %) 先將 gnb 的 MCS 設成 10, 接著執行 f2.sh, 成功輸出 gNB MCS 與 iperf3 throughput 之後,
#          設成 28 後再次執行 f2.sh, 請同學分析這兩次不同的結果
# 2. (1 %) [隱藏項目 only for TA]
# 3. (1 %) [隱藏項目 only for TA]

echo "[Setup] Restart system"
./eval/rebuild.sh
echo

echo "[1] MCS in gNB config"
docker exec lab6-gnb grep -nE 'max_ue_mcs' /etc/srsran/gnb.yaml
echo

echo "[2] UE registration / PDU session log"
docker logs lab6-ue 2>&1 | grep -Ei 'PDU Session Establishment successful|IP:'
echo

echo "[3] Start iperf3 server on core"
docker exec lab6-core sh -c 'pkill iperf3 2>/dev/null || true; iperf3 -s -p 5201 > /tmp/iperf3-server.log 2>&1 &'
sleep 2
echo "ok"
echo

echo "[4] iperf3 throughput test from UE to core (10 s)"
docker exec lab6-ue timeout 20s iperf3 -c 10.45.0.1 -B 10.45.0.2 -p 5201 -t 10 -i 2 || true
echo
