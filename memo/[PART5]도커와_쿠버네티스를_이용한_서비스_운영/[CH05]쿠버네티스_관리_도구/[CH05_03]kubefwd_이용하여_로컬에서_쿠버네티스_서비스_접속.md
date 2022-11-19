## [CH05_03] kubefwd 이용하여 로컬에서 쿠버네티스 서비스 접속

### kubefwd 설치
```bash
brew install txn2/tap/kubefwd
```

### kubefwd github
- bulk로 port-forward시 사용하는 도구
- 로컬 환경에서 테스트시
  - Service로 구성하게 되면, 각각 서비스 도메인에 맞게 k8s 클러스터내에서는 동작
  - 단, local 환경 기준 외부이기 때문에, 해당 Service를 참조할 수 없음
    - NodePort, LoadBalancer, Ingress 등의 설정 구성 필요
    - 테스트를 위해 오픈하게 되면, 취약점이 발생할 수 있음
- 로컬의 `/etc/hosts`를 변조하여 도메인 매핑 기능 제공

### 실습
```bash
# 기본 사용법 확인
kubefwd

# 모든 namespace를 가지고 port-forward 진행, sudo 필요
# linux의 경우 -E 옵션 추가 필요
## sudo -E kubefwd svc --all-namespaces
sudo kubefwd svc --all-namespace
# 명령 수행시, Port-Forward: ... 로그를 통해 내용 확인 가능

kubectl get svc --all-namespaces

# in local
curl nginx:80
curl hello:8080
curl nginx.fast

# fast namespace에 한해 port-forward 진행
sudo kubefwd svc -n fast
```
- port-forwardfm를 하게 되면 local의 browser로 접속 및 테스트 가능