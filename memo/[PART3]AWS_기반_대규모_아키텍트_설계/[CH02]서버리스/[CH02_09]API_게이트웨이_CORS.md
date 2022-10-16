## [CH02_09] (AWS 게이트웨이) CORS

### 실습

#### CORS 활성화
- API Gateway, 리소스
- `GET /shops`, 작업 - CORS 활성화
- Allow-Origin: `"*"`
  - 특정 도메인만 허용할 경우 수정
- **CORS 활성화 및 기존의 CORS 헤더 대체** 클릭

#### 이후 작업 및 Lambda script 수정
- `GET`외에 `OPITON`이 생성됨
  - 내부 URL 호출전, 호출이 가능한지 확인하기 위함
- second 스테이지 배포
- lambda 수정
  ```python
  def lambda_handler(event, context):
    print(event['key1'])
    return {
      'statusCode': 200,
      'body': json.dumps('Hello from new'),
      'headers': {
        'Content-Type':'application/json',
        'Access-Control-Allow-Origin':'*'
      }
    }
  ```
- 테스트 방법
  - 스테이지 탭 클릭 밀, 상단 노출되는 URL 호출