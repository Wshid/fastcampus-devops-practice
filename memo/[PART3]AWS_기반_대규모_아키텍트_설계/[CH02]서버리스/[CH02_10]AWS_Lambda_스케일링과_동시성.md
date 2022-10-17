## [CH02_10] (AWS Lambda) 스케일링과 동시성

### AWS Lambda Coldstart
- 처음 Trigger 후 Lambda Container(EC2)가 세팅됨
  - 평균 0.8초 소요
- 10분이 지나도 아무런 Trigger가 없으면 **해당 Continaer를 다른 사용자**에게 넘겨줌
- 10분 이내에 새로운 Trigger 발생시, 해당 Container에서 실행됨
- Coldstart에 시간(0.8s)가 소요되므로, Coldstart를 막기 위한 방법이 존재
  - 나만의 컨테이너를 지정받아 할당
    - 사실상 serverless가 아님
  - **자동으로 5분마다 무조건 한 번씩 Trigger**
- Coldstart의 시간 결정 요소 => **Lambda 함수 코드 사이즈**

### AWS Lambda Scaling
- 동시접속 1명일 때
- 동시접속 5명일 때
  - 4개 신규 생성
- 동시접속 100명일 때
  - 95개 신규 생성
- 동시접속 5명일 때
  - 95개 반납
- 동시접속 1명일 때
  - 4개 반납
- 한 번에 최대 1000개의 람다 컨테이너 운영 가능
  - 전체 컨테이너를 lambda로 구성하는 것은 위험(금방 도달)
- **Reserved concurrency**를 설정할 수 있음

### 버전관리와 Alias
- 업데이트된 코드와 별칭 지정
- 하나의 별칭안에 두개의 버전 관리가 가능
  - canary 배포때 활용

### 환경변수 설정
- AWS Lambda 내에서 변수 설정
- 민감한 정보 노출 안하게하기 위함

### Layers
- Lambda를 쓰면서 불편한 점
  - 함수별로 라이브러리 업로드가 필요
  - coldstart시 오래 걸림
  - lambda 함수별로 독립적
    - 동일한 환경이어도, 함수별로 새로 생성 필요
- 그를 해결하기 위한 문제
- Layers: 어떤 환경적인 부분을 하나로 통제하기 위한 툴
- 특정 함수들과 Layers 연동, Layers에 함수 연동
  - 환경을 세팅하여 함수들이 해당 환경을 활용할 수 있음

### Step Functions
- 이미지 업로드 micro service
  - AS-IS
    - Upload -> Image upload(EC2) -> S3에 저장 -> 검수, Inspection(EC2) -> 권한 오픈, Functionality(EC2)
  - TO-BE
    - Start -> Image Upload -> Inspection -> Insepct Decider -> Funtionality | Inspect Rejection -> End
- 단계가 존재
- 간단하게 개발자가 이와 같은 프로세스를 구현하기 위함

### AWS Lambda와 EFS
- Lambda가 너무 독립적이기 때문에 필요
- Lambda는 휘발적으로 동작 -> stateless
- stateful 하게 활용하기 위함
- Lambda1, Lambda2, Lambda3,... -> **Elastic File System**
- EC2 -> Write Data -> Elastic File System
- 모든 함수가 동일한 FS를 사용할 수 있음
- e.g. AI 모델등, 중간 결과등을 적용