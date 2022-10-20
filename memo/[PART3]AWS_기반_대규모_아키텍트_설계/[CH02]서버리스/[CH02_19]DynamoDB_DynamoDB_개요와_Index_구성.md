## [CH02_19] (DynamoDB) DynamoDB 개요와 Index 구성

### AWS DynamoDB
- AWS의 NoSQL 서비스
- 빠른 쿼리 속도
- **수평 확장(Scale-out)이 쉽고 유연**
- Auto-Saciling 지원 / 일정 기간 백업 지원
- 스키마 지정 필요 X
- Transaction / Join과 같은 **복잡한 쿼리 불가**
- Ideal of applications with known access patterns
  - 접근하기 위한 방법이 패턴화 되어 있을때

### AWS DynamoDB - Table, Item, Attribute, Index
- Table
  - mysql의 테이블과 개념 동일
- Item
  - 하나의 객체
- Attribute
  - Key/Value
- Index
  - Partition Key
  - Sort Key
  - **Primary Key = Partition Key + Sort Key**
    - Partition Key가 중복되었을 때 활용할 수 있는 값
    - Identify한 값
  - GSI(Global Secondary Index)
    - 여러가지 키가 가능함
    - access pattern 어느정도 갖추어 졌을때 활용한 값
    - 검색 조건, 필터링 조건에 활용
    - e.g. mysql의 index
    - 운영중에 추가/변경이 가능함