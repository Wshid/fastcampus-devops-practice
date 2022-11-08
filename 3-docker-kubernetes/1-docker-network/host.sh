#!/usr/bin/env sh
## docker가 제공하는 Network가 아닌 host network를 활용함
## docker inspect <container>로 확인 가능
docker run -d --network=host grafana/grafana
