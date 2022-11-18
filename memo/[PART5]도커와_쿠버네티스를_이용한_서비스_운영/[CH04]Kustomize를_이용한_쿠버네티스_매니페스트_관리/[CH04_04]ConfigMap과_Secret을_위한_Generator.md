## [CH04_04] ConfigMap과 Secret을 위한 Generator

### 실습
- `3-docker-kubernetes/kustomize/5-generators`
```bash
# 아래 명령을 통해 수행하게 되면, configMap 이후에 hash값이 붙은 형태로 출력
## e.g. mysql-config-97kfcmmm8k
## 전체 파일 내용을 기반으로 해시값을 생성
## 해시값 추가 이유, deployment의 경우 configMap, secret에 변경이 일어났을때 이를 감지하기 위함(해시값이 변경되므로)
kustomize build .

# disableNameSuffixHash: 위의 특성에 따라 해시 값을 추가할지 여부를 결정
```