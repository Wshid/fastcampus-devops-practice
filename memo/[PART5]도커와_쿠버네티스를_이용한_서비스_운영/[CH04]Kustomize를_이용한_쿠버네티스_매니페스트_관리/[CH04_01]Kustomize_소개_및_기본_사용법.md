## [CH04_01] Kustomize 소개 및 기본 사용법

### Kustomize 소개
- k8s manifest 파일을 효율적으로 관리하기 위해 만들어진 오픈소스 도구
- 원본 yaml을 보존한 채로
  - 목적에 따라 **변경본**을 만들어 사용할 수 있도록 하는 것을 목표로 함
    - patch, overlay
- c.f. helm chart
  - chart: 패키지의 단위
  - kustomize가 상대적으로 러닝 커브가 낮음

### kustomization.yaml
- `kustomize`가 사용하는 yaml manifest 파일

#### Base Manifests
- Kustomization에 의해 참조되는 Kustomization
- 보통 **기본 설정**으로 구성된 쿠버네티스 매니페스트 묶음
  - 리소스 목록으로 구성된 파일

#### Overlay Manifests
- Base Manifests에 변형을 가하기 위해 사용되는 Kustomization
  - patch, overlay 과정을 거친 결과
- Overlay도 다른 누군가의 Base가 될 수 있음

### Kustomize 주요 명령어
```bash
# 현재 디렉터리에 kustomization.yaml
kustomize create
# 현재 디렉터리에 kustomization.yaml 파일을 해석하여 kubernetes manifest 출력
kustomize build .
# URL을 통해 원격에 위치한 kustomization.yaml 파일을 해석, k8s manifest 출력
kustomize build https:.../v8.2
# kustomization.yaml 파일 내용 클러스터에 적용
## stdout의 결과가 kubectl apply의 stdin으로 처리
kustomize build . | kubectl apply -f -
# kustomization.yaml 파일 내용 클러스터에서 삭제
kustomize build . | kubectl delete -f -
```

### kubectl 통합
- kustomize는 k8s 1.14에서 kubectl내에 kustomize 버전 `v2.0.3`을 내장
  - k8s 1.20까지는 관리가 되지 않아, `kustomize v2.0.3` 유지
- 2021.12 기준 kustomize의 latest version = `v4.4.1`
- 사용 방법
  ```bash
  # 위, 아래로 동일 명령어

  # kustomize build .
  kubectl kustomize .
  # kustomize build . | kubectl apply -f -
  kubectl apply -k .
  # kustomize build . | kubectl delete -f -
  kubectl delete -k .
  ```