## [CH02_09] 테라폼 HCL 반복문 (For)
- https://developer.hashicorp.com/terraform/language/expressions/for
- Input Types
  - https://developer.hashicorp.com/terraform/language/expressions/for#input-types
- for의 index는 0부터 순차 증가
- map 형태 결과
  ```python
  # map 형태에서 활용
  for s in var.list : s => upper(s)
  # [a,b,c] -> {a=A, b=B, c=C}
  ```
- 조건문도 사용 가능
  ```python
  # 조건이 부합한 경우에만 수행
  [for s in var.list : upper(s) if s != ""]
  ```