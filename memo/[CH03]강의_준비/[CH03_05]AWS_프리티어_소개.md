## [CH03_05] AWS 프리티어 소개
- EC2 과금 방식 
  - On-demand 방식
  - 예약 구매: 사전 구매, 가격 저렴
  - 절감 계획(Saving plan): 가격 저렴
  - 경매(Spot): 가장 싸지만 어려움
    - 종료될 시점을 특정 지을 수 X

### 프리티어 사용 중 요금 발생시
- 하나 이상의 서비스에서 **월별 프리티어 사용량 초과 여부 확인**
- 프리티어가 아닌 서비스를 사용하였는지
- 프리티어 기간이 **만료**되었는지

### 대처 방법
- 프리티어 적용 여부 확인
- 요금 발생 리소스 추적
  - 결제 대시보드 - 서비스별 상세 내역 조회
- 요금 지불 의향 없는 서비스 종료
- 리소스 사용량 모니터리 

### 대표 무료 서비스 - EC2
- 12개월 무료
- **t2.micro** 타입 인스턴스
- windows/linux os, 사용량 각각 계산
  - 월별 750시간씩 사용 가능
  - (전체 인스턴스 사용 시간의 총합)
- 유의 사항
  - 함께 사용하는 **EBS 저장소** 사용량이 프리티어 수준인가?
    - 한달의 약 30G
  - **공인 IP**를 위해 사용한 Elastic IP는 모두 EC2 Instance에 연결되어 있는가
    - Elastic IP만 단독이라면 과금이 발생할 수 있음
  - 네트워크 사용량이 무료 제공량(수신 무료, 송신 월 1G)를 초과하지 않는가
  - T2계열 인스턴스의 **무제한 크레딧**

### 대표 무료 서비스 - S3
- 12개월 무료
- 매달 무료 사용량 제공
  - 표준 스토리지 5G
  - 15G 데이터 송신
  - 20,000건의 GET
  - 2,000건의 PUT/COPY/POST/LIST 요청

### 대표 무료 서비스 - VPC
- 언제나 무료
- VPC: 가상 네트워크 서비스
- 많은 리소스를 생성하더라도 과금되지 X
  - VPC/Subnet/Route Table/VPC Peering
  - Internet Gateway/Virtual Gateway
  - DHCP Options Set
  - NACL/Security Group
  - Prefix List
- 유의 사항
  - **네트워크 사용량**은 과금될 수 있음
  - 대표적인 VPC 과금 서비스
    - `NAT GateWay/PrivateLink/Client VPN/Site-to-Site VPN/Elastic IP, ...`
      - **사용하고 있지 않은 Elastic IP에 대해선 과금**

### 대표 무료 서비스 - IAM
- 언제나 무료
- IAM의 많은 리소스는 생성하더라도 과금되지 X
  - User/Group/Role/Policy
  - IdP(Identify Provider)
  - Access Analyzer
  - Credential Report

### 추천하는 사용법
- VPC, IAM은 자유롭게 사용
