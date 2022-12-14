## [CH03_03] (인프라) Docker 개요

### 기존 문제점
- 개발 환경을 그대로 복제해서 같은 환경에서 배포하고 싶음
- 같은 서버에서 개발 환경을 여러개로 분리하고 싶음

### 가상환경과 Docker

#### 가상 환경
- 하나의 서버 내에서 프로그램별로 환경을 확실히 구분해줌
- 비효율성
- 각 가상환경별로 컴퓨팅 파워를 나눠서 쓴다
  
#### Docker
- 컨테이너 형태로 환경 구분
- 이미지를 통해 같은 환경의 가상 컴퓨터(컨테이너)를 무한히 생성할 수 있음(Auto-scaling)
- 컴퓨팅 자원을 공유해서 쓰므로 유동적

### Docker-compose
- 여러개의 Docker Container를 한번에배포할 수 있게 하는 툴
  - e.g. Container1: django, Container2: Nginx 상호 교류
  - 배포하는 순서도 어느정도 지정 가능(django 배포 이후 nginx가 실행되도록)
