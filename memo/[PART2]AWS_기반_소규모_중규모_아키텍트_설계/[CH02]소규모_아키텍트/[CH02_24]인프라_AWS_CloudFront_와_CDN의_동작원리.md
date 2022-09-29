## [CH02_24] (인프라) AWS CloudFront와 CDN의 동작원리

### CloudFront
- Cache + CDN
- 기본적으로는 Cache 서버
- Cache 서버는 **전 세계**에 흩어져 있는 인프라를 활용하기 때문에 추가적으로 CDN의 기능 보유
- 웹 서버의 비용 감소
- 전 세계의 유저를 대상으로 **고속으로 웹서비를 제공하도록 하는 서비스**

### Cache - 기존 방식
- C가 요청할 때마다 서버가 응답해주는 방식
- HTML 문서를 준비해놨다가 뿌려주는 것이 아니라, 동적으로 생성하는 방식
- 유저 입장에서는 느림
- 서버 입장에선 **서버 비용**이 많이 나감

### Cache - 새로운 방식
- C가 요청하여 응답한 결과를 Cache로 저장
- 다음 번에 C가 요청할 때는 기존 S에 요청할 필요 없이
  - Cache server에 요청하여 저장된 정보를 추출
- 요청할때마다 **동적 생성**이 아닌
  - 준비된 데이터를 Cache에 저장하고 그걸 그대로 뿌려줌
- **User -> Cache Server(distribution) -> Server(origin)**
- Cache 정보를 업데이트 하기 위해, 일정 주기를 설정하여 업데이트
- 주로 자주 변경되지 않는 내용을 Cache 용도로 사용

### CDN
- 전 세계 어느 위치에 접속하더라도 **바른 속도**로 서비스 할 수 있도록 하는 서비스
- Content Delivery Network
- 전 세계에 흩어져 있는 Edge Location(Cache 서버)를 활용

### FLOW
- Certificate Manager -> Route 53 -> Cloud Front -> ALB -> EC2