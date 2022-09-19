## [CH03_10] AWS 비용 이슈 대처법

### 프리티어 사용량 알림 설정
- ![image](https://user-images.githubusercontent.com/10006290/191014986-be76b648-8555-48c8-9d64-af41ad946cd5.png)
- **결제 알림 받기**를 활성화 해야
  - CloudWatch로 메트릭 모니터링 가능

### CloudWatch, SNS 주제 생성
- CloudWatch
  - AWS의 관측 시스템
  - 로그, 메트릭, 경보, 이벤트
  - **결제**에 대한 경보 생성 필요
  - e.g. 5USD이상 사용시 알람 등
- SNS(Simple Notification Service)
  - AWS의 관리형 메세징 서비스
  - 메세지 발행, pub/sub 모델
  - email, webhook, SQS, Lambda를 통한 구독 가능
- 경보 생성 완료
  - ![image](https://user-images.githubusercontent.com/10006290/191015943-b1ba7e7f-bf9f-421d-a3be-2f912c35a789.png)

### 테스트 전 비용 검토
- 서비스 별 요금 페이지
  - VPC 요금 페이지: https://aws.amazon.com/ko/vpc/pricing
- 비용 계산기
  - https://calculator.aws
  - 사용할 AWS 리소스와 옵션을 기입하여 예상 금액 시뮬레이션

### 테스트 후 리소스 정리
- AWS 서비스는
  - 하나의 서비스를 만들더라도, 여러 AWS 리소스가 생성될 수 있음
  - 리소스 추적이 어려울 경우 **전체 리소스 제거**하는 것도 방법
- 오픈소스 도구: aws-nuke
  - https://github.com/rebuy-de/aws-nuke

### 프리티어 계정이 만료된 경우
- Gmail에서 plus 사용하기
  - 사용자 아이디 뒤에 `+` 접미사를 붙여 새로운 이메일 주소 생성 가능
  - e.g. `a+dev@gmail.com`과 `a+test@gmail.com`으로 이메일을 보내더라도
    - `a@gmail.com` 계정에서 이메일 수신
