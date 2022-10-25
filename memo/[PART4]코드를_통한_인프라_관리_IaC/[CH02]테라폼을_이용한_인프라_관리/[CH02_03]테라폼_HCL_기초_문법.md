## [CH02_03] 테라폼 HCL 기초 문법
- https://developer.hashicorp.com/terraform/language

### 기초 문법
```conf
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}

<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>" {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}
```

### Files and Directories
- https://developer.hashicorp.com/terraform/language/files
- `.tf`는 HCL 문법을 따르는 파일
- `json`으로 활용하려면 `.tf.json` 형태 사용
- 유의 사항
  - init, plan, apply
  - 현재 위치에서 `.tf, .tf.json`을 파일을 기준으로 설정
    - sub-directory까지 스캔하지 X
- `UTF-8` 인코딩을 활용해야 함
  - LF 인코딩 추천
- Directory와 Module
  - 디렉터리를 Module이라 부르기도 함
  - 사용하는 시기에 이 디렉터리가 어떤 용도로 사용하였는가에 따라 구분
  - `terraform apply`가 수행된 디렉터리가 `root module`, 하위가 `child module`
    - root module
    - child module

### Syntax

#### Idnetifier
- https://developer.hashicorp.com/terraform/language/syntax/configuration#identifiers
- letter, digit, _, - 사용 가능
- 단 숫자로 시작 불가

#### Comments
- `#`, `//`, `/*...*/` 형태 모두 지원

#### Style Conventions
- Indentation: two space
- arument 대입시에는 `=` 사용
- logical한 그룹을 공백라인을 추가하여 구성 가능
- `meta-argument`
  - `count, for-each, lifecycle, ...`

### 예시 코드
- `2-terraform/02-syntax/main.tf`
- 자동 정렬 방법
  ```bash
  # help
  terraform fmt -h
  
  # 자동 정렬 진행, 변경 사항 확인 가능
  terraform fmt -diff
  ```
