## [CH03_09] API 리소스 - Service

### 서비스란?
- 트래픽 분산, 외부 요청을 받기 위해
- 여러 파드에 대해 클러스터 내에서 사용 가능한 **고유 도메인** 부여
- 여러 파드에 대한 요청을 분산하는 **로드 밸런서** 기능 수행
  - L4, IP/Port
- 파드의 **IP**는 **항상 변할 수 있음**에 유의
- 일반적으로 **ClusterIP** 타입의 Service와 함께
  - **Ingress**를 사용하여 **외부 트래픽**을 처리
    - Ingress: L7 Layer LoadBalancing
- k8s의 etcd를 가지고 관리
  - Service Discovery
- 서비스 타입
  - NodePort(node에 port를 가지고 다루는)

### 서비스의 종류
#### ClusterIP
- default
- 클러스터 내부
- 외부 트래픽 x
- 서비스가 관리하는 pod에 분산

#### NodePort
- 외부 트래픽 가능
- cluster ip를 wrapping
- cluster ip의 모든 기능 사용 가능
- Node 동일한 포트를 열어 내부적으로는 ClusterIP로 처리

#### LoadBalancer
- Cluster IP의 모든 기능 사용
- 외부의 Load Balancer를 동적 관리
- Cloud Provider와 같이 사용됨

#### ExternalName
- 위 3개와 전혀 다름
  - 트래픽을 받는 용도가 아닌,
  - 외부로 나가는 트래픽을 변환하는 용도
  - e.g. a.b.com -> a.b
  - domain translation

### ClusterIP
- k8s는 **Pod IP를 위한 CIDR**과
  - Service에 부여되는 **Cluster IP CIDR**이 독립적으로 존재
- **Label Selector**를 통해 서비스와 연결할 **pod 목록** 관리
- Cluster IP로 들어오는 요청에 대해
  - Pod에 L4 레벨의 로드 밸런싱
- Cluster IP 뿐만 아니라 **내부 DNS**를 통해 **서비스 이름**을 이용한 통신 가능
- Cluster IP 타입의 Service는
  - **k8s 클러스터 내부 통신 목적**으로만 사용 가능

#### 서비스의 Clsuter IP CIDR 대역 확인
```bash
kubectl cluster-info dump | grep -m 1 service-cluster-ip-range
```

#### 실습
- `3-docker-kubernetes/9-k8s-service/cluster-ip`
```bash
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml

# 테스트용 pod 생성
kubectl run -i -t test --image=posquit0/doraemon bash
curl http://hello:8080

# cluster cidr 확인
kubectl cluster-info dump | grep -m 1 service-cluster-ip-range
```
- ClusterIP도 클러스터 내에서만 확인 가능
- `minikube ssh`를 통해 접근하여 `ClusterIP` 조회 가능

### NodePort로 외부에 노출하기
- 모든 k8s의 노드의 **동일 포트**를 개방하여 **서비스**에 접근하는 방식
- `NodePort`는 `ClusterIP` 타입 서비스를 한 번 더 감싸서 만들어진 것
  - `NodePort` 서비스도 `ClusterIP` 사용 가능
  - `NodePort`로 들어온 요청은 실제로 `ClusterIP`로 전달되어 Pod로 포워딩

#### 실습
- `3-docker-kubernetes/9-k8s-service/node-port`
```bash
kubectl apply -f service.yaml
kubectl get service
# ClusterIP는 유지되며, NodePort가 생성됨
kubectl describe service hello

kubectl get node -o wide
# host에서 접근 가능
curl http://192.168.49.2:30684

minikube ssh
curl <clusterIP>:8080 # 내부에서도 접근 가능
```

### LoadBalancer로 CloudProvider의 로드 밸런서 연동
- CloudProvider(e.g. aws)에서 제공하는 **로드밸런서**를 **동적으로 생성하는 방식**
  - e.g. ELB, ALB, ...
- `LoadBalancer` 타입 서비스는 `NodePort`타입 서비스를 한번 더 감싸서 만들어 진 것
  - `LoadBalaner` 서비스도 `ClusterIP` 사용 가능
  - `LoadBalancer` 서비스를 통해 만들어진 로드밸런서는 `NodePort`를 타켓 그룹으로 생성
  - `NodePort`로 들어온 요청은 실제로 ClsuterIP로 전달되어 포워딩
- `AWS/GCP`와 같은 클라우드 환경이 아닐경우, 기본적으로 해당 기능 사용 불가
- `MetalLB`와 같은 기술 등을 사용하여
  - **On-Promise환경에서도 LoadBalancer 타입 사용 가능**
- minikube에서도 사용은 가능, 다만 복잡

#### 실습
- `3-docker-kubernetes/9-k8s-service/load-balancer`
- 실행하게 되면 pending상태로 남음

### ExternalName로 외부로 요청 전달
- 서비스가 Pod를 가리키는게 아닌, **외부 도메인**을 가리키도록 구성 가능
- DNS의 **CNAME** 레코드와 동일한 역할 수행
- 사용 예시
  - 클러스터 외부에 존재하는 **레거시 시스템**을
  - k8s로 마이그레이션하는 과정에서 활용 가능
- `ExternalName` 타입의 서비스는 앞의 3개의 서비스 타입과 비교하여, 많이 사용되지는 않음

#### 실습
- `3-docker-kubernetes/9-k8s-service/external-name/service.yaml`
```bash
kubectl apply -f service.yaml
kubectl get service

kubectl get pod
kubectl exec -it test bash
# 요청을 잘 가져옴
curl httpbin
# 서비스 이름을 통해 외부 접근 가능
curl httpbin/get
```