bas## [CH02_03] AWS EC2 monitoring #2
- 기본 제공하는 metric외에 필요한 내용은 custom 필요
- custom metric
  - CloudWatch agent -> Amazon CloudWatch
  - agent에서 메트릭을 cloud watch에 보냄
  - policy role, iam 설정 필요

### 실습
- EC2 Instance 생성
- `devops_infra/apne2/dev/ec2/dmz_app01/_terraform.auto.tfvars`
- CloudWatchAgentServerPolicy 필요
```bash
# cw agent 설치
sudo yum install -y amazon-cloudwatch-agent

# 커스텀하게 설정할 수 있는 wizard
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-config-wizard
# EC2외에 On-Promise로도 지정 가능
```