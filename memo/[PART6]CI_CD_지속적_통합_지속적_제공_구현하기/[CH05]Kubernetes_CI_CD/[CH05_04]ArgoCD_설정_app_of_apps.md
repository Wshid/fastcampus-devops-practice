## [CH05_04] ArgoCD 설정 #app-of-apps
- Cluster bootstrapping
- argoCD내에 application 배포
  - 내부적으로 필요한 app을 자동 배포하여 확인

### 실습
- `devops_k8s/app-of-apps`
```bash
cd app-of-apps
helm template -f values.yaml
# 배포가 될때마다 필요한 app을 자동 생성
```
- ArgoCD: app-of-apps를 Application으로 생성
- app-of-apps를 동기화만 하면, 필요한 application을 자동 생성