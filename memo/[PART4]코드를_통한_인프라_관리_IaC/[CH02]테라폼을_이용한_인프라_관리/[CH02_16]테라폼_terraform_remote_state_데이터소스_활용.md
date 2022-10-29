## [CH02_16] 테라폼 terraform_remote_state 데이터 소스 활용
- data 블록을 열어 사용 가능
- terraform provider
  - https://registry.terraform.io/providers/hashicorp/terraform/latest

### remote_state
- https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state
- 하나의 workspace -> 전체 인프라 관리 문제 x
- multi workspace -> 전체 인프라 관리
  - workspace가 많아짐
  - 각 workspace별 의존성이 발생
  - 이를 해결하기 위함
- workspace = state 관리 단위
  - remote_state: 다른 workspace의 상태 파일을 참조하겠다는 의미
  - backend별 설정 지정 필요
- `2-terraform/14-terraform-remote-state`