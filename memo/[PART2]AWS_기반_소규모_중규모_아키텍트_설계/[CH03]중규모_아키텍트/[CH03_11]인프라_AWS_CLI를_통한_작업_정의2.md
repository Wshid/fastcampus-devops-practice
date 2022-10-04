## [CH03_11] (인프라) AWS CLI를 통한 작업 정의2

### Trouble shooting
- ecsTaskRole을 cli json 작업 생성시에 추가
```json
{
    "family": "fargate-cli", 
    "networkMode": "awsvpc", 
    "executionRoleArn": "ecsTaskRole", -- 접근 가능한 role을 추가, task에 Role 부여
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

#### 이후 작업 등록
```bash
aws ecs register-task-definition --cli-input-json file://./fargate-task.json
```

### 작업 정의 나열
```bash
aws ecs list-task-definitions
```

### 서비스 생성
```bash
# task-definition 및 subnet도 추가 정의 필요
aws ecs create-service --cluster clli-fargate --service-name fargate-service --task-definition farget-cli:1 --desired-count 1 --launch-type "FARGATE" --network-configuration "awsvpcConfiguration={subnets=[subnet-abcd1234],securityGroups=[sg-abcd1234]}"
```

### 정리 작업
```bash
aws ecs delete-service --cluster cli-fargate --service cli-fargate-service --force
aws ecs delete-cluster --cluster fargate-cluster
```
