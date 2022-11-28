## [CH05_02] ArgoCD 설치_local

### 실습 환경
- Github: desired state
  - namespace: argo
    - argocd-server
    - argocd-application-controller
    - argocd-repo-server
    - agrocd-dex-server
    - argocd-redis
  - namespace: default
    - smaple-yaml
    - sample-helm-1
    - sample-helm-2

### 실습
- Docker desktop, k8s 활성화
- `https://github.com/dev-chulbuji/devops_k8s`
```bash
kubeclt get no
kubectl config get-contexts
# vi ~/.kube/config 에서 설정 확인 가능

cd argo-cd
make template-local
make upgrade-local
# 이후 pod 생성 확인

# network-service, argocd-server가 생성됨
# localhost:30080에서 접속 가능
# secrets, argocd-inital-admin-secret내에서 접속 password 확인 가능
```
- k8s lens를 통해 GUI로 관리
- argocd.sh
  - helm pull을 통해 수정 예정

#### argocd web
- repository
  - connect repo using https
    - `https://github.com/dev-chulbuji/devops_k8s`
    - skip server verification
- cluster
  - 다른 클러스터에 배포할때 설정 가능
  - configMap
- projects
  - ns와 같은 논리적인 단위 설정
  - general, dev로 설정 가능
    - role 생성 가능
    - policy rules 지정 가능
    - JWT token 설정 가능
  - dev project 생성
    - source repositories
      - `https://github.com/dev-chulbuji/devops_k8s`
    - destinations
      - */*
- Accounts
  - 계정별 설정 가능
  - values-local.yaml 변경 이후 `make upgrade-local` 지정시 적용 가능
  - token 생성 가능
- Applications
  - new App
    - `sample.yaml`에 샘플 파일 존재(nginx)
    - path: sample-yaml 
    - project: dev
    - sync policy - manual
      - auto-create namespace
      - foreground
    - respository url 설정
    - master branch
    - path: sample-yaml
    - destination: https://kubernetes/default/svc
    - namespace: default
  - 생성 이후, 차트 형태로 확인 가능
    - OutofSync: github과 sync가 맞지 않는 상황을 의미
    - sync를 통해 동일화 시킬 수 있음
      - sync가 맞지 않는 resource 확인하여 지정 가능
- agroCD를 하게 되면
  - github으로 설정을 올리고 이를 쉽게 동기화 가능