## [CH01_06] (VPC) AWS 네트워킹의 동작원리3

### NAT(Network Address Translation) instance/gateway
- private network에서는 외부 통신이 안되는 상황
- public subnet에 있는 instance를 빌려 요청 및 통신 받음
- VPC Subnet(Private)
  - EC2
- VPC Subnet(Public)
  - NAT gateway
  - NAT instance

#### 통신 FLOW
- **Private Subnet(EC2)** -> NACL -> Route Table
- Router -> Route Table -> NACL -> **Public Subnet** -> NAT gateway
- NAT gateway -> NACL -> Route Table -> Router -> Internet Gateway -> Internet

#### 정의
- Private subnet에 있는 private instance가 **외부 인터넷**과 통신하기 위한 방법
  - NAT Instance: 단일 Instance(EC2)
  - NAT Gateway: aws에서 제공하는 서비스
- **NAT Instance**는 public subnet에 위치해야 함

### Bastion host
- NAT와 반대
- 관리자가 외부에서 **private subnet에 접근하여 작업**해야 하는 상황일 때
- `Public Subnet::Bastion Host`를 구성하여 접근
- admin ---console--> Public Subnet::Bastion Host -> Private Subnet::EC2

#### 정의
- Private Instance에 접근하기 위한 수단
- Public Subnet내에 위치하는 EC2

### VPC Endpoint
- IGW, NAT, VPN/AWS 연결 필요 x
  - AWS Private Link 구동지원 AWS 서비스
  - VPC Endpoint service **비공개 연결** 가능
- VPC Instance는
  - 서비스의 리소스와 통신하는데 `public ip address`를 필요로 하지 X
- VPC와 기타 서비스 간의 트래픽은 Amazon 네트워크 벗어나지 X

#### 정의
- AWS와 여러 서비스들과 **VPC**를 연결해주는 중간 매개
  - VPC 밖으로 트래픽이 나가지 않고, AWS의 여러 서비스 사용 가능
  - **Private Subnet**은 격리 공간이나
    - aws 다양한 서비스(e.g. S3, dynamodb, athena)등을 연결 가능
- **Interface Endpoint**
  - private ip를 만들어 서비스로 연결(SQS, SNS, Kinesis, Sagemaker, ...)
- **Gateway Endpoint**
  - Routing table에서 **경로 대상**으로 지정하여 사용(S3, Dynamodb, ...)
