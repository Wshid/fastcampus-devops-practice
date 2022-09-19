## [CH02_02] DevOps 엔지니어의 역할

### DevOps Engineer
- 개발과 운영을 모두 하는 사람?
- 조직에 devops 문화를 정착시키는데 도움을 주는 역할
  - **개발자가 개발뿐 아니라 운영에도 참여할 수 있는 환경 마련**
- 운영을 할 수 있도록 도와주는 환경 마련
- 하는 일이 많지 않은가?
  - 네트워크 셋업, 도메인 구축 운영, 서버 프로비저닝, 관측, 배포시스템 구축 관리, ...
  - 조직이 커지면서 도메인별로 세분화 될 수 있음

### DevOps 팀의 고객
- 개발자
  - 개발자의 생산성을 극대화 하기 위함

### DevOps 팀의 업무 도메인

#### Network
- 가상/물리 네트워크 구성
- proxy/VPN 서버 운영
- DNS 서버 운영

#### Orchestration Platform
- k8s/ ECS/ Nomad와 같은 Orchestration system 구축, 운영
- Airflow, Argo Workflows와 같은 workflow engine 구축 및 운영

#### Observability Platform
- log, metric, uptime, APM 정보를 관측할 수 있는 중앙 시스템
- 주요 이벤트에 대한 알림 시스템 구축

#### Development & Deployment Platform
- Gitlab, Github
- CI/CD Pipeline
- QA Test, 성능 테스트
- 패키지 저장소 운영, 배포 산출물 관리

#### Cloud Platform
- 자체 클라우드, 퍼블릭 클라우드 등

#### Security Platform
- LDAP, AD, SAML을 활용한 임직원 계정계 운영
- Server/DB 접근 제어 시스템 구축, 운영
- Netowrk Firewall

#### Data Platform
- MySQL, DynamoDB, Redis, ... - DB
- RabbitMQ, Kafka, SQS, ... - Messiging System
- Data Warehouse, BI Dashboard

#### Service Operations
- 개발자와 협업, 서비스 공동 운영

### DevOps 팀의 업무 도메인
- Provisioning: 구축
- Configuration
- Operation
- Usage
- Training
- Documentation

### DevOps 팀의 핵심 지표
- 장애복구 시간, MTTR(Mean Time To Recovery)
  - Infra 자동화, 배포 파이프라인 문제, ...
- 변경으로 인한 결함률(Change Failure Rate)
  - Test 파이프라인 문제, ...
- 배포 빈도(Deployment Frequency)
  - 문화적 문제, 시스템적인 문제, ...
- 변경 적용 소요 시간(Lead Time for Chagnes)
