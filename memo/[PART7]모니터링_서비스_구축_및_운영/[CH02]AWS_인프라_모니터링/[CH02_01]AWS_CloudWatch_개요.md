## [CH02_01] AWS CloudWatch 개요

### AWS CloudWatch
- AWS Resource Monitoring
- AWS내에 구동중인 Application 모니터링
- 다양한 AWS 서비스랑 Integration
  - 지표를 통한 임계값 초과 시 alarm 발생
  - 자동화 시스템 구축
  - 지표 backup

### AWS CloudWatch 개념
- e.g. EC2, RDS instance CPU 사용률 모니터링
- namespaces
  - EC2, RDS를 의미
- metrics
  - time-rodered set of data points
  - CPU 사용률을 의미
- dimensions
  - ASG_a의 EC2_01 CPU 사용률 모니터링
  - ASG_a의 EC2_02 CPU 사용률 모니터링
  - 인스턴스의 추상화 개념
- statistics
  - 평균 CPU, 최대 CPU 등
- resolutions
  - standard resolutions(1m 데이터)
  - high resolutions(1s 데이터)
    - 과금이 발생함
    - action trigger도 가능
- alarms
  - SNS topic publish
  - ec2 actions
  - autosacling actions
  - system manager actions