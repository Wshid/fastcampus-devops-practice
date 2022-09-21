## [CH01_09] (VPC) NACL 설정하기1
- NACL 설정하기
  - NACL - stateless
  - Security Group - stateful

### NACL vs Security Group
- 임시포트의 범위: 1024 ~ 65535
- Security Group, Inbound:80, Outbound: none
  - 80으로 들어오는 건 허용
  - 나가는건 허용 x
  - 단, 이미 연결된 세션에 대해서는 허용함
    - e.g. client:1025 -> ec2:80 // Inbound 허용
    - server:80 -> client:1025 // 허용하지 않아야 하나, client로부터 이미 성공, 연결 허용
- NACL
  - 무조건 rule에 따라 진행
  - Outbound가 허용되지 않으므로, 위 예시에 대해서 미허용
- **NACL이 SG보다 strict**

### NACL 설정
- VPC 구성시 자동 생성된 NACL은, `private_NACL`로 이름 변경
- `public_NACL` 생성 이후, subnet 연결
  - ![image](https://user-images.githubusercontent.com/10006290/191528947-68f88810-2067-4e2f-9e9d-e3fdd4a58b02.png)
  - ![image](https://user-images.githubusercontent.com/10006290/191529201-f7607c15-57c1-4e91-9ab0-73d0abfc9a16.png)

#### Inbound 규칙 설정
- **규칙 번호**에 따라 우선순위
  - ![image](https://user-images.githubusercontent.com/10006290/191529497-2474bdf0-1d4b-48eb-a559-9c953a48652b.png)
  - 규칙에 해당 된다면, 이후 검증을 진행하지 않음

#### Outbound 규칙 설정
- 임시포트에 대응하기 위해 `1024 ~ 65535`로 지정
- ![image](https://user-images.githubusercontent.com/10006290/191530110-2a3372bf-6445-49ed-822d-749fb69889a5.png)