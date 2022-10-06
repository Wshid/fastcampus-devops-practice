## [CH03_18] (인프라) AWS CodeDeploy2
- Github과 CodeDeploy를 활용한 배포
- 참고: https://docs.aws.amazon.com/codedeploy/latest/userguide/tutorials-github.html

### 실습
- EC2 생성 및 접속
- ECS 명령 수행
  ```bash
  sudo apt-get update
  sudo apt install awscli

  aws configure
  
  vi policy.json
  ```

#### policy.json
- 모든 권한을 가지는 policy

#### 이후 작업
```bash
aws iam create-policy --policy-name codedeploy-policy --policy-document file://policy.json
aws iam attach-user-policy --user-name ECS-CLI --policy-arn "arn:aws:iam:.../codedeploy-policy"
aws iam list-attached-user-policies --user-name ECS-CLI

vi CodeDeployDemo-Trust.json # https://docs.aws.amazon.com/codedeploy/latest/userguide/getting-started-create-service-role.html
aws iam create-role --role-name CodeDeployServiceRole --assume-role-policy-document file://CodeDeployDemo-Trust.json

aws iam attach-role-policy --role-name CodeDeployServiceRole --policy-arn "arn,,,/AWSCodeDeployRole"


https://docs.aws.amazon.com/codedeploy/latest/userguide/tutorials-github-create-application.html
```

#### CodeDeploy
- CodeDeploy 접속
- 어플리케이션 생성
- 생성 완료 후, 해당 그룹 선택
- 배포 그룹 설정
  - first_deployment_group 이름 설정
  - 서비스 역할 입력
    - `"arn:aws:iam:.../CodeDeploySeviceRole"`
- 로드 밸런서 활성화


#### 배포 생성
- 배포 그룹 선택
- 어플리케이션을 gitHub에 저장
- GitHub 토큰 입력
- 리포지토리 입력
- Commit id 입력
- 배포 만들기

### 결과 정리
- EC2보단 ECS를 많이 사용
- Code Commit이 일어날때 자동으로 배포가 일어남
