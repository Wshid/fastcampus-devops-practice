# amazon-ami data soucrce 활용
data "amazon-ami" "ubuntu" {
  # filter를 걸어 사용
  filters = {
    virtualization-type = "hvm"
    name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
    root-device-type = "ebs"
  }
  owners = ["099720109477"]
  most_recent = true
}

# data-source로 로드한 내용을 source로 사용
source "amazon-ebs" "ubuntu" {
  instance_type = "t2.micro"
  region        = "ap-northeast-2"
  source_ami = data.amazon-ami.ubuntu.id

  ssh_username = "ubuntu"
}
