#!/usr/bin/env bash

# Evaluate lab 6 part A (1) & (2) & (3)
# 評分標準:
# 1. (2 %) MongoDB 已安裝, 且能正確印出 MongoDB 版本
# 2. (2 %) Open5GS 已安裝, 且能正確印出 Open5GS 套件版本
# 3. (2 %) Open5GS 網元皆已啟動, 且所有網元狀態皆為 RUNNING
# 4. (2 %) Open5GS MongoDB 連線設定正確, 且相關網元皆指向 mongodb://mongodb/open5gs
# 5. (2 %) [隱藏項目 only for TA]

echo "[Setup] Restart system"
./eval/rebuild.sh
echo

echo "[1] MongoDB installation"
docker exec lab6-mongodb mongod --version | grep 'db version'
echo

echo "[2] Open5GS installation"
docker exec lab6-core dpkg-query -W open5gs
echo

echo "[3] Open5GS network function status"
docker exec lab6-core supervisorctl status
echo

echo "[4] Open5GS MongoDB connection"
docker exec lab6-core grep -R "mongodb://mongodb/open5gs" /etc/open5gs
echo
