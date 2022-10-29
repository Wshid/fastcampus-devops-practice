provider "aws" {
  region = "ap-northeast-2"
}

data "terraform_remote_state" "network" {
  # 디렉터리 기준, remote repository 지정
  backend = "local"

  config = {
    path = "${path.module}/../network/terraform.tfstate"
  }
}

# remote module에서 outputs가 지정 되어 있어야 참조 가능
locals {
  vpc_name      = data.terraform_remote_state.network.outputs.vpc_name
  subnet_groups = data.terraform_remote_state.network.outputs.subnet_groups
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["public"].ids[0]


  tags = {
    Name = "${local.vpc_name}-ubuntu"
  }
}
