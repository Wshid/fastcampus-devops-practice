## [CH02_12] 테라폼 리소스 강제 교체하기 (taint & untaint)
- terraform init, apply
- taint
  - 리소스를 비정상적인 상태로 표시
  ```bash
  terraform taint "module.vpc.aws..."
  terraform apply # 비정상적인 리소스를 강제 교체
  # 자동으로 연관있는 하위 리소스까지 같이 교체됨

  # taint 상태를 해제할 때
  terraform untaint "module.vpc.aws..."

  # taint, apply과 유사한 명령, 단일 리소스 교체시 유용
  terraform apply -replace="module.vpc..."
  ```
