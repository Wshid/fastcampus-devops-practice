## [CH03_13] (인프라) ECS-CLI Compose를 활용한 Container 배포2
- ECR의 레포지토리 업로드
- ECS-CLI가 필요
  - aws-cli와 다름
  - docker-compose와 유사한 기능을 수행할 수 있음
- github: https://github.com/aws/amazon-ecs-cli

### ECS-CLI 다운로드
```bash
sudo curl -Lo /usr/local/bin/ecs-cli {ecs-cli-linux-amd64-latest}

# gpg, 인증 관련
sudo apt-get install gnupg
## 보통 keys라는 폴더로 생성해서 관리한다고 함
mkdir keys
cd dkys
vi amazon-ecs-public-key.gpg # COPY: https://github.com/aws/amazon-ecs-cli/blob/mainline/amazon-ecs-public-key.gpg

gpg --import amazon-ecs-public-key.gpg
crul -o ecs-cli.asc {ecs-cli-linux-amd64-latest.asc}
gpg --verify ecs-cli.asc /usr/local/bin/ecs-cli
sudo chmod +x /usr/local/bin/ecs-cli
ecs-cli --version
```

#### IAM 사용자 추가 과정
- access-key, secret-key를 기준으로 로드
```bash
sudo apt isntall awscli
aws configure
# access-key, secret-key 설정

aws ecr get-login --no-include-email --region us-east-2
# 로그인 정보 복사 및 입력
```

#### docker 설정
```
docker tag docker-server/django {URI}
docker push {URI}
docker tag docker-server/nginx {URI}
docker push {URI}
```

#### IAM policy 추가
```bash
# aws configure
aws iam attach-role-policy --role-name ecsTaskExecutionRole --policy-arn:arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
```

#### ECS CLI 설정
- https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/ECS_CLI_Configuration.html
```bash
# cli-cluster 생성
ecs-cli --empty --clustre cli-cluster

# profile에 따라 ecs-cli의 실행 주체 설정(어떤 IAM 계정으로 실행할지)
ecs-cli configure profile --profile-name song --access-key {access-key} --secret-key {secret-key}

# 프로필이 사용할 클러스터
# config-name은 설정값들의 집합 구분자
ecs-cli configure --cluster cli-cluster --default-launch-type FARGATE --region us-east-2 --config-name cli-config

# 위의 설정을 저장하는 과정
ecs-cli configure default --config-name cli-config
ecs-cli configure profile default --profile-name song # song의 프로필 불러오기
```

### ECS Compose
- EC2와 ECS에서 올릴때 compose 파일 문법이 다름
- docker-compose.yml
```yaml
version: '3'
services:
  nginx:
    # container_name: nginx
    build: ./nginx
    image: {nginx image uri}
    restart: always # 항상 재시작
    ports:
      - "80:80"
    volumes:
      - ./fastcampus_test:/src/docker-django
      - ./log:/var/log/nginx
    depends_on: # 실제 설정은 ecs-params.yml에서 수행
      - django
  
  django:
    # container_name: django
    build: ./fastcampus_test
    image: {django image uri}
    restart: always
    command: uwsgi --ini uwsgi.ini
    volumes:
      - ./fastcampus_test:/srv/docker-django
      - ./log:/var/log/uwsgi
```

### ECS parameter 설정
- docker image간의 dependency 설정
  - depends_on이 ECS의 compose에는 없음, 이를 보강
- ecs-params.yml
```yaml
verision: 1
task_definition:
  task_execution_role: ecsTaskExecutionRole
  ecs_network_mode: awsvpc
  task_size:
    mem_limit: 0.5GB
    cpu_limit: 256
  run_params:
    network_configuration:
      awsvpc_configuration:
        subnets:
          - "subnet-..."
          - "subnet-..."
        security_groups:
          - "sg-..."
        assign_public_ip: ENABLED
services:
  django:
    essential: boolean
  nginx:
    depends_on:
      - container_name: django
```

### ECS-CLI Compose
```bash
# 서비스 생성
ecs-cli compose --file docker-compose.yml --ecs-params ecs-params.yml service create --launch-type FARGATE

# 작업 실행
ecs-cli compose --file docker-compose.yml service start
```

### 결론
- 클러스터 하나에 FARGATE 서비스를 올리는 작업
