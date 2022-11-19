## [CH05_01] kubectx 이용하여 쉬운 컨텍스트 전환

### kubectx 설치
```bash
brew install kubectx
```

### kubectx 실습
```bash
# current context
kubectl config current-context
# change context 
kubectl config get-contexts

# context: cluster/user/namespace의 조합
## kubectl에서 접근할 정보
## cat ~/.kube/config 하위에서 세부 정보 확인 가능

# current context
kubectx
# change context 
kubectx fastcampus

kubectl cluster-info

# 이전 context 정보로 이동
kubectx -

# cluster에 존재하는 namespace 확인
# 노란색 글씨는 default namespace를 의미
kubens

# kube-system으로 namespace 이동
kubens kube-system
kubens -
```
- 멀티 클러스터를 운영할 때 유용