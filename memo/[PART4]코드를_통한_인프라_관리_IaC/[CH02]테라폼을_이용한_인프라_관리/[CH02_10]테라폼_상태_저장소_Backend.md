## [CH02_10] 테라폼 상태 저장소 (Backend)

### Local State / Remote State
- Local State
  - terraform apply이후 생성된 파일
  - `terraform.tfstate`
- Remote State
  - 결과를 원격에 저장

### Terraform Backend(State Storage)
- Local Backend
  - 개인 작업만 가능
- Remote Backend(Terraform Cloud) -> simple/powerful
  - 여러 작업자가 작업 가능
  - 동시성 이슈 발생 가능
  - 고려 요소: Locking
    - terraform 상태파일을 원격에서 관리
    - 한명에게만 실행 권한을 주는 상태
- AWS S3 Backend(w/, w/o DynamoDB)
  - 기본적으로 lock 기능을 제공하지 X
  - DynamoDB를 제공했을 때 lock 기능을 지원

### 실습
- 2-terraform/09-s3-backend/main.tf
  - `terraform init`필요
    - local state를 remote로 옮기고 싶다는 console message 출력시 yes
- 2-terraform/10-tf-cloud-backend/main.tf
  - terraform cloud 사이트 접속
  - 계정 생성(free account)
  - create new organization
  - organiation 접속 후 코드 수정
- 개인 계정 - Token 생성 필요
  - 이후 `.terraformrc` -> credentials
