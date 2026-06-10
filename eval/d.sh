#!/usr/bin/env bash

# Evaluate lab 6 part D
# 評分標準:
# 1. (4 %) 在 lo 與 n3 兩個介面擷取封包, 並輸出 output/core-lo.pcap 與 output/core-n3.pcap
# 2. (3 %) [隱藏項目 only for TA]
# 3. (5 %) [隱藏項目 only for TA]
# 4. (3 %) [隱藏項目 only for TA]
# 輸出:
#   output/core-lo.pcap
#   output/core-n3.pcap

LO_PCAP="/tmp/core-lo.pcap"
N3_PCAP="/tmp/core-n3.pcap"

echo "[Setup] Remove old pcap files"
mkdir -p output
rm -f output/core-lo.pcap output/core-n3.pcap
docker exec lab6-core rm -f "$LO_PCAP" "$N3_PCAP"
echo

echo "[1] Start packet capture on lo and n3"
docker exec -d lab6-core sh -c "tcpdump -i lo -s 0 -U -w $LO_PCAP"
docker exec -d lab6-core sh -c "tcpdump -i any -s 0 -U -w $N3_PCAP 'host 10.53.1.3 or port 2152 or port 38412'"
sleep 2
echo

echo "[2] Trigger UE registration and PDU session"
docker compose -f container/docker-compose.yml stop ue gnb 2>&1 | grep -Ei "Stopped" || true
docker compose -f container/docker-compose.yml up -d --build gnb 2>&1 | grep -Ei "Started" || true
sleep 10
docker compose -f container/docker-compose.yml up -d --build ue 2>&1 | grep -Ei "Started" || true
sleep 20
echo

echo "[3] Stop packet capture"
docker exec lab6-core pkill -INT tcpdump || true
sleep 2
echo

echo "[4] Copy pcap files to output/"
docker cp "lab6-core:$LO_PCAP" "output/core-lo.pcap"
docker cp "lab6-core:$N3_PCAP" "output/core-n3.pcap"
echo

echo '[5] Click core-n3.pcap and open wireshark, filter = "ngap || nas-5gs"'
echo

echo "[6] Show your signaling flow diagram (text diagram / mermaid / image), and explain the purpose."
echo
