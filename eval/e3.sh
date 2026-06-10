#!/usr/bin/env bash

# Evaluate lab 6 part E (3)
# 評分標準:
# 1. (2 %) 把 AMF address 改成錯誤 IP 後再執行 e3.sh, 並能看到 gNB 無法連線 AMF 或 NG setup 失敗的關鍵 log
# 2. (2 %) [隱藏項目 only for TA]
# 3. (2 %) [隱藏項目 only for TA]
# 注意: part E 結束後, 把所有設定改回可以正常連線的版本

echo "[Setup] Restart system"
./eval/rebuild.sh
echo

echo "[1] gNB AMF / NG setup log"
docker logs lab6-gnb 2>&1 | grep -Ei 'AMF|SCTP|NGSetup|Connected to AMF|connect|fail|error|timeout' | tail -n 30
echo

echo "[2] UE registration / PDU session log"
docker logs lab6-ue 2>&1 | grep -Ei 'Attaching UE|Sending Registration Request|RRC Connected|PDU Session Establishment successful|IP:|reject|fail|error|timeout' | tail -n 20
echo

echo "[3] Open5GS core AMF / registration log"
docker logs lab6-core 2>&1 | grep -Ei 'NGSetup|Number of gNBs|InitialUEMessage|Registration request|Registration complete|UE SUPI|IPv4|PDU Session|SMF-Sessions|AMF|gNB|reject|fail|error' | tail -n 30
echo
