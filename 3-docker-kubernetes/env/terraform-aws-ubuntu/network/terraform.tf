terraform {
  # terraform 코드 변경 없이, 구동 가능
  # terraform apply로 구동 -> aws에서 네트워크 구성 진행
  backend "local" {
  }
}


###################################################
# Local Variables
###################################################

locals {
  context = yamldecode(file(var.config_file)).context
  config  = yamldecode(templatefile(var.config_file, local.context))
}


###################################################
# Providers
###################################################

provider "aws" {
  region = "ap-northeast-2"
}
