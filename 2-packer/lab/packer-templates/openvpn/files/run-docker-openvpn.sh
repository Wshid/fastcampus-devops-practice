#!/usr/bin/env bash

set -euf -o pipefail

# 169.254.169.254, EC2 Metadat Server Magic IP
# 본인의 public ip를 가져옴
public_ip=`curl 169.254.169.254/latest/meta-data/public-ipv4`

echo "------------------"
echo $OVPN_NETWORK
echo $OVPN_ROUTES
echo $OVPN_DNS_SERVERS
echo "------------------"
## Run openvpn-ldap-otp container
docker run \
 --name openvpn \
 --restart always \
 --volume openvpn-data:/etc/openvpn \
 --detach=true \
 -p 1194:1194/udp \
 --cap-add=NET_ADMIN \ # OpenVPN 수행을 위한 환경변수 지정 필요, OVPN_SERVER_CN, OVPN_NETWORK, OVPN_ROUTES, OVPN_DNS_SERVERS
 -e "OVPN_SERVER_CN=${OVPN_SERVER_CN:-$public_ip}" \ # 도메인 혹은 IP 기입, instance를 수행할때 IP를 할당하도록
 -e "OVPN_ENABLE_COMPRESSION=false" \
 -e "OVPN_NETWORK=${OVPN_NETWORK:-172.22.16.0 255.255.240.0}" \ # 가상 IP 대역
 -e "OVPN_ROUTES=${OVPN_ROUTES:-172.22.16.0 255.255.240.0}" \ # VPN 내부망에 대해서만 지정, AWS VPC CIDR
 -e "OVPN_DNS_SERVERS=${OVPN_DNS_SERVERS}" \ # VPC private DNS
 -e "OVPN_NAT=true" \
 -e "USE_CLIENT_CERTIFICATE=true" \
 wheelybird/openvpn-ldap-otp:v1.4

## Wait to ready OpenVPN Server
# open vpn 수행 이후 client 인증서 발급 지정, 이후 fastcampus.ovpn 파일 생성
until echo "$(docker exec openvpn show-client-config)" | grep -q "END PRIVATE KEY" ;
do
  sleep 1
  echo "working..."
done

## Generate OpenVPN client configuration file
docker exec openvpn show-client-config > /opt/openvpn/fastcampus.ovpn
