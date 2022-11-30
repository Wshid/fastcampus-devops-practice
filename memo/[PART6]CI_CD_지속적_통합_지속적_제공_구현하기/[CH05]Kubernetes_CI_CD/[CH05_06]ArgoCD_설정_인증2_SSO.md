## [CH05_06] ArgoCD 설정 #인증2(SSO)

### ArgoCD authentication
- local user
- deletgate authentication to an external identity provider(dex)

### ArgoCD SSO
- user -> argo에 접근
- Argo -> Dex(connector) -> Upstream Identity Provider(e.g. Github Organization, Azure, ...)
  - Dex는 OpenID Connect 구현체

### 실습
- Argo Dex 필요
  - argocd-cm ConfigMap 지정 필요
- Github organization 설정
  - 새로운 organization 생성
  - Settings
  - Developer Settings - Oauth app
  - Oauth app 생성
    - callback url: `http://127.0.0.1/api/dev/callback`으로 지정
    - client ID, secret을 복사
- Dex 설정
  - `devops_k8s/argo-cd/values-local.yaml`
  ```bash
  make upgrade-local
  ```
- Argo 접속
  - `Log in via GitHub`과 같은 메뉴가 활성화 됨
  - ArgoCD 앱 연동
- GitHub organization내에 team 생성
- 이후 AgroCD 접속
  - team의 정보도 log에서 확인할 수 있음
- team rbacConfig 설정
  - `org-devops`와 같은 `org-` prefix를 통해 설정 가능
  ```yaml
  # rbacConfig 하위에 다음과 같이 설정(RBAC)
  rbacConfig:
    policy.default: role:readonly
    policy.csv: |
      p, role:local-user-admin, applications, *, */*, allow
      g, alice, role:local-user-admin

      p, role:org-devops, applications, *, */*, allow
      p, role:org-devops, clusters, *, *, allow
      p, role:org-devops, repositories, *, *, allow
      g, xxx:devops, role:org-devops
  ```