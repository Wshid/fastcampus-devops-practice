## [CH02_20] (DynamoDB) DynamoDB 구성하기

### 실습
- Region 선택
- DynamoDB 검색
- 테이블 생성
  - 테이블 이름 지정
  - 파티션 키 지정
  - 정렬 키 지정
  - 설정 사용자 지정
  - 읽기/쓰기 용량 설정
    - 온디맨드: 필요할때마다 요금 청구 -> 선택
    - 프로비저닝됨: 할당해서 사용할 것인가의 의미
      - dynamoDB에 접속하는 트래픽이 어느정도 정형화 되어있을때 활용 가능
      - 읽기 용량 설정 auto scaling 켜기
      - 쓰기 용량 설정
  - 글로벌 인덱스 생성 - 스킵
  - 유휴시 암호화 - Amazon DynamoDB가 소유
  - 테이블 생성
- 테이블 클릭
  - 개요: 메타정보 확인 가능
  - 모니터링: CloudWatch를 통해 확인 가능
    - 단 CloudWatch Insight에 관한 권한을 설정해야 사용 가능
- 항목 클릭
- 항목 생성
  ```json
  {
    "OrderID": "1",
    "Date": "20211004"
  }
  ```
  - 동일한 항목을 추가하게 되면 에러 발생
    - PK(Partition Key + Sort Key) 중복
- 항목 생성
  ```json
  {
    "OrderID": "1",
    "Date": "20211005",
    "Item": "bag"
  }
  ```
  - 생성 가능
  - 새로 생성한 `Item`은 `attribute`가 됨
- 필터
  - 속성 이름: `OrderId`
  - `문자열 같음 1` 로 설정
  - 관련 특정 조건을 걸어서 검색 가능