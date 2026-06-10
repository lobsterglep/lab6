#!/usr/bin/env bash

# Evaluate lab 6 part C
# 評分標準:
# 1. (1 %) UE 能啟動並送出 registration request
# 2. (1 %) UE 使用 ZMQ 或 virtual RF plugin
# 3. (2 %) UE log 能顯示 RRC/PDU session/IP 相關資訊
# 4. (2 %) gNB log 能顯示 UE 接入相關流程, 包含 PRACH/RRC/UE context 等資訊
# 5. (2 %) Open5GS core 能收到 UE InitialUEMessage 或 Registration request
# 6. (2 %) Open5GS core 能完成 UE registration
# 7. (3 %) Open5GS core 能建立 UE PDU session, 並分配 IPv4 或建立 SMF session
# 8. (2 %) [隱藏項目 only for TA]

echo "[1] UE registration request from UE side"
docker logs lab6-ue 2>&1 | grep -Ei 'Attaching UE|Sending Registration Request'
echo

echo "[2] UE ZMQ or virtual RF plugin"
docker logs lab6-ue 2>&1 | grep -Ei 'Active RF plugins|zmq|Supported RF device list'
echo

echo "[3] UE RRC or PDU session status"
docker logs lab6-ue 2>&1 | grep -Ei 'RRC Connected|PDU Session Establishment successful|IP:'
echo

echo "[4] gNB UE access procedure"
docker logs lab6-gnb 2>&1 | grep -Ei 'PRACH|InitialULRRCMessage|InitialUEMessage|RRC|PDU Session|UE Context' | tail -n 30
echo

echo "[5] Open5GS core UE registration request"
docker logs lab6-core 2>&1 | grep -Ei 'InitialUEMessage|Registration request'
echo

echo "[6] Open5GS core UE registration complete"
docker logs lab6-core 2>&1 | grep -Ei 'Registration complete'
echo

echo "[7] Open5GS core UE PDU session and IP allocation"
docker logs lab6-core 2>&1 | grep -Ei 'UE SUPI|IPv4|PDU Session|SMF-Sessions'
echo
