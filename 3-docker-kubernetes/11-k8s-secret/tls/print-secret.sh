#!/usr/bin/env sh

# 인증서 파일 생성
openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/CN=fastcampus.com" -keyout cert.key -out cert.crt

# my-tls의 tls secret 생성
kubectl create secret tls my-tls \
  --cert cert.crt \
  --key cert.key \
  --dry-run -o yaml
