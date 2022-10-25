provider "aws" {
  region = "ap-northeast-2"
}

# aws vpc를 생성
module "vpc" {
  # module의 source와 버전 설정(모듈별로 버전은 선택 사항)
  # https://developer.hashicorp.com/terraform/language/modules/sources, source별로 설정방법이 다름
  source  = "tedilabs/network/aws//modules/vpc"
  version = "0.24.0"

  name                  = "fastcampus"
  cidr_block            = "10.0.0.0/16"

  internet_gateway_enabled = true

  dns_hostnames_enabled = true
  dns_support_enabled   = true

  tags = {}
}

# public 용도로 사용하는 subnet 설정
module "subnet_group__public" {
  source  = "tedilabs/network/aws//modules/subnet-group"
  version = "0.24.0"

  # 모듈 참조 방법, module.name.output 형태
  name                    = "${module.vpc.name}-public"
  vpc_id                  = module.vpc.id
  # public ip가 자동 할당되도록
  map_public_ip_on_launch = true

  # 두개의 subnet 설정
  subnets = {
    "${module.vpc.name}-public-001/az1" = {
      cidr_block           = "10.0.0.0/24"
      availability_zone_id = "apne2-az1"
    }
    "${module.vpc.name}-public-002/az2" = {
      cidr_block           = "10.0.1.0/24"
      availability_zone_id = "apne2-az2"
    }
  }

  tags = {}
}

# private subnet 구성
module "subnet_group__private" {
  source  = "tedilabs/network/aws//modules/subnet-group"
  version = "0.24.0"

  name                    = "${module.vpc.name}-private"
  vpc_id                  = module.vpc.id
  # public ip 할당 해제
  map_public_ip_on_launch = false

  subnets = {
    "${module.vpc.name}-private-001/az1" = {
      cidr_block           = "10.0.10.0/24"
      availability_zone_id = "apne2-az1"
    }
    "${module.vpc.name}-private-002/az2" = {
      cidr_block           = "10.0.11.0/24"
      availability_zone_id = "apne2-az2"
    }
  }

  tags = {}
}

# public routing table 구성
module "route_table__public" {
  source  = "tedilabs/network/aws//modules/route-table"
  version = "0.24.0"

  name   = "${module.vpc.name}-public"
  vpc_id = module.vpc.id

  # public subnet의 id들을 가져옴
  subnets = module.subnet_group__public.ids

  ipv4_routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.vpc.internet_gateway_id
    },
  ]

  tags = {}
}

# private routing table, nat gateway, nat instance 등에서 활용
module "route_table__private" {
  source  = "tedilabs/network/aws//modules/route-table"
  version = "0.24.0"

  name   = "${module.vpc.name}-private"
  vpc_id = module.vpc.id

  subnets = module.subnet_group__private.ids

  ipv4_routes = []

  tags = {}
}
# 해당 설정 이후 terraform init - 모듈 다운로드
# terraform apply, 모듈 설정 
