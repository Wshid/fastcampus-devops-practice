## [CH02_07] 테라폼 HCL count와 for_each
- terraform init, apply 수행
- `2-terraform/06-count-for-each/main.tf`
- 유의 사항
  - count의 경우 정수 리스트 형태(list의 index)
    - 중간이 비어있을 경우 수동 관리 필요
  - for_each_map의 경우 key,value이기 때문에
    - 중간 제거를 해도 이슈가 없음