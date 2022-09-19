# 4. 이 책의 학습 환경
- 독자 대상
  - 빠르게 전반적인 기능 파악
  - 직접 돌려보면서 익히는 경우

### 학습 환경별 구성
- 학습 환경1
  - Step01 ~ Step05
  - 단일 노드 구성
  - 기초가 되는 내용 실습
- 학습 환경2
  - Step06 ~ Step15
  - k8s를 사용한 컨테이너를 **정식 서비스**에 적용
  - 독자가 다양한 검증 가능
    - e.g. multi node 구성의 가용성에 대한 동작
- 학습 환경3
  - public cloud
  - Google Kuberenetes Engine, IBM Cloud Kubernetes Service 사용
- 학습 환경1, 학습 환경2 - CNCF가 **오픈소스**로 배포하고 있는 upstream k8s를 사용
  - CNCF: Cloud Native Computing Foundation
- 학습 환경 상세 내용은 책 참조(4.3, p80,81)

### 학습 환경 선택
- 기초 연습: 부록 1.1 ~ 부록 1.3 중 하나의 환경 설치
  - 부록 1.3 추천

### 책에서 다루는 OSS 목록
- k8s, docker외 소프트웨어 목록
- Ansible
  - 여러 가상 머신이 연계하는 환경을 자동으로 설정
  - single NFS server, minikube등에서도 package install시 사용
- Docker Community Edition
  - docker 학습 환경 및 k8s 컨테이너 실행 환경으로 사용
- Docker Toolbox
  - windows용 docker 학습시 사용
  - Docker CE로 교체 예정
- Docker Compose
  - 여러 docker container를 조합해서 기동할 수 있도록 만든 개발자용 orchestration tool
- Elasticsearch(ES)
  - minikube의 **로그 보관**을 위한 애드온으로 사용
- Fluentd
  - minikube의 로그를 ES에 전송하기 위한 툴
- GlusterFS
  - 확장 가능한 **분산 파일 시스템**
  - k8s cluster에서는 Heketi를 사용하여 logical volume의 **dynamic provisioning**을 실행
  - provisining
    - 사용자의 요구에 맞게 시스템 자원을 할당, 배치, 배포해 두었다가, 필요시 시스템을 즉시 사용할 수 있는 상태로 준비하는 것
- Grafana
  - opensource 데이터 시각화 웹 프로그램
  - minikube의 add-on
- Hyper-V
  - Windows의 하이퍼바이저
  - Windows용 Docker CE로 linux kernel을 기동하기 위해 사용
- Heapster
  - k8s 노드에서 **가동 정보**를 수집하는 컴포넌트
  - v1.13에서 metrics-server로 대체
- Heketi
  - GlusterFS의 **라이프 사이클**을 관리하기 위해 만들어진 `RESTful manage interface` 제공
  - k8s의 PV요청과 storage class와 연계하여, dynamic provisioning을 실현하기 위해 사용
- InfluxDB
  - 시계열 데이터베이스
  - minikube add-on
  - 차후 Prometheus가 CNCF 프로젝트에 추가되어, 대체 예정
- Kibana
  - ES의 로그 시각화 툴
- Minikube
  - k8s의 **학습**과 **로컬 개발**을 위해 CNCF에서 제공하는 환경
  - **단일 노드**로 구성된 간이 클러스터 쉽게 구축 가능
- NFS
  - 네트워크에서 파일 시스템을 공유
  - k8s pod에서 PV 사용 학습 환경으로 사용
- Docker Distribution의 Registry
  - 외부에 공개 X, container를 보존하기 위해 **Docker Hub**의 대체 서비스로 사용
- Vagrant
  - VirtualBox와 연계하여 **가상 머신 관리**를 자동화하는 도구
- VirtualBox
  - Windows PC, Mac, Linux서버에서 사용가능한 **하이퍼바이저**

# 5. Docker Command Chart Sheet

### 신구 커맨드 체계의 차이점
- 신규 커멘드 체계는 타이핑할 글자수가 늘어남 -> 작업효율 저하
- 능률이 좋은 구식 커멘드 체계

