## [CH03_11] API 리소스 - Secret

### Secret이란?
- PW, API Key, SSH Key 등 민감한 정보를 **컨테이너**에 주입해야 한다면?
- `ConfigMap`과 사용법 비슷
- 사용목적에 따라 몇가지 종류로 나우어짐
- k8s는 secret을 저장할 때 `base64`로 인코딩
  - binary data를 지원하기 위한 인코딩
  - 실제 엄청난 보안성을 가지진 않음
- EKS의 경우 KMS를 통해 암호화
- **RBAC(Rule Based Access Control)을 통해 Secret의 접근성을 관리해야 함**

### Secret의 종류
- **Opaque(generic)**
  - 일반적인 용도의 시크릿
  - `ConfigMap`과 사용방법 동일
- **dockerconfigjson**
  - 도커 이미지 저장소 인증 정보
  - 컨테이너 저장소 접근 필요
    - DockerHub, ECR
  - Private Image를 가져오기 위한 내용들
    - ImagePullSecrets
- **tls**
  - TLS 인증서 정보
- **service-account-token**
  - `ServiceAccount`의 인증 정보
    - RBAC을 하기 위한 API Resource
  - `ServiceAccount` 연결시 인증정보가 Secret으로 자동 생성

### kubectl Secret 생성 명령어(generic)
```bash
# my-secret 이름의 generic 타입 Secret 생성
# ConfigMap과 달리 type(e.g. generic)이 들어감
kubectl create secret generic my-secret

# local secret.yaml 파일을 secret.yaml을 키로 저장
## --from-literal 옵션 사용 가능
kubectl create secret generic my-secret --from-file secret.yaml

# local secret.yaml 파일을 secret을 키로 저장
kubectl create secret generic my-secret --from-file secret=secret.yaml

# local secret.yaml 파일을 secret을 키로 저장
kubectl create secret generic my-secret --from-file secret=secret.yaml --dry-run -o yaml
```

### 실습
- `3-docker-kubernetes/11-k8s-secret`
```bash
cd env-from
kubectl apply -f configmap.yaml
kubectl apply -f secret.yaml
kubectl apply -f deployment.yaml
kubectl exec -it deploy/mysql bash
echo $MYSQL_ROOT_PASSWORD

cd env-value-from

cd volume
kubectl  apply -f deployment.yaml
kubectl exec -it deploy/mysql bash
cat /tmp/secret/MYSQL_ROOT_PASSWORD
```

### Secret의 선언적 관리
- **IaC(Infrastructure as Code) -> GitOps**
- `Secret`은 `Git`등에서 관리하기에 부적절(기밀정보)


#### External Secrets
- `HashiCorp Vault`, `AWS Secrets Manager`와 통합
- ExcernalSecret 오브젝트 생성시,
  - Controller가 Provider로부터 기밀 값을 가져와 `Secret object` 생성

#### Sealed Secrets
- k8s cluster상에 Controller 실행
- 클러스터 상에 **암호화 키** 보관
- `kubeseal CLI`가 Controller와 통신하며 **데이터 암호화**
- `SealedSecret` 오브젝트 생성하면 Controller가 **복호화**하여 `Secret` 오브젝트 생성