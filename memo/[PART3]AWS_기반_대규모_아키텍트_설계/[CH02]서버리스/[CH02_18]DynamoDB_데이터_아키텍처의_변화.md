## [CH02_18] (DynamoDB) 데이터 아키텍처의 변화

### 기존의 데이터베이스 형태
- 관계형 데이터베이스 시스템
- 데이터를 쌓기 전에, 스키마를 지정
- 일관성, 변동성 무, 예측 가능성
- 기업이 활용할 수 있는 데이터가 **다양해지면서** 단점이 부각됨
- 데이터 형식(스키마)의 변동이 잦음, 예측 불가능성

### DataLake, Nosql
- DataLake
  - 필요한 모든 종류의 데이터를 **있는 그대로**(변환작업 X) 저장하는 단일 저장소
  - `"지금은 필요 없지만, 나중에 필요할 수도 있다"`
- ETL(Extract, Transform, Load) -> **ELT(Extract, Load, Transform)**
- NoSQL(Not Only SQL)
- 형식 지정 x
- FLOW
  - 여러 종류의 데이터
    - log + stream + relational
  - DataLake: aws S3
  - 데이터 정제1: aws Redshift
  - 데이터 정제2: aws Athena, aws RDS
  - 분석: aws SageMaker, aws QuickSight
