## [CH02_03] jenkins pipeline 실습1 인프라 구축
- 실습 코드: https://github.com/dev-chulbuji/devops_06_03_jenkins

### 실습
```bash
cd devops_06_03_jenkins/infra/apne2/network/vpc
terraform init
# 생성할 리소스 확인, subnet, vpc, routing table등의 정보 확인
terraform plan

terraform apply --auto-approve

# v1.0.8
terraform --version

```
- aws gateway는 시간당 과금, 실습 이후 해제 필요

#### bastion setting
- `devops_06_03_jenkins/infra/apne2/ec2/bastion`
```bash
terraform init
terraform plan
terraform apply --auto-approve

vi ~/.ssh/config
Host bastion
HostName 54.180....
User ec2-user
IdentityFile ~/.ssh/dev.pem

ssh bastion
```

#### jenkins setting
- `devops_06_03_jenkins/infra/apne2/ec2/jenkins`

```bash
terraform init

vi ~/.terraformrc
# plugin_cache_dir로 동일한 플러그인 로드시 캐시 가능

export AWS_PROFILE=dj
terraform init

# iam 세팅을 추가적으로 진행(bastion에 비해)
terraform plan

terraform apply --auro-approve
```

#### ALB 생성
- `devops_06_03_jenkins/infra/apne2/alb/jenkins`
```bash
export AWS_PROFILE=dj
terraform init
terraform apply --auto-approve
```
- 이후 AWS - Load Balancer에서 `jenkins-alb` 확인 가능