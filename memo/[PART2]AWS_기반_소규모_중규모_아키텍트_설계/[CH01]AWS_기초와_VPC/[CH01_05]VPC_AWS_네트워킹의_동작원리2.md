## [CH01_05] (VPC) AWS 네트워킹의 동작원리2

### Internet Gateway
- 인터넷으로 나가는 통로
- **Private Subnet**은 IGW로 연결 X

### Route Table
- 트래픽이 어디로 가야할지 알려주는 테이블
- VPC 생성시 자동으로 만들어 줌
  - IGW는 **Internet**을 의미
  ```md
  Destination       Target
  10.0.0.0/16       Local
  0.0.0.0/0         igw-id # 외부로 가라는 의미
  ::/0              igw-id
  ```

### NACL(Network Access Control List)/Security Group
- 보안 검문소
- NACL -> Stateless
- SG -> Stateful
- **Access Block**은 **NACL**에서만 가능
