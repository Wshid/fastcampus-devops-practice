## [CH02_03] (AWS 게이트웨이) AWS 게이트웨이란

### AWS API 게이트웨이
- **API Gateway**는 개발자가 손쉽게 API를 생성, 게시, 유지관리, 모니터링 및 보안 유지를 할 수 있도록 하는
  - **완전관리형 서비스**
- AWS에서 제공하는 API Gateway 서비스
- 예시
  ```python
  # Redirecting
  Request.get('fastcampus.com') -> API Gateway(gate/a -> .com, gate/b -> .org) -> fastcampus.com
  Request.get('fastcampus.org') -> API Gateway -> fastcampus.org
  ```
  - 외부 호출하는 매핑룰을 변경(하나의 layer)

### 3가지 구성
- **HTTP API**, **Rest API**, Websocket API
  - HTTP API가 저렴하고 단순함
- API에 일괄적으로 인증을 붙일 수 있음(권한부여)
- CORS Flow 구성 가능