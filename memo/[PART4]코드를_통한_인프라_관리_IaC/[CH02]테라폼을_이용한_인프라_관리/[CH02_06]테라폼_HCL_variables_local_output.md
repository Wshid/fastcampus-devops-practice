## [CH02_06] 테라폼 HCL variables local output
- https://developer.hashicorp.com/terraform/language/values/variables
- `2-terraform/05-variable-local-output/main.tf`
- 변수 지정 우선순위
  - https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence
  - 환경 변수
    ```bash
    export TF_VAR_vpn_name="test"
    ```
  - 파일내 선언 
    - `terraform.tfvars`
      ```conf
      vpc_name="fastcampus"
      ```
    - `terraform.tfvars.json`
  - apply시 직접 지정
    - `-var, -var-file`
    ```bash
    terraform apply -var-file=test.tfvars
    terraform apply -var="vpc_name=fastcampus"
    ```
  - `test.auto.tfvars`로 지정시, apply시 자동 지정
- Arguments
  - https://developer.hashicorp.com/terraform/language/values/variables#arguments
  - `default, file, description`을 주로 사용

### Local variables
- https://developer.hashicorp.com/terraform/language/values/locals
  
### Output variables
- https://developer.hashicorp.com/terraform/language/values/outputs
- terraform 코드가 구동되고 나서 출력할 내용들
- terraform 다른 모듈에서 참고할때, 해당 output을 입력으로 활용 가능

### 정리
- Terraform vs Function
  - variable -> argument
  - local variable -> local variable
  - output -> return value