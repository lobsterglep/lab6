#!/usr/bin/env bash

docker compose -f container/docker-compose.yml rm -sf "$@" 2>&1 | grep -Ei "Removed" || true
docker compose -f container/docker-compose.yml up -d --build mongodb core 2>&1 | grep -Ei "Started" | tr '\n' ' ' || true
echo ", wait 10s ..."
sleep 10
docker compose -f container/docker-compose.yml up -d --build --no-deps gnb 2>&1 | grep -Ei "Started" | tr '\n' ' ' || true
echo ", wait 10s ..."
sleep 10
docker compose -f container/docker-compose.yml up -d --build --no-deps ue 2>&1 | grep -Ei "Started" | tr '\n' ' ' || true
echo ", wait 20s ..."
sleep 20

docker exec lab6-mongodb mongosh --quiet open5gs --eval 'db.subscribers.deleteMany({})'
docker exec lab6-mongodb mongosh --quiet open5gs /docker-entrypoint-initdb.d/add-subscriber.js

echo "ok"
