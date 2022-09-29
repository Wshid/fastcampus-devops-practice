## [CH02_25] (인프라) AWS CloudFront 생성 및 캐싱 설정

### Cloud Front 검색
- Cloud Front Distributions, Create
- Origin Domain Name: Elastic Load Balancer를 설정해주어야 함
- HTTP Only
- Distribution Settings
  - Price class: Edge Location은 많은 내용을 선택해도 되나, 비용이 비쌈
- Create Distribution

### Cloud Front 추가 수정
- Edit Distribution
  - Alternative Doamin Names(CNAME)내부에
    - 등록하고자 하는 도메인, www 도메인 입력
  - SSL Certificate 설정
    - Custom SSL, 식별자가 동일한지 확인

### Route 53
- A 유형의 레코드로, Load Balancer에 연결되는게 아닌
  - CloudFront로 연결 해야함
- Route 53의 레코드 편집
  - Load Balancer의 별칭이 아닌 **CloudFront 배포에 대한 별칭**으로 진행

### CloudFront 추가 설정
- 캐시 업데이트 관련 설정
- 서비스 Behavior 수정
- Cache key and origin requests
  - Legacy, Object caching - Customize
  - TTL?
    - 전 세계 distribution의 업데이트 하는데 걸리는 시간
    - php와 같이 app에서 내부 설정하더라도, 해당 서버의 min/max 사이에 맞게 움직임
