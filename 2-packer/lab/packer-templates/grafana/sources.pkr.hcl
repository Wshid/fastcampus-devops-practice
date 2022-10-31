data "amazon-ami" "ubuntu" {
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
    root-device-type    = "ebs"
  }
  owners      = ["099720109477"]
  most_recent = true
}

locals {
  # 생성 시간 기록
  created_at = timestamp()
  # 생성 시간을 기반으로 버전 기입
  version = formatdate("YYYYMMDDhhmm", local.created_at)
  ami_name        = join("/", [
    "ubuntu",
    "20.04",
    "amd64",
    "${var.name}-${local.version}"
  ])
  # packer의 source ami
  source_tags = {
    "source-ami.packer.io/id"         = "{{ .SourceAMI }}"
    "source-ami.packer.io/name"       = "{{ .SourceAMIName }}"
    "source-ami.packer.io/owner-id"   = "{{ .SourceAMIOwner }}"
    "source-ami.packer.io/owner-name" = "{{ .SourceAMIOwnerName }}"
    "source-ami.packer.io/created-at" = "{{ .SourceAMICreationDate }}"
  }
  # 빌드 정보 태그
  build_tags = {
    "build.packer.io/name"       = var.name
    "build.packer.io/version"    = local.version
    "build.packer.io/os"         = "ubuntu"
    "build.packer.io/os-version" = "20.04"
    "build.packer.io/region"     = "{{ .BuildRegion }}"
    "build.packer.io/created-at" = local.created_at
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name        = local.ami_name
  ami_description = var.description
  source_ami    = data.amazon-ami.ubuntu.id

  instance_type = "t2.micro"
  region        = "ap-northeast-2"
  ssh_username = "ubuntu"

  # 빌드 과정중 태그(e.g. EC@, Security Group, EBS)
  run_tags = merge(
    local.source_tags,
    local.build_tags,
    {
      "Name" = "packer-build/${local.ami_name}",
    }
  )
  # 빌드 결과물 태그(AMI, Snapshot)
  tags = merge(
    local.source_tags,
    local.build_tags,
    {
      "Name" = local.ami_name,
    }
  )
}
