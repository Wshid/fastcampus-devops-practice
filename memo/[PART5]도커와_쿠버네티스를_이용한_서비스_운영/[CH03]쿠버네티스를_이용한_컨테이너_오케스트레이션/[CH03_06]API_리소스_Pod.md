## [CH03_06] API 리소스 - Pod

### 파드란?
- k8s가 **컨테이너**를 다루는 기본 단위
- 1개 이상의 Container로 이루어짐
- 동일 pod내 container는 여러 linux namespace를 공유
  - **네트워크 네임스페이스 공유**(동일 IP 사용)
- 사용자가 **직접 pod를 관리하는 경우는 거의 X**
- 보통 pod를 wrapping한 API 리소스를 다룸
  - StatefulSet
  - Deployment
  - DaemonSet
  - Job
  - CronJob
  - ReplicaSet

### 파드 관련 kubectl 명령어
```bash
# pod 목록
kubectl get pod
# pod 상태
kubectl describe pod hello
# pod에 명령어 전달
kubectl exec -i -t hello bash
# pod 로그
kubectl logs pod/hello

kubectl api-resources | grep pod
# pod에 대한 설명: 동일 호스트에서 수행할 수 있는 container의 집합
kubectl explain pod
```
- `3-docker-kubernetes/6-k8s-pod/pod.yaml`
  ```bash
  kubectl apply -f pod.yaml
  # 2/3: ready:containers, 3개중 2개 활성화
  kubectl get pod
  kubectl get pod -o wide

  # minikube로 ssh 접속
  minikube ssh
  curl 172.17.0.3

  # 특정 pod 접근 후 테스트, debug pod를 띄움
  kubectl run -i -t debug --image=posquit0/doraemon bash
  curl 172.17.0.3

  kubectl exec -i -t hello sh
  kubectl logs hello
  ```

### 멀티 컨테이너 파드와 사이드카 패턴
- 동일 파드 내 컨테이너는 **모두 같은 노드**에서 실행
  - namespace를 공유

#### 사이드카 패턴(Side-car Pattern)
- main container를 **보조하는 container와 같이 수행**
- Use case
  - Filebeat, Fluentd와 같은 로그 에이전트로 pod 로그 수집
  - Envoy와 같은 **프로시 서버**로 service mesh 구성
  - Vault agent와 같은 **기밀 데이터 전달** 목적
  - Nginx의 **설정 리로드** 역할 에이전트 구성

#### 명령어
```bash
# -c: 특정 컨테이너에 명령 전달
kubectl logs pod/hello -c debug
kubectl exec -i -t hello -c debug bash
```

#### 실습
- `3-docker-kubernetes/6-k8s-pod/multi.yaml`
```bash
kubectl apply -f multi.yaml

# 2개의 container로 구동
kubectl get pod -o wide
kubectl describe pod hello

# hello pod의 default container(nginx)로 접근
kubectl exec -it hello sh
# hello pod의 debug container로 접근
kubectl exec -it hello -c debug sh
## 동일 네트워크를 사용하기 때문에
## debug container에서 `curl localhost`를 하더라도 nginx(80)에 접근 가능

# container별 로그 확인
kubectl logs hello -c nginx
kubectl logs hello -c hello
```