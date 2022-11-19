## [CH05_02] kail 이용하여 쿠버네티스 로그 분석

### kail 설치
- k8s tail
```bash
brew tap boz/repo
brew install boz/repo/kail
```

### kail github repository
- `label, pod, ns, svc, ing`등의 필터링 옵션 존재
- Combining Selectors
  - 동일 옵션을 command에서 지정하게 되면 OR로 동작
  - 다른 옵션을 command에서 지정하면 AND로 동작
- `since` 옵션
  - 특정 시점 부터의 로그 출력
  - 값을 주지 않으면 현재 시점부터 확인 가능

### kail 실습
```bash
kail
# 기본적으로는 모든 namespace의 로그를 실시간으로 가져옴

kubectl get svc

# hello service의 로그 확인
kail --svc hello

# hello 서비스의 12시간 전부터의 로그 확인
kail --svc hello --since 12h

# help
kail -h

# kubenetes-dashboard namespace에서 최신 3분부터 로그 확인
kail -n kubernetes-dashboard --since 3m
```
- 중앙화된 log platform이 없을 경우 유용히 확인 가능