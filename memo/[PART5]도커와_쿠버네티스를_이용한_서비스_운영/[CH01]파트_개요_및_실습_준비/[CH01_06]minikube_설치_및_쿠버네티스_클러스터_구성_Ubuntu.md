## [CH01_06] minikube 설치 및 쿠버네티스 클러스터 구성 (Ubuntu)

### minikube 소개
- 복잡한 클러스터 구성 작업을 가상환경을 이용하여 쉽게 구성
- 실제 운영과정보다는 k8s 학습 목적으로 활용 가능
- driver를 원하는 가상 환경(docker, podman, virtualbox, parallels, vmware, kyperkit, ...)등에서 활용 가능

### 설치 과정
- https://minikube.sigs.k8s.io/docs/start/#what-youll-need
- `3-docker-kubernetes/env/ubuntu/install-minikube.sh`

### 쿠버네티스 클러스터 구성
```bash
minikube start -h

# docker 기반 클러스터 생성
minikube start --driver docker

cat ~/.kube/config
# clusters: 관리할 클러스터 목록, 접속할 클러스터 정보
# context: 여러 context 관리 가능, 인증 리스트(클러스터별)
# - context 정보에 따라, 어떤 유저의 어떤 클러스터 접속 여부가 결정됨
# current-context
# users: 인증 사용자 정보

kubectl get nodes # 현재 접속 정보
kubectl cluster-info
minikube status # 클러스터 상태 확인
minikube stop # 클러스터 중지
minikube delete # 클러스터 삭제
minikube pause # 클러스터 일시중지
minikube unpause # 클러스터 재개

minikube addons list # addon 리스트 확인, 실제 k8s에는 존재하지 X
minikube addons enable ingress # nginx ingress 설치
minikube ssh # 노드 한대로 ssh 접속

# local의 k8s와 cluster의 k8s 버전이 다를때 사용하는 명령어
minikube kubectl ...
```