## [CH03_07] API 리소스 - ReplicaSet

### 리플리카셋이란?
- 파드의 수를 늘리려면 `Scale-out`

#### ReplicaSet
- **정해진 수**의 파드가 항상 실행될 수 있도록 관리
- 기존 실행중이던 파드에 문제가 생기면
  - 파드를 `Scheduling`
- `ReplicationController`의 신규 버전(deprecated)
- **pod와 마찬가지로 replicaSet을 직접 관리하는 경우는 거의 X**
- Deployment(wrapping) > ReplicaSet > Pod ...

### 리플리카셋의 동작원리
- `ReplicaSet Controller`가 `Control Plane`에 존재
- `spec.selector`에 대응되는 pod의 수가
  - `spec.replicas`와 동일한지 지속 검사
- 다를 경우 `scale-out | scale-in` 진행

#### Label Selector
- k8s object는 모두 `metadata.labels`에
  - key, value 형태의 label 값을 가짐
- 특정 object 목록을 필터링하기 위한 기능이 Label Selector
- `matchLabels`와 `matchExpressions` 옵션 제공
- 많은 k8s api resource가 `Label Selector`를 통해 기능 제공
  - 리소스간 **느슨한 결합 유지**(Loosely Coupled)
- e.g. `metadata.labels - matchLabels`와 연관

#### Example
```yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
    name: web
    labels:
        env: dev
        role: web
spec:
    replicas: 4
    selector:
        matchLabels:
            role: web
```
```yaml
...
selector:
    matchLables:
        component: redis
    matchExpressions:
        - {key: tier, operator: In, values: [cache]}
        - {key: environment, operator: NotIn, values: [dev]}
```

### 실습
- `3-docker-kubernetes/7-k8s-replicaset`
```bash
watch kubectl get pod --show-lables
kubectl apply -f replicaset.yaml
kubectl get replicasets
kubectl describe replicasets hello

kubectl api-resources | grep replicaset
kubectl get rs
```

### 유의 사항
- `spec.selector pod 수 == spec.replicas` 이 여부만 검사
  - **pod가 ReplicaSet에서 관리하는 pod인지는 검사하지 X**

#### TEST 1. 더미 pod을 동일 label로 생성 이후, replica 확인
```bash
# TES
# app=hello 형태의 pod 생성
kubectl apply -f dummy-pod.yaml
# 이미 app=hello pod이 하나 존재하므로, 2개만 생성
kubectl apply -f replicaset.yaml
```

#### TEST 2. app=hello의 dummy pod을 수정
```bash
# 에디터 창 출력
kubectl edit pod hello-n98st
## edit 페이지 내부에서, labels.app=bye로 수정
```
- 이후 `ReplicaSet`에서 새로운 pod이 하나 띄워짐
  - `app=hello`의 replica를 3으로 맞춰주기 위해