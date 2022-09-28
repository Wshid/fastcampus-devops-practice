## [CH02_19] (인프라) ALB에 인스턴스 연결하여 웹서비스 실행하기

### EC2 Target Group 생성
- EC2 서비스의 집합체
- MS 서비스에서 필요
- 집합안에 여러 서비스를 두는 형태
- Load Balancer로부터 온 트래픽을 몇 번 포트로 보낼것인가
- Health Check 정보 기입
- 설정 화면
  - ![image](https://user-images.githubusercontent.com/10006290/192789576-53cc5d41-6a33-420e-8f6c-34cdcdd7acf1.png)
- 이후 EC2를 추가한 후 `Create target group`

### Load Balancer 생성
- HTTP/HTTPS 기준 생성
- user:80 -> forward to {target_group}
- ![image](https://user-images.githubusercontent.com/10006290/192790032-4b51a70d-6124-4b75-8061-c87149e89a85.png)
- 생성이 완료되면, dns 주소를 복사하여 접근하면 됨

### 인스턴스 복제
- 이미지 생성 작업
  - 생성되어 있는 EC2를 기준으로 이미지 생성
  - 기반 EC2가 멈추는 경우도 있음. 관련하여 재구동 필요
- 해당 이미지를 기반으로 EC2 생성
