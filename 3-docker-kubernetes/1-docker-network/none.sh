#!/usr/bin/env sh
## 해당 container가 네트워크가 필요 없을 때
## 커스텀 netowrking을 사용할 때 활용
docker run -i -t --net none ubuntu:focal
