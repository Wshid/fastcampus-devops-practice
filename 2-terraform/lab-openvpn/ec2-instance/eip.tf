resource "aws_eip" "openvpn" {
  tags = merge(
    {
      "Name" = "${local.vpc.name}-openvpn"
    },
    local.common_tags,
  )
}

resource "aws_eip_association" "openvpn" {
  # eip 할당시, 공인 ip 유지 가능(ec2 public ip는 변환 가능성 존재)
  instance_id   = aws_instance.openvpn.id
  allocation_id = aws_eip.openvpn.id
}
