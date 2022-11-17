## [CH03_16] 파드의 배치 전략 - Node Selector

### minikube로 멀티노드 클러스터 구성
```bash
# single node로 생성된 minikube 클러스터는
# 기본적으로 CNI가 설치하지 않음
minikube delete

# 노드 3개로 구성된 minikube cluster 구성
minikube start --nodes 3 --driver=docker
```

### nodeName을 이용한 배치
- **노드의 이름 기반**으로 파드가 배치될 노드를 결정
- manifest의 재활용성이 떨어짐, 노드와 강결합
- `3-docker-kubernetes/16-k8s-selector/node-name/deployment.yaml`
  ```bash
  kubectl apply -f deployment.yaml
  ```

### nodeSelector를 이용한 배치
- node도 k8s의 **API Object**로 관리되기 때문에 `Labels`를 가지고 있음
- 노드에 설정된 `Label`을 기반으로 하여 **Label Selector** 기반 파드 배치 가능
- `3-docker-kubernetes/16-k8s-selector/node-selector`

### 노드 label 관리
- 노드를 새로 구성할 때, `kubelet` 컴포넌트의 옵션을 통해 기본 Labels 설정 가능
- `kubectl`을 통해 노드의 label 관리 가능
- 예시
  ```bash
  # minikube-m02 노드에 team=key Label 추가
  kubectl label node minikube-m02 team=read

  # minikube-m02 노드에 team label 제거
  kubectl label node minikube-m02 team-
  ```