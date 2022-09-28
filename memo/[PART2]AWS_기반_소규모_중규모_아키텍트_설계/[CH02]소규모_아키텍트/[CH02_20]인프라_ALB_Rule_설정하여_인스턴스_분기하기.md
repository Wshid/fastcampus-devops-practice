## [CH02_20] (인프라) ALB Rule 설정하여 인스턴스 분기하기

### ALB Rule
- MS Service
- 규칙을 정하여 특정 TG로만 보내도록 설정
  - e.g.
    - `/order`만을 담당하는 TG1
    - `/deliver`만을 담당하는 TG2
  - URL을 보고 판단하여, `/order` 요청이라면 TG1내로 포워드 및 load balancing

### Sticky Session
- LB가 구성된 상태에서,
  - 첫 요청이 Session은 특정 인스턴스에 물릴 것
  - 다음 요청에 LB가 되어 다른 인스턴스로 요청되게 되면
    - Session이 끊기는 상황이 발생
- 세션 값을 LB 자체에 저장하여, 일정 기간의 텀을 가지고 동일한 서버로 요청

### ALB 설정 방법
- Load Balancer 탭 접근
- 특정 Load Balancer 선택
- 하단 **Listener**탭 선택
  - 규칙 보기/편집
- 경로를 기준으로 Rule 추가
