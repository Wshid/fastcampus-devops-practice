## [CH01_07] minikube 설치 및 쿠버네티스 클러스터 구성 (macOS)

### minikube 설치
```bash
brew install minikube
minikube start --driver docker

# kube cluster 정보 확인
cat ~/.kube/config
minikube status

# 클러스터 작동 여부 확인
kubectl cluster-info
```