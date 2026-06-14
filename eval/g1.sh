#!/usr/bin/env bash

# Evaluate lab 6 part G (1) & (2)
# 評分標準:
# 1. (1 %) gNB config 能宣告支援兩個 slice: SST=1/SD=000001 與 SST=2/SD=000002
# 2. (1 %) MongoDB subscriber profile 能包含兩個 slice, 且 default slice 與 DNN/session 設定可供 UE 使用
# 3. (1 %) Open5GS log 能顯示 UE registration / PDU session 相關訊息, 可用來確認 slice 設定後仍能註冊
# 4. (0.5 %) 修改 config, 再執行一次 g1.sh 使得輸出變為 S_NSSAI[SST:2 SD:0x2]
# 5. (0.5 %) [隱藏項目 only for TA]

echo "[Setup] Restart system"
./eval/rebuild.sh
echo

echo "[1] gNB slice support config"
docker exec lab6-gnb grep -nEi 'sst|sd|slice|tai_slice' /etc/srsran/gnb.yaml
echo

echo "[2] MongoDB subscriber slice profile"
docker exec lab6-mongodb mongosh --quiet open5gs --eval 'db.subscribers.find({}, {_id:0, imsi:1, slice:1}).pretty()'
echo

echo "[3] Open5GS registration / NSSAI log"
docker logs lab6-core 2>&1 | grep -Ei 'NSSAI|S_NSSAI|sst|sd|Registration|PDU Session|SMF-Sessions|UE SUPI' | tail -n 40
echo
