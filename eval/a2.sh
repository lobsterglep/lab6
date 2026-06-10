#!/usr/bin/env bash

# Evaluate lab 6 part A (4)
# 評分標準:
# 1. (2 %) 能加入一個 subscriber
# 2. (2 %) 重啟 containers 後, 新加入的 subscriber 仍存在
# 3. (1 %) [隱藏項目 only for TA]

echo "[1] Delete all subscribers"
docker exec lab6-mongodb mongosh --quiet open5gs --eval 'db.subscribers.deleteMany({})'
echo

echo "[2] Add subscriber: 001010000000001"
docker exec lab6-mongodb mongosh --quiet open5gs /docker-entrypoint-initdb.d/add-subscriber.js
echo

echo "[3] All subscribers"
docker exec lab6-mongodb mongosh --quiet open5gs --eval 'db.subscribers.find({}, {_id:0, imsi:1, "slice.sst":1, "slice.session.name":1}).pretty()'
echo

echo "[4] Restart containers"
docker compose -f container/docker-compose.yml restart
sleep 5
echo

echo "[5] Subscriber after restarting containers: 001010000000001"
docker exec lab6-mongodb mongosh --quiet open5gs --eval 'db.subscribers.find({imsi:"001010000000001"}, {_id:0, imsi:1, "slice.sst":1, "slice.session.name":1}).pretty()'
echo
