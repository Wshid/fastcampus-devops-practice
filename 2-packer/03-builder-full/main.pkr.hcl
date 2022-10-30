build {
  name    = "fastcampus-packer"

  source "amazon-ebs.ubuntu" {
    name     = "vault"
    ami_name = "fastcampus-packer-vault"
  }

  # 똑같은 이름의 source 정의 가능
  source "amazon-ebs.ubuntu" {
    name     = "consul"
    # account 내에서 ami는 중복될 수 x
    ami_name = "fastcampus-packer-consul"
  }

  # provisioner, post-processor는 순서가 중요함
  # 서버를 실행하고 어떤 내용을 실행할지 정의
  provisioner "shell" {
    inline = [
      "echo Hello World!"
    ]
  }

  provisioner "shell" {
    inline = [
      "echo Next World!"
    ]
  }

  # process이후 어떤 작업을 처리할지
  post-processor "shell-local" {
    inline = [
      "echo Hello World!"
    ]
  }

  post-processor "shell-local" {
    inline = [
      "echo Next World!"
    ]
  }
}
