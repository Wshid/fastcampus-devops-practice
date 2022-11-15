#!/usr/bin/env sh

kubectl create namespace a
kubectl create namespace b
# deployment와 service 생성
kubectl apply -f . -n a
kubectl apply -f . -n b
