## [CH03_11] AWS VPC에 OpenVPN과 Grafana 구성
- 실습 구조
  - User
  - VPC
    - OpenVPN - Grafana
    - OpenVPN: 외부에서 접속 가능
    - Grafana: 외부에서 접속 불가
    - terraform으로 수행
  - Packer
    - Open VPN AMI
    - Grafana AMI
    - AMI build를 통해 생성
- 실습 경로: `2-packer/lab`

### packer 빌드 이후 명령 수행
```bash
cd network
terraform apply
```

### open vpn aws instance 내에서 지정
```bash
cd /opt/openvpn
cat fastcampus.ovpn
# 위 파일 복사
```
- 복사하여 mac에서 수행
  - tunnel brick 툴 사용
- VPN 접속 완료

### openvpn private ip 접속
```bash
tf output
# openvpn_instance의 private ip 확인
```
- private ip ssh 접속 확인
- 이후 `private ip:3000`으로 grafana 접속 확인 가능