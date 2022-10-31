build {
  name = "aws"

  sources = [
    "amazon-ebs.ubuntu",
  ]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  # 파일 업로드 수행, 권한 이슈로 /tmp와 같은 임시 디렉터리에 업로드
  provisioner "file" {
    source      = "${path.root}/files/run-docker-openvpn.sh"
    destination = "/tmp/run-docker-openvpn.sh"
  }

  provisioner "shell" {
    inline = [
      "mkdir -p /opt/openvpn",
      "cp /tmp/run-docker-openvpn.sh /opt/openvpn/run-docker-openvpn.sh" # 임시 파일을 정식 경로로 복사
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/scripts/update-apt.sh",
      "${path.root}/scripts/install-common-tools.sh",
      "${path.root}/scripts/configure-locale.sh",
      "${path.root}/scripts/install-docker.sh", # 이후 openVPN을 수행하지 X, run-docker-openvpn.sh에서 수행
      "${path.root}/scripts/clean-apt.sh",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  post-processor "manifest" {
    output     = "dist/packer-manifest.json"
    strip_path = true
  }
}
