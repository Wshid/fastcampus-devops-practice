build {
  name = "aws"

  sources = [
    "amazon-ebs.ubuntu",
  ]

  provisioner "shell" {
    # 3가지 명령 수행
    inline = [
      "mkdir -m 755 -p /opt/ansible",
      "chown -R ubuntu:ubuntu /opt/ansible",
      "cloud-init status --wait",
    ]
    execute_command = "sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
  }

  # ansible remote provisioner
  provisioner "ansible" {
    # ec2내에 ansible 설치
    playbook_file = "${path.root}/ansible/initialize.yaml"
    ansible_env_vars = [
      "ANSIBLE_HOST_KEY_CHECKING=False",
    ]
    ansible_ssh_extra_args = [
      "-o ForwardAgent=yes",
    ]
    user = "ubuntu"
  }

  # ansible local provisioner: remote에 ansible playbook 복사
  provisioner "ansible-local" {
    # 실제 provisioning을 위한 파일
    playbook_file = "${path.root}/ansible/playbook.yaml"
    staging_directory = "/opt/ansible/"
    clean_staging_directory = false
  }

  post-processor "manifest" {
    output     = "packer-manifest.json"
    strip_path = true
  }
}
