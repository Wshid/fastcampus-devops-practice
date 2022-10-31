build {
  name    = "fastcampus-packer"

  source "amazon-ebs.ubuntu" {
    name     = "nginx"
    ami_name = "fastcampus-packer"
  }

  # 빌드 산출물을 바로 입력 받음
  post-processor "manifest" {}


  post-processors {
    # Post-processors[0]에 한하여 빌드 산출물을 입력받음
    ## 이후 후처리 산출물을 다음 post-processor에 전달
    post-processor "shell-local" {
      inline = ["echo Hello World! > artifact.txt"]
    }
    # 특정 파일을 다음 post-processor의 입력으로 보냄
    post-processor "artifice" {
      files = ["artifact.txt"]
    }
    # .tar.gz 형태로 압축
    post-processor "compress" {}
  }

  post-processors {
    # Post-processors[0]에 한하여 빌드 산출물을 입력받음
    post-processor "shell-local" {
      inline = ["echo Finished!"]
    }
  }
}
