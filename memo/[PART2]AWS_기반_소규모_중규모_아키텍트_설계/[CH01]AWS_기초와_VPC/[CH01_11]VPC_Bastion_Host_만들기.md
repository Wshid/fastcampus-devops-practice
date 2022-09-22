## [CH01_11] (VPC) Bastion Host 만들기
- Internet 사용자가 private에 접근하기 위함
  - 보통은 관리자
- Private EC2 만들기
- Public EC2(Bastion Host) 만들기
- Bastion Host를 통해 Private EC2 접근하기

### private ec2 설정
- 보안 그룹 생성시,
  - public ec2에서 ssh 접근이 가능하도록 구성

### 외부에서 접근하기 위한 설정
- putty, pageant (in windows)

### 접근 절차
- 외부(local) --ssh(putty)--> public ec2 ---ssh---> private ec2
  - public에서 private으로 접근 시, private ec2의 private ip를 이용하여 접근
