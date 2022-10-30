terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    # 실습 환경에 따라 수정 필요
    organization = "fastcampus-devops"

    workspaces {
      # 실습 환경에 따라 수정 필요
      name = "terraform-lab-network"
    }
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
