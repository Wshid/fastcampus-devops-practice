## [CH02_02] AWS EC2 monitoring #1

### AWS EC2 Monitoring
- EC2 생성시, 기본적으로 basic monitoring이 수행됨
  - Period: 5min
  - Amazon CloudWatch
- detailed monitoring
  - Period: 1min
- default metrics
  - Instance metrics
    - CPU
    - Disk
    - Network
    - MetadataNoToken
      - 보안 관련 내용 파악
  - CPU credit metrics
    - 기준치 CPU 사용률
    - Busting형 타입들에 유효
  - EBS metrics
  - Status check metrics(default 1m)
- AWS EC2 metric dimensions 존재
- Amazon EC2 usage metrics
  - Service Quota
  - vCPU, ...

### 실습
- ec2를 생성해둔 상황
- Limits: limit 내용 확인
- EC2 Instance
  - Monitoring: 기본적인 차트 확인 가능
- detailed monitoring 켜는 방법
  - EC2 - Actions - Monitor and troubleshoot - Managed detailed monitoring
  - 활성화 할 경우 과금 발생
  - terraform code에서도 확인 가능
    - `detailed_monitoring = true`
- CloudWatch - metrics
  - Namespace별로 확인 가능
  - Namespace - EC2 선택
  - dimension 선택
  - 특정 instanceId를 가지고 조회 가능
  - Query 탭에서 메트릭을 조회할 수 있음
  - `${LABEL}, ${AVG}`등의 확인 가능
  - Options탭, 특정 차트에 대한 그래프 설정 가능