#!/bin/bash

# CN 정보의 경우 metadata에서 가져오므로 정의 X
export OVPN_NETWORK="172.22.0.0 255.255.240.0"
export OVPN_ROUTES="172.22.0.0 255.255.240.0, 10.222.0.0 255.255.0.0" # VPC에서 사용하는 CIDR이 추가됨
export OVPN_DNS_SERVERS="10.222.0.2"

/opt/openvpn/run-docker-openvpn.sh
