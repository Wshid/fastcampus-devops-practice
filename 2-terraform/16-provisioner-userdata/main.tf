provider "aws" {
  region = "ap-northeast-2"
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

locals {
  vpc_name = "default"
  common_tags = {
    "Project" = "provisioner-userdata"
  }
}
# 계정 생성시 기본 vpc를 사용
resource "aws_default_vpc" "default" {
  tags = {
    Name = local.vpc_name
  }
}

# 22, 80 port

module "security_group" {
  source  = "tedilabs/network/aws//modules/security-group"
  version = "0.24.0"

  name        = "${local.vpc_name}-provisioner-userdata"
  description = "Security Group for test."
  vpc_id      = aws_default_vpc.default.id

  ingress_rules = [
    {
      id          = "ssh"
      protocol    = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH from anywhere."
    },
    {
      id          = "http"
      protocol    = "tcp"
      from_port   = 80
      to_port     = 80
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP from anywhere."
    },
  ]
  egress_rules = [
    {
      id          = "all/all"
      description = "Allow to communicate to the Internet."
      protocol    = "-1"
      from_port   = 0
      to_port     = 0

      cidr_blocks = ["0.0.0.0/0"]
    },
  ]

  tags = local.common_tags
}


###################################################
# Userdata
###################################################

resource "aws_instance" "userdata" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  # ssh key name
  key_name      = "fastcampus"

  # EOT: multiline string
  # bash shell script, yaml file 등에서 활용 가능
  # user_data의 내용이 수정되게 되면, apply시 새로운 리소스 생성됨(현업에서 유의)
  user_data = <<EOT
#!/bin/bash
sudo apt-get update
sudo apt-get install -y nginx
EOT

  vpc_security_group_ids = [
    module.security_group.id,
  ]

  tags = {
    Name = "fastcampus-userdata"
  }
}


###################################################
# Provisioner - in EC2
###################################################

# resource "aws_instance" "provisioner" {
#   ami           = data.aws_ami.ubuntu.image_id
#   instance_type = "t2.micro"
#   key_name      = "fastcampus"

#   vpc_security_group_ids = [
#     module.security_group.id,
#   ]

#   tags = {
#     Name = "fastcampus-provisioner"
#   }

#   # remote machine provisioner
#   provisioner "remote-exec" {
#     inline = [
#       "sudo apt-get update",
#       "sudo apt-get install -y nginx",
#     ]
#     # password, private key 인증을 해야하나,
#     # 현업에서는 ssh-agent 운영체제를 사용하여, 코드상에 보안 정보가 남지 않게 할 수 있음
#     connection {
#       type = "ssh"
#       user = "ubuntu"
#       # provisioner에서만 사용 가능한 구문
#       host = self.public_ip
#     }
#   }
# }


###################################################
# Provisioner - in null-resources
###################################################

resource "aws_instance" "provisioner" {
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"
  key_name      = "fastcampus"

  vpc_security_group_ids = [
    module.security_group.id,
  ]

  tags = {
    Name = "fastcampus-provisioner"
  }
}

# null_resource, https://registry.terraform.io/providers/hashicorp/null/latest/docs
# provisioner를 사용할 때 활용하는 트릭
# 해당 파일들의 내용이 변경되면 trigger에 해당
# triggers 내부 내용이 변경되면 force replace 하기 위함
resource "null_resource" "provisioner" {
  triggers = {
    insteance_id = aws_instance.provisioner.id
    script       = filemd5("${path.module}/files/install-nginx.sh")
    index_file   = filemd5("${path.module}/files/index.html")
  }

  provisioner "local-exec" {
    command = "echo Hello World"
  }

  provisioner "file" {
    # local 경로
    source      = "${path.module}/files/index.html"
    destination = "/tmp/index.html"

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.provisioner.public_ip
    }
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/install-nginx.sh"

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.provisioner.public_ip
    }
  }

  provisioner "remote-exec" {
    # /var/www... 권한은 root 권한이 필요하기 때문
    inline = [
      "sudo cp /tmp/index.html /var/www/html/index.html"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_instance.provisioner.public_ip
    }
  }
}
