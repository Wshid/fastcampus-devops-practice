## [CH03_12] API 리소스 - Namespace ResourceQuota LimitRange

### 네임스페이스란?
- k8s의 API 오브젝트들을 **논리적**으로 구분하여 관리
- 해당 논리적인 그룹에 대하여
  - **권한 관리**, 리소스 제한 가능
- 사용자 목적에 맞게 네임스페이스 단위 설정
  - 팀 단위
  - 환경 단위
  - 서비스 단위
  - ...
- label보다 명시적인 분리
  - 권한 관리, 리소스 제한이 추가적인 기능

#### 네임스페이스 범위 API 리소스(Namespace-scoped API Resources)
- Pod, Deployment, Service, Ingress, Secret, ConfigMap, ServiceAccount, Role, RoleBinding, ...
```bash
kubectl api-resources --namespaced=true
```

#### 클러스터 기본 네임스페이스
- Node, Namespace, IngressClass, PrioirtyClass, ClusterRole, ClusterRoleBinding, ...
```bash
kubectl api-resources --namespaced=false
```

#### 실습
```bash
# NAMESPACED=true,false 등의 값 확인 가능
kubectl api-resources
kubectl api-resources --namespaced=false
```

### 클러스터 기본 네임스페이스
- k8s cluster를 생성하고 나면, 기본적으로 만들어지는 네임스페이스

#### default
- namespace를 지정하지 않은 경우, 기본적으로 할당

#### kube-system
- k8s system에 의해 생성되는 API Object들을 관리하기 위한 네임스페이스

#### kube-public
- 클러스터 내 모든 사용자로부터 접근 가능하고
  - 읽을 수 있는 object들을 관리하기 위한 네임스페이스

#### kube-node-lease
- k8s 클러스터 내 노드의 연결 정보를 관리하기 위한 네임스페이스

### 다른 네임스페이스의 서비스 접근하기
- Service명으로는 충분하지 않음
  - Namespace가 다르지만, Service명이 동일하다면?
- **FQDN**(Fully Qualified Domain Name)과 Domain Search 옵션
  ```bash
  curl ${service}.${namespace}.svc.clsuter.local # FQDN
  curl ${service}.${namespace}.svc
  curl ${service}.${namespace}
  curl ${service} # 동일 네임스페이스 내 서비스 접근시 사용
  ```
- `resolv.conf`에 Domain Search 연관
- Domain Search 옵션이 정의되면
  - 위 내용이 있는지 한 단계씩 찾아보는 형태

#### 실습
- `3-docker-kubernetes/12-k8s-namespace`


### ResourceQuota와 LimitRange
- namespace 단위의 자원 사용량 관리할 수 있는 기능 제공

#### ResourceQuota
- namespace에서 사용할 수 있는 **자원 사용량의 합**을 제한
  - 할당할 수 있는 자원(CPU, Memory, Volume 등)의 총합 제한
  - 생성할 수 있는 리소스(Pod, Service, Deployment 등)의 개수 제한
- Limit Range
  - Pod 혹은 Container에 대해 **자원 기본 할당량 설정**, 혹은 **최대/최소 할당량 설정**

#### 실습
- `3-docker-kubernetes/12-k8s-namespace/extra`
```bash
kubectl apply -f namespace.yaml
kubectl describe ns fastcampus

kubectl apply -f limit-range.yaml

# Used/Hard(제한)
kubectl apply -f resource-quota.yaml

kubectl apply -f pod.yaml
kubectl describe pod test -n fastcampus.yaml

# 설정 불가로 에러 발생
kubectl apply -f unavailable-pod.yaml
```