## [CH03_10] (인프라) AWS CLI를 통한 작업 정의1
- 작업 정의시, AWS CLI를 사용하면
  - Fargate, CLI, EXTERNAL을 사용할때 명령어가 달라짐
- 참고 URL
  - https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/ECS_AWSCLI_Fargate.html

### 실습
```bash
aws ecs create-cluster --cluster-name fargate-cluster
```

#### 작업 정의 등록
- 하단 json에 따라 작업 진행
- 작업 정의 파라미터 매뉴얼
  - https://docs.aws.amazon.com/ko_kr/AmazonECS/latest/developerguide/task_definition_parameters.html
```json
{
    "family": "fargate-cli", 
    "networkMode": "awsvpc", 
    "containerDefinitions": [
        {
            "name": "django-cli", 
            "image": "public.ecr.aws/docker/library/httpd:latest", -- 실제 이미지 검색
            "portMappings": [
                {
                    "containerPort": 8000, 
                    "hostPort": 80, 
                    "protocol": "tcp"
                }
            ], 
            "essential": true, 
            "entryPoint": [
                "sh",
		        "-c"
            ]
        }
    ], 
    "requiresCompatibilities": [
        "FARGATE"
    ], 
    "cpu": "256", 
    "memory": "512"
}
```
- cpu,mem 의 경우 비용이 발생할 수 있으므로 유의
- image의 경우 검색해서 확인(구글링)
  - 혹은 GUI에서 확인

### Trouble Shooting
- 권한 에러 발생시 IAM에서 다음 권한 추가 필요
- 매뉴얼: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_execution_IAM_role.html
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

#### IAM role
```bash
# create
aws iam create-role \
      --role-name ecsTaskRole \
      --assume-role-policy-document file://./ecs-tasks-trust-policy.json # 실제 파일 task의 경로에 맞게 수행

# attach
aws iam attach-role-policy \
      --role-name ecsTaskRole \
      --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy
```