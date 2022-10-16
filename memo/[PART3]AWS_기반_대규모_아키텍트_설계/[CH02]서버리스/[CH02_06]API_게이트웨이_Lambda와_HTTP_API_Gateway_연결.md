## [CH02_06] (AWS 게이트웨이) Lambda와 HTTP API Gateway 연결

### 실습
- 정적 url path 지정
- Lambda 접속
- 코드 수정
  ```python
  import json

  def lambda_handler(event, context):
    print(event['key1'])
    return {
      'statusCode': 200,
      'body': json.dumps('Hello from Lambda!')
    }
  ```
- api gateway 접속
- HTTP API 구축
- API 이름 지정(검토 및 생성)
- 생성
- URL 확인
- 좌측 탭 - 경로
- create(경로 및 메서드)
  ```bash
  GET /
  ```
  - GET 선택 후 **통합 생성 및 연결** 클릭
- 통합 대상: Lambda 함수
- 생성 했던 lambda 함수 클릭
- 생성

### 실습2
- 동적 url path 지정
- 경로 - create
  ```bash
  ANY /shops/{id}
  ```
- 통합 생성 및 연결
- Lambda 함수 지정
- Lambda 함수 수정
  ```python
  import json

  def lambda_handler(event, context):
    print(event['key1'])
    return {
      'statusCode': 200
      # print(event)를 통해 event 내용 확인후, 파라미터 지정
      'body': json.dumps({
        'id': event['pathParameters']['id'],
        'filter': event['queryStringParameters']['filter']
      })
    }
  ```