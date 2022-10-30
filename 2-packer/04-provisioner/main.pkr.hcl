build {
  name = "fastcampus-packer"

  source "amazon-ebs.ubuntu" {
    name     = "nginx"
    ami_name = "fastcampus-packer-nginx"
  }

  # provisioner는 순서대로 수행
  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "whoami",
    ]
  }

  provisioner "file" {
    source      = "${path.root}/files/index.html"
    # ubuntu 사용자로 수행, 모든 사용자가 접근 가능한 tmp 하위로 생성
    destination = "/tmp/index.html"
  }

  provisioner "shell" {
    inline = [
      # 변수 레퍼런스
      # source.name = nginx, source.type = amazon_ebs
      "echo ${source.name} and ${source.type}",
      "whoami",
      "sudo apt-get install -y nginx",
      "sudo cp /tmp/index.html /var/www/html/index.html"
    ]
  }

  # 해당 provisioner가 수행하는 시기에 멈춤
  provisioner "breakpoint" {
    disable = false
    note    = "디버깅용"
  }
}
