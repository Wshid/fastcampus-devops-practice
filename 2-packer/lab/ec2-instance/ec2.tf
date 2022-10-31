data "aws_ami" "fastcampus" {
  for_each = toset([
    "openvpn",
    "grafana",
  ])

  most_recent = true

  filter {
    name   = "name"
    # grok 문법을 사용하여 openvpn, grafana의 최신 AMI를 가져오도록 
    values = ["ubuntu/20.04/amd64/${each.key}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # terraform을 수행하는 aws account와 동일 계정
  owners = ["self"]
}

resource "aws_instance" "grafana" {
  # grafana의 최신 ami
  ami           = data.aws_ami.fastcampus["grafana"].image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["private"].ids[0]
  key_name      = "fastcampus"

  vpc_security_group_ids = [
    module.sg__ssh.id,
    module.sg__grafana.id,
  ]

  tags = {
    Name = "${local.vpc.name}-grafana"
  }
}

locals {
  openvpn_userdata = templatefile("${path.module}/files/openvpn-userdata.sh", {
    vpc_cidr  = local.vpc.cidr_block
    public_ip = aws_eip.openvpn.public_ip
  })
  common_tags = {
    "Project" = "openvpn"
  }
}

resource "aws_instance" "openvpn" {
  ami           = data.aws_ami.fastcampus["openvpn"].image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["public"].ids[0]
  key_name      = "fastcampus"

  user_data = local.openvpn_userdata

  associate_public_ip_address = false
  vpc_security_group_ids = [
    module.sg__ssh.id,
    module.sg__openvpn.id,
  ]

  tags = {
    Name = "${local.vpc.name}-openvpn"
  }

  # EIP를 이용, 코드가 변경되지 않더라도, aws instance를 계속 재생성하려고 할 것
  # 값이 변경되더라도 terraform apply시 무시하기
  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
    ]
  }
}
