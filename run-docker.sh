#!/usr/bin/env bash

docker compose -f container/docker-compose.yml up -d --build "$@"
