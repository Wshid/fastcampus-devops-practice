## [CH04_12] AWS VPC에 OpenVPN과 Grafana 구성
- Terraform + Packer + Ansible을 이용하여 AWS VPC에 OpenVPN 및 Grafana 구성
- 주의 사항
  - 기존 terraform workspace는 모두 destroy
  - 이전 packer 실습에서 사용했던 netowrk workspace는 그대로 사용 가능

### 실습 상세
- packer: shell provisioner -> ansible provisioner
- ansible provisioner
  - ansible (local): 대상 pc에서 ansible 수행, ansible 설치 필요
    - Ansible local provisioner
  - ansible (remote): `playbook.yml` 지정, packer 빌드 머신에 ansible 설치 필요
- terraform의 경우 ansible provisioner를 지원하지 않음
  - generic provisioner - remote-exec 사용
    - 대상 서버에서 명령어 수행
    - ansible playbook 명령어를 수행하는 방식

### 실습
- `2-ansible/lab`
  - ec2-instance, network: terraform workspace
  - packer-templates, packer template
- `aws sts get-caller-identity` 설정 필요
  - aws credential 
- network 설정이 모두 완료되었다면
  ```bash
  cd network
  # 정상 실행된다면, 올바른 설정
  terraform output
  ```
- aws ami 이미지 만들기
  ```bash
  cd packer-templates
  # grafana, openvpn의 ami 만들기
  
  cd grafana
  pkr build .

  cd openvpn
  packer build .
  ```
- openvpn과 grafana의 instance 생성
  ```bash
  cd ec2-instance
  terraform apply
  ```
  - 16개의 인스턴스 생성(보안그룹, openvpn, grafana, ...)

### 실습 경과 확인
```bash
ssh ubuntu@ip -i fastcampus.pem
cd /opt
cat fastcampus.ovpn

cd /ansible
vi playbook.yaml
# EC2 머신이, 본인을 설정하는 playbook 파일을 가지고 있음
# 추후에 해당 EC2에 접속하여 수행 가능(유용함)

# fastcampus.ovpn 복사
## 로컬에서 파일로 복사 한 후 접근 가능
```