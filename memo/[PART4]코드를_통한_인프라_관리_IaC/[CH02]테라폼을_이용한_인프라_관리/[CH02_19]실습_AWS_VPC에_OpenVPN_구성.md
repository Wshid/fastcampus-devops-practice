## [CH02_19] 실습 AWS VPC에 OpenVPN 구성
- `2-terraform/16-provisioner-userdata`
- workspace
  - netowrk: VPC/Subnet
  - EC2 - instance
    - instance1: open vpn(t2 micro)
    - instance2: private-ec2(t2 micro)
- VPC
  - az1, az2
  - az마다 public/private subnet 구성
  - private subnet 내부에 private-ec2 생성

### 실습
- 원격으로 수행됨(remote backend)
- 단, 수행은 execute mode = local로 가능
  - terraform project에서 변경 가능 

#### network
```bash
terraform init
# execution mode = local
terraform apply # vpc network가 생성됨
```

#### lab-openvpn
- `execution mode = local`로 설정
```bash
cd lab-openvpn/ec2-instance
terraform init
```
- fastcampus.ovpn 파일 내용을 local로 복사해주어야 함
- tunnelblick: openvpn 접속 가능한 client(free)