## [CH01_05] kubectl과 kustomize 설치 (macOS)

### 설치 방법
- `3-docker-kubernetes/env/macos`
```bash
brew install kubectl
brew install kustomize
```
- 혹시나 `kubectl` 설치시 의존성 충돌이 발생하면 다음 명령 수행
  ```bash
  brew link --overwrite kubernetes-cli
  ```