## [CH04_03] Replicas와 Images

### 실습
- `3-docker-kubernetes/kustomize/4-replicas-and-images`
```bash
# grafana
kustomize build grafana/

# hello
kustomize build hello/

kubectl create namespace fastacampus
kubectl apply -k .
# kustomization 파일 내용 확인 가능
kubectl get -k .
```