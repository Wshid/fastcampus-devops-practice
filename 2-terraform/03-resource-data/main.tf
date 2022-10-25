provider "aws" {
  region = "ap-northeast-2"
}

data "aws_ami" "ubuntu" {
  # 가장 최신 ami만 가져오기
  most_recent = true

  filter {
    # name에 대해, 정규표현식에 해당하는 모든 ami 버전을 가져옴
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  # 가상화 타입 필터링
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # Canonical(회사)가 만든 이미지
  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "ubuntu" {
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ami#attributes-reference
  ami           = data.aws_ami.ubuntu.image_id
  instance_type = "t2.micro"

  tags = {
    Name = "fastcampus-ubuntu"
  }
}
# 해당 내용 설정 이후, terraform apply