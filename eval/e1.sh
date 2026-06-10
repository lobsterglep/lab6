#!/usr/bin/env bash

# Evaluate lab 6 part E (1)
# 評分標準:
# 1. (5 %) 將整個系統的 PLMN 從 00101 改成 52498 後再執行 e1.sh, 並能看到 UE registration / PDU session 成功的關鍵 log
# 2. (2 %) [隱藏項目 only for TA]

echo "[Setup] Restart system"
./eval/rebuild.sh
echo

echo "[1] UE registration / PDU session log"
docker logs lab6-ue 2>&1 | grep -Ei 'Attaching UE|Sending Registration Request|RRC Connected|PDU Session Establishment successful|IP:' | tail -n 20
echo

echo "[2] Open5GS core registration / PDU / TAC session log"
docker logs lab6-core 2>&1 | grep -Ei 'InitialUEMessage|Registration request|Registration complete|UE SUPI|IPv4|PDU Session|SMF-Sessions|TAI|TAC' | tail -n 30
echo
