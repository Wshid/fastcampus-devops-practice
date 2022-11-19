## [CH04_05] Patches

### strategic-merge
- 타켓을 찾고 머지 파일을 적용하는 형태
- `3-docker-kubernetes/kustomize/6-patches-strategic-merge`
  ```bash
  kustomize build base

  cd dev
  kustomize build dev
  kubectl apply -k dev
  kubectl apply -k dev
  
  cd prod
  kubectl apply -k prod
  kubectl get -k prod
  ```

### pathes-json
- `3-docker-kubernetes/kustomize/7-patches-json-6902`
```bash
kustomize build dev
kubectl apply -k dev
kubectl apply -k prod
```