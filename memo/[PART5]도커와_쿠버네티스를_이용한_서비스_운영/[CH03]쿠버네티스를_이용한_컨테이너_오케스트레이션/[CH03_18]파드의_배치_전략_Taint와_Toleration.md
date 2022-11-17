## [CH03_18] 파드의 배치 전략 - Taint와 Toleration

### Taint와 Toleration

#### Taint(얼룩)
- 노드에 설정
- 노드에 `Taint`를 설정하여, 임의의 파드가 할당되는 것을 방지

#### Toleration(용인)
- 파드에 설정
- 특정 `Taint`를 용인할 수 있는 `Toleration` 설정을 가진 파드는
  - 해당 노드에 할당 가능


### 노드의 Taint 관리
- 노드를 새로 구성할 때 `kubelet`옵션을 통해 기본 `Taint` 설정도 가능
- `kubectl`을 통해 노드의 `Taint` 관리 가능
- `Label/Annotation`과 비슷하지만, 추가적으로 `Effect` 파라미터를 가짐
  - `Key=Value:Effect`

#### Effect
- `Taint`가 노드에 설정될 시 적용될 효과
- `NoSchedule`: 파드를 스케줄링 하지 않음
- `NoExecute`: 파드의 실행을 허용하지 않음
- `PreferNoSchedule`: 파드 스케줄링을 선호하지 않음

#### 설정 예시
```bash
# minikube-m02 노드에 role=system:NoSchedule Taint 추가
kubectl taint node minikube-m02 role=system:NoSchedule
# minikube-m02 노드에 role:NoSchedule Taint 제거
kubectl taint node minikube-m02 role:NoSchedule-
# minikube-m02 노드에 role 키를 가진 모든 Taint 제거
kubectl taint node minikube-m02 role
```

### 다양한 Toleration 설정 방법

#### 모든 종류의 Taint 용인
```yaml
spec:
  tolerations:
  - operator: Exists
```

#### 키가 Role이고 효과가 NoExecute인 모든 Taint 용인
```yaml
spec:
  tolerations:
  - key: role
    operator: Exists
    effect: NoExecute
```

#### 키가 role인 모든 Taint를 용인
```yaml
spec:
  tolerations:
  - key: role
    operator: Exists
```

#### role=system:NoSchedule Taint를 용인
```yaml
spec:
  tolerations:
  - key: role
    operator: Equal
    value: system
    effect: NoSchedule
```

### 실습
- `3-docker-kubernetes/16-k8s-selector/toleration`
- master node인 경우 score가 낮아, 우선순위가 낮게 할당됨
- daemonSet: **모든 노드에 pod을 띄울때 사용**
  - 이때 tolerations를 많이 사용
  - **taint가 지정된 모든 노드에 잘 띄워지도록 설정**
    - taint가 있는 노드에 안띄워지는 상황을 방지하기 위함