data "aws_ami" "fastcampus" {
  # packer로 빌드한 이미지 가져오기
  for_each = toset([
    "openvpn",
    "grafana",
  ])

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/20.04/amd64/${each.key}-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

# grafana 인스턴스 생성
resource "aws_instance" "grafana" {
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
  common_tags = {
    "Project" = "openvpn"
  }
}

resource "aws_instance" "openvpn" {
  # openvpn의 ami를 가져옴
  ami           = data.aws_ami.fastcampus["openvpn"].image_id
  instance_type = "t2.micro"
  subnet_id     = local.subnet_groups["public"].ids[0]
  key_name      = "fastcampus"

  # eip를 생성하여 사용
  associate_public_ip_address = false
  vpc_security_group_ids = [
    module.sg__ssh.id,
    module.sg__openvpn.id,
  ]

  tags = {
    Name = "${local.vpc.name}-openvpn"
  }

  lifecycle {
    ignore_changes = [
      associate_public_ip_address,
    ]
  }
}

# openvpn은 grafana와 다르게 provisioning 필요
# openvpn의 서버의 대역에 영향을 받기 때문
# terraform의 provisioning(2)
# userdata: AWS EC2에서 제공하는 기능, os가 실행됨에 따라 수행, tf가 관리하지 x
# provisioner: tf에서 관리
# provisioning trigger하는 trick -> null_resources
resource "null_resource" "provisioner" {
  triggers = {
    # openvpn.id가 변경되었을 때
    insteance_id = aws_instance.openvpn.id
  }

  provisioner "remote-exec" {
    # packer, ansible local module을 통해 playbook 업로드 했던 상태
    # 이 playbook 파일을 한번 더 실행
    # -e: variable 설정
    inline = [
      "ansible-playbook /opt/ansible/playbook.yaml -e 'openvpn_create_client_config=true'"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      host = aws_eip.openvpn.public_ip
    }
  }
}
