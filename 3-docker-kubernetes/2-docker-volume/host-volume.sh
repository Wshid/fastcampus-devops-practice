#!/usr/bin/env sh

docker run \
  -d \
  # 현재 디렉터리 경로 출력
  -v $(pwd)/html:/usr/share/nginx/html \
  -p 80:80 \
  nginx
