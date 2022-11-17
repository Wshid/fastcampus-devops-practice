## [CH03_17] 파드의 배치 전략 - Affinity
- Affinity: 선호도

### nodeAffinity를 이용한 배치
- 선호하는 노드를 설정
- nodeSelector보다 확장된 Label Selector 기능 지원
- `matchExpressions` 사용 가능(`In, NotIn, Exists, DoesNotExist, Gt, Lt, ...`)
- 여러 유즈케이스에 활용 가능한 다양한 옵션 제공
  - **반드시 충족해야 하는 조건 (Hard)**
    - `requiredDuringSchedulingIgnoredDuringExecution`
      - requiredDuringScheduling
      - IgnoredDuringExecution
  - **선호하는 조건(Sort)**
    - `preferredDuringSchedulingIgnoredDuringExecution`
      - preferredDuringScheduling
      - IgnoredDuringExecution
- `IgnoredDuringExecution`
  - **실행중인 워크로드**에 대해서는 해당 규칙을 무시함

#### 실습
- `3-docker-kubernetes/16-k8s-selector/node-affinity`

### podAffinity를 이용한 배치
- 선호하는 파드(running)를 설정하는 방법, 사용법은 `nodeAffinity`와 거의 동일
- 여러 유즈케이스에 활용 가능한 다양한 옵션 제공
  - **반드시 충족해야 하는 조건 (Hard)**
    - `requiredDuringSchedulingIgnoredDuringExecution`
      - requiredDuringScheduling
      - IgnoredDuringExecution
  - **선호하는 조건(Sort)**
    - `preferredDuringSchedulingIgnoredDuringExecution`
      - preferredDuringScheduling
      - IgnoredDuringExecution
- 토폴로지 키(Topology Key)
  - Label Selector를 수행할 노드 범위 결정(노드에 설정된 Label)
    - 노드 단위: 노드를 띄우면 기본 설정(hostname)
    - 존 단위
    - 리전 단위
    - 존, 리전은 minikube x, AWS EKS 설정 가능

#### 실습
- `3-docker-kubernetes/16-k8s-selector/pod-affinity`
```bash
kubectl get node --show-labels
```

### podAntiAffinity를 이용한 배치
- 선호하지 않는 파드를 설정하는 방법
- `podAffinity`를 `podAntiAffinity`로만 변경하면 사용법 동일

#### 실습
- `3-docker-kubernetes/16-k8s-selector/pod-anti-affinity`