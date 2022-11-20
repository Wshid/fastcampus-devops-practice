## [CH05_05] Lens 이용하여 GUI로 쿠버네티스 클러스터 관리

### Lens 설치
```bash
brew install lens

cat ~/.kube/config
kubectx
```

### 실습
```bash
fastcampus - Connect
Settings

# cluster에 metric을 수집할 수 있도록 add-on 설치
## 테스트 모니터링 용도로 확인 가능
Lens Metrics

WorkNodes 
# 종류별 상태 확인
1
Deployment
# 
```
- WorkNodes
  - Pod
    - 직접 pod내 접근도 가능
    - pod logs도 확인 가능(history)
    - edit을 통해 편집 가능
  - Deployment
    - pod 수 수정 가능
  - Secret
    - base64 디코딩된 값 확인 가능
- Netowrk
  - Forward, 브라우저에 포트포워드 된 주소로 접근하여 확인 가능
  - Port Forwarding, forward된 상태 확인 가능