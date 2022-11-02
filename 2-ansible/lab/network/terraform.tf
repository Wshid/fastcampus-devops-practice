terraform {
  backend "remote" {
    # workspace와 organization은 환경에 맞게 수정 필요
    hostname     = "app.terraform.io"
    organization = "fastcampus-devops"

    workspaces {
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
