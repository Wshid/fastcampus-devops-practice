## [CH01_04] kubectl과 kustomize 설치 (Ubuntu)

### kubectl 소개
- k8s의 API 서버와 통신하여, 사용자 명령을 전달할 수 있는 CLI 도구

#### 설치 방법
- `3-docker-kubernetes/env/ubuntu/install-kubectl.sh`

### kustomize
- k8s의 메니페스트 파일을 좀 더 효율적으로 관리할 수 있도록 도와주는 도구
- kubectl내에 kustomize 명령이 내장되어 있음
- helm과 유사
  - chart로 패키징하여 k8s app을 관리
- base에 patch/overlay를 적용하여 구성

#### 설치 방법
- `3-docker-kubernetes/env/ubuntu/install-kustomize.sh`