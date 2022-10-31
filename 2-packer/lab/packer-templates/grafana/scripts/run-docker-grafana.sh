#!/usr/bin/env bash

set -euf -o pipefail

GRAFANA_VERSION=8.2.0

## Run Grafana automatically with Docker
docker run \
  -d \
  -p 3000:3000 \
  --restart unless-stopped \ # EC2가 재시작되더라도, 항상 실행
  --name=grafana \
  grafana/grafana:$GRAFANA_VERSION
