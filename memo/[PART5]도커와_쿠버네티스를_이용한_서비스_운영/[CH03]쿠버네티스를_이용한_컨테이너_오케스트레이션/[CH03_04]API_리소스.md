## [CH03_04] API 리소스

### API 리소스와 오브젝트
#### API 리소스
- k8s가 관리할 수 있는 object의 종류
- Pod, Service, ConfigMap, Secret
- Node, ServiceAccount, Role
- 프로그래밍 언어의 class 개념과 유사, template

#### 오브젝트(Object)
- API 리소스를 인스턴스화 한 것

#### 명령어
```bash
# 현재 k8s가 지원하는 API 리소스 목록 출력
## NAME, SHORTNAMES, APIVERSION, NAMESPACED, KIND
kubectl api-resources

# 특정 API 리소스에 대한 간단한 설명 확인
kubectl explain pod

# minikube 현재 상태 확인, 수행되어 있지 않다면 start 명령어 필요
minikube status

# api resource 목록
kubectl get pod
## 아래 명령은 모두 동일 의미
kubectl get pod --all-namespaces
kubectl get po --all-namespaces
kubectl get pods --all-namespaces
```

### 매니페스트 파일
- k8s는 object를 yaml 기반 manifest 파일로 관리
- **apiVersion**
  - 어떤 API 그룹에 속하고, API 버전이 무엇인지
- **kind**
  - obejct가 어떤 리소스인가?
- **metadata**
  - 오브젝트를 식별하기 위한 정보
  - name, namespace, label
- **spec**
  - 오프젝트가 **가지고자 하는 데이터는?**
  - 실제 데이터가 저장되는 장소
  - api 종류에 따라 spec이 아닌 다른 속성 사용
    - data: `ConfigMap, Secret`
    - rules: `Role`
    - subjects:

### Labels와 Annotations
- 모든 k8s는 label과 annotation metadata를 ㅏ질 수 있음
- Optional한 값
- 모두 `String`형식의 `Key-Value` 데이터를 기록

#### Labels
- object를 식별하기 위한 목적
- `검색, 분류, 필터링` 등의 목적으로 사용
- k8s 내부 여러 기능에서 `Label Selector`기능 제공

#### Annotations
- 식별이 아닌 **다른 목적**으로 사용
- 보통 `k8s`의 `add-on`이
  - 해당 object를 어떻게 처리할지 결정하기 위한 설정 용도로 사용
- 사람이 읽기 위한 목적이 X
- add-on의 설정 용도로 활용

#### Example
```yaml
apiVersion: v1
kind: Pod
metatdata:
  name: nginx
  lables:
    app: "nginx"
    type: "web"
  annotations:
    my-annotation1: "hello"
    my-annotation2: "fastcampus"
spec:
  ...
```