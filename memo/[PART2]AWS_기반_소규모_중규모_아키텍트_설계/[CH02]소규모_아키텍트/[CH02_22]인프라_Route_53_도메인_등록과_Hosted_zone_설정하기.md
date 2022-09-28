## [CH02_22] (인프라) AWS Route 53 도메인 등록과 Hosted zone 설정하기

### Route 53을 활용한 http 설정
- 사용자 -> Route53 -> Elasic LoadBalancer -> EC2, EC2, ...
- Route53에 등록된 도메인을 Elastic LoadBalancer에 등록
- 등록을 하게 되면, EC2 ALB에 접속한것과 동일하게 됨

### 실습
- LoadBalancer:80 -> TargetServer:8000
- 단순히 Route 53을 통해 도메인을 구매하기만 해도
  - 해당 도메인의 NS, SOA등을 자동적으로 등록해줌
  - 타 도메인 등록 서비스(e.g. 가비아)는 등록 X
- 만약 Route 53이 아니라, 다른 도메인 등록 서비스를 활용했다면
  - 레코드를 생성하면 됨(가비아의 경우 `CNAME`)
- 외부 접속을 위해서는 **레코드 등록** 필요
  - **A 레코드** 생성
  - 별도 레코드명 수정 X
  - Load Balancer의 IP를 기입하거나 **도메인 이름** 기록
  - 혹은 **별칭** 사용
- `www.`로 시작하는 도메인으로 접속 가능하게 하고 싶다면, **레코드 등록** 필요
  - 레코드명: `www.fast-devops.com`
  - **A 레코드** 생성
  - 위와 동일하게 IP나 별칭 사용
