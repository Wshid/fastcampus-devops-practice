## [CH05_01] Gitops ArgoCD 소개
- Kuberenetes에 워크로드 배포하기

### 배포 방법
- yaml형태의 manifest 작성
- kubectl, api call을 통해 k8s master에 제출
- 이후 k8s에서 pod에 반영
- k8s는 `Desired State`를 사용함

### Gitops
- Git(code) + Ops
- Config repo <-> current state
  - Desired State를 Git에 올려두고
  - Observable State(현재상태)를 비교하면서 적용함

### ArgoCD
- Gitops CD tools for k8s
- helm, kubstomize에 정의된 manifest등을 가지고 desired state 적용

#### ArgoCD Component
- API server
  - gRPC/REST server
  - auth delegation to external IP
  - RBAC
- Repository server
  - cache of the git repo
  - generating & returning k8s manifest
- Application controller
  - k8s controller
  - compare current state with desired state
- Project
  - 여러개의 application을 하나로 묶는 역할
- Kubernetes
  - application과 1:1로 매핑된 workload
- Jenkins, Git ---api call--> 
  - AgroCD
    - Project role -> token
    - Account admin -> token