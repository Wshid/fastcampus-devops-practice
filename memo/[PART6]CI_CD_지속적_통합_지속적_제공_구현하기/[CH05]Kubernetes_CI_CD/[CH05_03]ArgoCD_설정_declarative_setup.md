## [CH05_03] ArgoCD 설정 #declarative-setup

### ArgoCD Declarative setup
- Projects
- Applications
- ArgoCD settings
- Project와 Application을 어떻게 선언적으로 관리할지?

### 실습
- `devops_k8s/argo-declarartive-setup-yaml`
```bash
cd argo-declarative-setup-yaml
kubectl -f AppProject.yaml
# argoCD dev 프로젝트가 생성됨

kubectl -f Application.yaml
# sync 이후 동기화 확인
```
- helm 파일로 관리하기
  - `sample-helm-1`
  - ArgoCD - New App - Helm, values file을 지정하여 설정 가능
- autoSync를 켜게되면, 자동으로 동기화됨

### AutoSync 시나리오
- 개발자가 Github의 내용 변경
- Jenkins에서 자동적으로 CD 변경을 위해 API 접근이 필요
  - 이때 Acoounts/Token을 발급받아 활용
- ArgoCD - Open the api docs를 통해 내용 확인
  - API 문서 확인 가능
- 실습: `argocd-get-application.sh`
  - 특정 API call을 통해 sync로 동기화 하는 과정
  - API call시, `Authentication: Bearer {token}` 지정