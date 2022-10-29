terraform {
  # 해당 모듈을 사용하기 위한 terraform 버전 조건
  required_version = ">= 0.15"

  # 이 모듈을 사용하기 위한 provider 조건
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.45"
    }
  }
}
