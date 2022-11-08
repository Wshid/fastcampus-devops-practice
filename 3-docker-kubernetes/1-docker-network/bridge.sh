#!/usr/bin/env sh
# docker0이 아닌 사용자 브릿지 네트워크 생성
docker network create --driver=bridge fastcampus

# --net-alias: hello라는 도메인 이름으로 nginx에 접근하도록 설정
docker run -d --network=fastcampus --net-alias=hello nginx
docker run -d --network=fastcampus --net-alias=grafana grafana/grafana
