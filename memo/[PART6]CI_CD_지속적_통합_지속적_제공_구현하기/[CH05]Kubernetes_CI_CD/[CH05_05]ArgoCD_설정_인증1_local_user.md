## [CH05_05] ArgoCD 설정 #인증1(local-user)

### ArgoCD authentication
- local user
- deletgate authentication to an external identity provider(dex)

### ArgoCD configuration
- argocd-cm, argocd-rbac-cm 을 통해 인증 관리

### 실습
- ArgoCD 접속
- Accounts
- local_user는 argocd-cm ConfigMap을 재설정 하면 됨
  - `devops_k8s/argo-cd/values-local.yaml`
  ```bash
  make template-local
  make upgrade-local
  # 이후 alice 유저 생성
  ```
- agrocd-cli 설치
  ```bash
  brew install argocd
  ```
- argocd-cli를 통한 password 설정
  ```bash
  argocd login 127.0.0.1:30080 --username admin --grpc-web
  # admin 초기 패스워드 입력
  
  argocd account list
  argocd account update-password --account alice
  # admin 유저의 password 입력
  # 신규 패스워드 입력
  ```
  - 이후 alice 계정으로 로그인 진행

### ArgoCD RBAC
- 권한에 대한 rule을 지정함
- argocd-cm ConfigMap을 재지정
  ```bash
  make upgrade-local
  # RO 지정에 따른 application의 read 권한을 가짐
  ```