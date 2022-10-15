## [CH02_04] (AWS 게이트웨이) API 게이트웨이의 구성 요소들

### CORS
- Corss-Origin Resource Sharing
- Origin이 다른 API를 호출하는 경우(e.g. fastcampus.com, fastcampus.org)
- 보안상에 문제가 생길 수 있는 여지가 있는 API 호출(microservice)
  - microsoft상에서는 보안상 이슈가 없는 경우도 존재
- 경우
  - 다른 도메인(fast.com, fastcampus.com)
  - 다른 포트(fastcampus.com, fastcampus.com/5000)
  - 다른 프로토콜(https, http)

#### 특징
- 원래는 **같은 도메인**이 아닌, **다른 도메인**의 API를 호출할 수 x
- 어떤 도메인에서나 호출하게 하고 싶거나,
  - 특정 도메인에서만 호출하게 하고 싶다면 해당 부분 설정 필요(microservice)
- 적합한 사용자가 호출하는지 인증하는 역할

### CORS API 호출 순서
- 권한 체크(CORS Check)
- 허용
- 실제 API 콜

#### CORS API 호출 상세
- OPTIONS
  ```bash
  Access-Control-Request-Method: GET
  Access-Control-Request-Headers: Content-Type, Authorization, x-api-key
  ```
- 가능한 Method 응답
  ```bash
  Access-Control-Request-Method: GET, POST
  Access-Control-Request-Headers: Content-Type, Authorization, x-api-key
  # 가능한 Origin 확인
  Access-Control-Allow-Origin: *
  ```
- 실제 API Call

### Carany 배포
- Canary 릴리스 배포에서
  - 전체 API 트래픽은 **사전 공유된 비율**로
    - production release / canary release로 임의 분할
- 일반적으로
  - canary release에는 **API Traffic**중 **작은 백분율**이 주어지며
  - proudction release에 나머지 분배
- 업데이트된 API 기능은 **carany**를 통하는 API 트래픽에만 보입
- Canary 트래픽을 **적은 수준**으로 유지하고
  - 선택이 임의로 이루어지면,
  - 대부분의 사용자는 **새 버전의 잠재적 버그**로 인한 **부정적 영향을 받지 않으며**
  - 단일 사용자가 부정적 영향을 계속 받는 경우는 X
- 테스트 지표가 **요구 사항**을 통과한 후에는
  - **Canary Release**를 **Production Release**를 승격하고
  - 배포에서 Canary를 비활성화
- 이후 새 기능을 **production 단계**에서 사용 가능