### 컨테이너 환경 표시
```bash
docker version
docker info
```

### 컨테이너 3대 기능

#### 이미지 빌드
```bash

## 현재 디렉터리(.)에 있는 Dockerfile을 바탕으로 이미지 빌드
docker build -t {repository:tag} .
## docker build -t kafka-practice:1.0 .
docker image build -t {repository:tag} .

# 로컬 이미지 목록
docker images
docker image ls

# 로컬 이미지 삭제
docker rmi {image}
docker image rm {image}

# 로컬 이미지 일괄 삭제
docker rmi -f 'docker images -aq'
  ## -a, --all             Show all images (default hides intermediate images)
  ## -q, --quiet           Only show image IDs
docker image prune -a
```
#### 이미지 이동 및 공유
```bash
# remote repository의 이미지 다운로드
docker pull {remote_repository:tag}
## docker pull httpd
docker image pull {remote_repository:tag}

# 로컬 이미지에 태그 부여
docker tag {image:tag} {remote_repository:tag}
docker image tag {image:tag} {remote_repository:tag}
## docker image tag alpine:3.10 alpine:custom_3.10
## e.g. latest의 특정 시점 버전 넘버를 tag로 기록
### docker image tag joont92/javatest:latest joont92/javatest:1.0.0
### latest가 가리키고 있던 내용을 javatest:1.0.0이 가리킴

# 레지스트리 서비스에 로그인
docker login {resitry_server_url}
## docker login -u {id}

# 로컬 이미지를 레지스트리 서비스에 등록
docker push {remote_repository:tag}
## docker push account1234/kafka-practice:1.0
docker image push {remote_repository:Tag}

# 이미지를 아카이브 형식 파일로 기록
docker save -o {filename} {image}
## docker save kafka-practice:1.0 -o save.tar
docker image save -o {filename} {image}

# 아카이브 형식 파일을 repository에 등록
docker load -i {filename}
docker image load -i {filename}

# container_name / container_id로 container를 지정해서 tar 파일로 기록
docker export {container_name|container_id} -o {filename}
# 다른 사용방법: docker export mykafka >> mykafka.tar
docker container export {container_name|container_id} -o {filename}

# 파일로 저장된 이미지를 repository에 입력
docker import {filename} {repository:tag}
# docker import mykafka.tar kafka-practice:1.0
docker image import {filename} {repository:tag}
```

#### 컨테이너 실행
```bash
# 대화형 컨테이너 기동 및 명령 실행. 종료시에는 컨테이너 삭제
# sh/bash를 지정하면 대화형 쉘로 linux command 가능
docker run --rm -it {image command}
## docker run --rm -it kafka-practice nyancat
docker container run --rm -it {image command}

# 백그라운드 컨테이너 실행
# container내 ps의 stdout,stderr는 log에 보존
# 보존된 log는 `docker logs` 참조
# -p {host_port:container_port}
docker run -d -p 5000:80 {image}
docker container run -d -p 5000:80 {image}

# 컨테이너에 이름을 지정하여 실행
docker run -d --name {container_name} -p 5000:80 image
docker container run -d --name {container_name} -p 5000:80 {image}

# 컨테이너의 fs내 directory mount 및 실행
# -v {local_path:container_path}
docker run -v 'pwd'/html:/usr/share/nginx/html -d -p 5000:80 nginx
docker continer run -v 'pwd'/html:/usr/share/nginx/html -d -p 5000:80 nginx

# 실행중인 컨테이너에 대해 대화형 쉘 실행
docker exec -it {container_name|container_id} sh
##  docker exec -it cf51623003b1 /bin/bash
docker container exec -it {container_name|container_id} sh

# 실행중인 container list
docker ps
docer container ps

# 정지된 컨테이너 포함하여 출력
docker ps -a
docker container ls -a

# container의 주 프로세스에 SIGTERM을 전송, 종료 요청
# timeout시 강제 종료
docker stop {container_name|container_id}
## docker stop cf51623003b1
docker container stop {container_name|container_id}

# 컨테이너 강제 종료
docker kill {container_name|container_id}
docker container rm {container_name|container_id}

# 종료한 컨테이너 삭제
docker rm {container_name|container_id}
# docker rm kafka1
docker container rm {container_name|container_id}

# 종료한 컨테이너 일괄 삭제
docker rm `docker ps -a -q`
docker container prune -a

# 컨테이너를 이미지로서 repository에 저장
docker commit {container_name|container_id} {repository:tag}
# docker commit kafka1 kafka-pratice
docker container commit {container_name|container_id} {repository:tag}
```

