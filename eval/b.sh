#!/usr/bin/env bash

# Evaluate lab 6 part B
# 評分標準:
# 1. (2 %) srsRAN 已安裝, 且能正確印出 gNB 版本
# 2. (3 %) srsRAN gNB 能成功啟動
# 3. (4 %) srsRAN gNB 能成功連線至 Open5GS AMF
# 4. (4 %) Open5GS AMF 能正確收到 gNB 連線
# 5. (2 %) [隱藏項目 only for TA]

echo "[1] srsRAN gNB installation"
docker exec lab6-gnb gnb --version | grep 'version'
echo

echo "[2] srsRAN gNB startup"
# 把 gNB 改成 gNodeB
docker logs lab6-gnb 2>&1 | grep 'gNodeB started'
echo

echo "[3] srsRAN gNB connection to Open5GS AMF"
# 把 Connected 改成 TNL connection
docker logs lab6-gnb 2>&1 | grep 'TNL connection to AMF'
echo

echo "[4] Open5GS AMF gNB connection"
docker exec lab6-core grep 'Number of gNBs' /var/log/open5gs/amf.log
echo
