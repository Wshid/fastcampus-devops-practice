## [CH01_04] (VPC) AWS 네트워킹의 동작원리1
- VPC(Virtual PRivate Cloud)
  - 가상 네트워크
  - on-promise에서 운영하는 기존 네트워크와 유사

### VPC 특징
- 계정 생성시 `default`로 VPC를 만들어줌
- EC2, RDS, S3 등의 서비스 활용 가능
- subnet 구성
- 보안 설정(IP block, inbound/outbound 설정)
- VPC Peering(VPC 간의 연결)
- IP 대역 지정 가능
- VPC는 하나의 Region에만 속할 수 있음(다른 Region으로 확장 불가)

### VPC 구조
- Internet - Internet GateWay - Router - Route Table - NACL - VPC Subnet(Public)

### 계층 구조
- Region > VPC > AZ > Subnet

### VPC 구성 요소
- Availability Zone
- Subnet(CIDR)
- Internet Gateway: VPC 내부 자원들과 Internet의 통신을 위함
- Network Access Control List/security Group
- Route Table
  - VPC 안에 있는 내부 객체간의 통신을 위함
  - VPC와 Internet, 외부간의 통신을 위함
- NAT(Network Access Translation) instance/NAT gateway
- VPC endpoint

#### Availability Zone
- 데이터 센터는 Region에 위치
- Region에 n개의 Availabilty Zone이 존재
- 물리적으로 분리되어 있는 인프라가 모여있는 데이터 센터
- **데이터 센터 이중화** 개념
  - 물리적으로 지역적 구분, 일정 거리이상 떨어져 있어야 함
  - e.g. 서울 데이터센터, 부산 데이터 센터
- 각 계정의 AZ는 다른 계정의 AZ와 다른 아이디를 부여받음
- VPC의 하위 단위(subnet)
  - 하나의 AZ에서만 생성 가능
  - 하나의 AZ에는 여러개의 subnet 생성 가능

#### Subnet
- Private subnet
  - 인터넷에 접근 불가능한 subnet
- Public subnet
  - 인터넷에 접근 가능한 subnet
- CIDR 블록을 통해 subnet 구분
  - 하나의 VPC 내에 있는 여러 IP 주소를 Subnet으로 분리/분배하는 방법
