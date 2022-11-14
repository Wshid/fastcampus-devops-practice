#!/usr/bin/env sh
## docker-registry 생성
kubectl create secret docker-registry docker-registry \
  --docker-username=fastcampus \
  --docker-password=fastcampus \
  --dry-run -o yaml
