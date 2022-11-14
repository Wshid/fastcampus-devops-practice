## [CH03_10] API 리소스 - ConfigMap

### ConfigMap이란?
- 어플리케이션의 **설정 값**을 컨테이너에 주입하기
- 설정 정보를 **환경변수** 혹은 **볼륨의 형태**로 파드에 전달하기 위한 목적
- 파드에서 직접 **환경변수**를 관리하지 않고 `ConfigMap`을 분리하여
  - 목적에 따라 설정 데이터를 다르게 주입 가능
- 환경별 주입 등

### ConfigMap의 사용방법
- `ConfigMap`의 값을 **컨테이너의 환경변수**로 사용
- `ConfigMap`의 값을 **파드 볼륨**으로 마운트하여 사용

#### 실습
- `3-docker-kubernetes/10-k8s-configmap`
```bash
cd no
kubectl apply -f deployment.yaml
kubectl exec -it deploy/mysql bash
echo $MYSQL_ROOT_PASSWORD

cd env-from
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl api-resources | grep configmap # cm 축약어 확인
kubeclt get cm
kubectl describe cm mysql-config 
kubectl exec -it deploy/mysql bash
echo $MYSQL_RROT_PASSWORD

cd env-value-from
kubectl apply -f deployment.yaml
kubectl exec -it deploy/mysql bash
echo $MYSQL_ROOT_PASSWORD

cd volume
kubectl apply -f deployment.yaml
kubectl exec -it deploy/mysql bash
echo $MYSQL_ROOT_PASSWORD
cd /tmp/config/
ls
# MYSQL_DATABASE, MYSQL_ROOT_PASSWORD 확인
```

### kubectl ConfigMap 생성 명령어
- 데이터가 큰 파일을 yaml로 관리하기는 어려움
- 그에 대한 대안?
  - 명령형(declarative) 방식으로 만들어보기
```bash
# mysql-config 이름의 ConfigMap 생성
kubectl create configmap my-config
# mysql-config 이름의 ConfigMap 생성 - local config.yaml 파일을 config.yaml을 키로 저장

kubectl create configmap my-config --from-file config.yaml
# c.f. --from-literal: k=v 형태로 줄 수 있음

# mysql-config 이름의 ConfigMap 생성 - local config.yaml 파일을 config를 키로 저장
# key=path 형태
kubectl create configmap my-config --from-file config=config.yaml

# mysql-config 이름의 ConfigMap 생성 - local config.yaml 파일을 config를 키로 저장
# -dry-run: 클러스터 반영을 하지 않고 확인
# -o: yaml 파일로 저장
kubectl create configmap my-config --from-file config=config.yaml -dry-run -o yaml
```