### 디버그 관련 기능
- 컨테이너 내부에서 **대화형 쉘**을 실행하거나 **로그 출력**등
  - 컨테이너화된 app의 debug에 사용되는 명령어
- k8s에서 디버깅시 **6.5 (10) 문제 판별**을 참고

#### 컨테이너 디버깅 관련
```bash
# 컨테이너 로그 출력
docker logs {container_name|container_id}
docker container logs {container_name|container_id}

# 컨테이너 로그를 실시간으로 표시
docker logs -f {container_name|container_id}
docker container logs {container_name|container_id}

# 컨테이너 목록 표시
docker ls -a
docker container ls -a

# 실행중인 컨테이너에 대해 대화형으로 커맨드 실행
docker exec -it {container_name|container_id} {command}
## docker exec -it kafka1 /bin/bash
dockercontainer  exec -it {container_name|container_id} {command}

# 상세한 컨테이너 정보
docker inspect {container_name|container_id}
docker container inspect {container_name|container_id}

# 컨테이너 실행 상태 실시간 표시
docker stats
docker container stats
- ![image](https://user-images.githubusercontent.com/10006290/190833749-bec7aa11-5586-40ef-872a-802b4b51b5b7.png)

# 컨테이너 stdout 표시
docker attach --sig-proxy=false {container_name|container_id}
docker container --sig-proxy=false {container_name|container_id}

# 컨테이너 일시정지
# docker에서 실행중인 작업을 잠시 멈췄다가 수행할때 사용(SIGSTOP), https://bio-info.tistory.com/139
docker pause {container_name|container_id}
docker container pause {container_name|container_id}

# 컨테이너의 일시정지 해제
docker unpause {container_name|container_id}
docker container unpause {container_name|container_id}

# 정지한 컨테이너 실행, stdout, stderror 출력을 terminal에 출력
# docker stop으로 종료된 컨테이너 실행
docker start -a {container_name|container_id}
## docker start cf51623003b1
docker container start -a {container_name|container_id}
```

### 쿠버네티스와 중복되는 기능
- docker
  - **docker swarm**: 복수의 노드로 클러스터 구성
  - **docker compose**: 상호 의존하는 여러 컨테이너를 빌드하여 실행
  - netowrk, pv, ...
- k8s에서는 k8s가 제공하는 `netowrk`나 `storage`기능을 이용, 다음 커맨드를 사용하지 X

#### 네트워크 관련
```bash
# 컨테이너 네트워크 작성
docker netowrk create {network_name}

# 컨테이너 네트워크 목록 출력
docker network ls
## ![image](https://user-images.githubusercontent.com/10006290/190833949-9f075bc6-2a4f-42fc-9d4f-5112147d6ff2.png)


# 컨테이너 네트워크 삭제
docker network rm {network_name}

# 미사용 컨테이너 네트워크 삭제
docker network prune
```

#### PV(Persistent Volume) 관련
```bash
# PV 작성
docker volume create {volume_name}

# PV list 출력
docker volume ls

# PV volume 제거
docker volume rm {volume_name}

# 미사용 PV 삭제
docker volume prune
```

#### docker compose 관련
```bash
# 현 디렉터리의 docker-compose.yaml을 참고하여 복수의 컨테이너 기동
docker-compose up -d

# docker-compose 관리하에 실행중인 container list
docker-compose ps

# docker-compose 관리하의 컨테이너 중지
docker-compose down

# docker-compose 관리하의 컨테이너 정지 및 이미지 삭제
docker-compose down --rmi all
```

### 참고 자료
- docker command referecnce: https://docs.docker.com/engine/reference/commandline/cli 
- docker document: https://docs.docker.com
