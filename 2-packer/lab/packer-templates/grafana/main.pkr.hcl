build {
  name = "aws"

  sources = [
    "amazon-ebs.ubuntu",
  ]

  provisioner "shell" {
    inline = [
      # user data로 지정된 데이터를 기다리고, 이후 진행
      "cloud-init status --wait",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  provisioner "shell" {
    scripts = [
      "${path.root}/scripts/update-apt.sh",
      "${path.root}/scripts/install-common-tools.sh",
      "${path.root}/scripts/configure-locale.sh",
      "${path.root}/scripts/install-docker.sh",
      "${path.root}/scripts/run-docker-grafana.sh",
      "${path.root}/scripts/clean-apt.sh",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  post-processor "manifest" {
    output     = "dist/packer-manifest.json"
    strip_path = true
  }
}
