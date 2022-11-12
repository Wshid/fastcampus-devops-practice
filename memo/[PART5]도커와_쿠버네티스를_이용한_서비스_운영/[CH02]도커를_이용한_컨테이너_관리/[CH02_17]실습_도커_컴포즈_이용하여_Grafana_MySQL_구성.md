## [CH02_17] 실습 도커 컴포즈 이용하여 Grafana_MySQL 구성

### 1단계: Grafana 구성하기
- host:3000 - container:3000
- grafana.ini, 호스트에서 주입 가능하도록, RO
- local data 경로, docker volume mount
- plugin 추가 설치를 위한 env 설정
- log driver 옵션을 통한 rotating

### 2단계: Grafana + MYSQL 구성하기
- 1단계 요구사항 포함
- `grafana.ini`를 통해 database 설정 변경(sqlite -> MYSQL)
- MYSQL container를 `docker-compose`에 db service로 추가
- grafana 서비스가 db 서비스를 database로 연결하도록 구성
- MYSQL의 로컬 데이터 저장 경로 확인, 도커 볼륨 마운트

### 실습
- `3-docker-kubernetes/lab-docker-grafana`
- `docker-compose up -d`