## [CH02_13] 도커 컨테이너 다루기 AWS ECR 저장소 이용

### 실습
- AWS ECR 검색 및 접속
- Repositories 탭 접속
- Private - Create repository
  - Image scan setting을 켜면 비용이 발생할 수 있음
- `View Push Command`로 push로 푸시 방법 확인
  ```bash
  docker pull nginx
  aws sts get-caller-identity
  export AWS_PRIOFILE=fastcampus
  
  aws sts get-caller-identity

  # View Push Command 매뉴얼 복사
  aws ecr get-login-password --region ap...

  docker tag nginx:latest ..amazonaws.com/my-nginx:v1.0.0
  docker push ..amazonaws.com/my-nginx:v1.0.0
  ```