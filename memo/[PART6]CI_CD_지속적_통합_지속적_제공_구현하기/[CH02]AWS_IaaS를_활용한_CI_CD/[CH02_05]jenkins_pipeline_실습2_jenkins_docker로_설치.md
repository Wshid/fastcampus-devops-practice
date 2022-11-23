## [CH02_05] jenkins pipeline 실습2 jenkins docker로 설치

### 설치 방법
- Dind(Docker in Docker)
  - privileged 권한이 필요하다는 단점 -> 보안적으로 취약
- DooD(Docker out of Docker)
  - DooD Container에서 Docker Client 구동
  - Docker client에서 Host Docker daemon과 unix socker|tls로 통신
  - Host docker daemon을 sharing -> 상호 의존성 단점

### Jenkins DooD
- Jenkins Container
  - Docker client
  - user: jenkins
  - jenkins_container:group:docker:999 -> host:group:docker:999 연동
- Host, Docker daemon
- Docker client -> Host:Docker daemon(unix socker, var/urn/docker.sock)

### 실습
- `devops_06_03_jenkins/src/jenkins_remote_docker`
```bash
sudo service jenkins stop

cd src/jenkins_remote_docker

# docker 공식 홈페이지, docker-compose 설치 이후 진행
sudo chomd +x /user/local/bin/docker-compose
make run

curl -v http://localhost:8080
```