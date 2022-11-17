#!/usr/bin/env sh
# 노드별로 laber 지정, team=green,red
kubectl label node minikube --overwrite team=green
kubectl label node minikube-m02 --overwrite team=red
kubectl label node minikube-m03 --overwrite team=red
