#!/bin/bash
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
# ubuntu docker package 설치
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# ubuntu를 docker 실행 그룹 포함, 권한 변경
usermod -aG docker ubuntu

## Run openvpn-ldap-otp container
docker run \
 --name openvpn \
 --volume openvpn-data:/etc/openvpn \
 --detach=true \
 -p 1194:1194/udp \
 --cap-add=NET_ADMIN \
 -e "OVPN_SERVER_CN=${public_ip}" \ # context 주입
 -e "OVPN_ENABLE_COMPRESSION=false" \
 -e "OVPN_NETWORK=172.22.16.0 255.255.240.0" \
 -e "OVPN_ROUTES=172.22.16.0 255.255.240.0, ${split("/", vpc_cidr)[0]} ${cidrnetmask(vpc_cidr)}" \ # terraform 함수 사용 가능
 -e "OVPN_NAT=true" \
 -e "OVPN_DNS_SERVERS=${cidrhost(vpc_cidr, 2)}" \ # cidr에서 2번째 ip를 반환 //  10.222.0.2, 내부 DNS 서버 역할
 -e "USE_CLIENT_CERTIFICATE=true" \
 wheelybird/openvpn-ldap-otp:v1.4
# https://github.com/wheelybird/openvpn-server-ldap-otp, openvpn을 사용하면서 ldap, multi-factor 인증 지원

## Wait to ready OpenVPN Server
# while문으로 기다림
until echo "$(docker exec openvpn show-client-config)" | grep -q "END PRIVATE KEY" ;
do
  sleep 1
  echo "working..."
done

## Generate OpenVPN client configuration file
# ovpn파일을 사용하여 open vpn 서버 접속
docker exec openvpn show-client-config > fastcampus.ovpn
