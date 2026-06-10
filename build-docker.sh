#!/usr/bin/env bash

docker compose -f container/docker-compose.yml build "$@"
