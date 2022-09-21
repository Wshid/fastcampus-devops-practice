## [CH01_07] (VPC) VPC와 Private, Public Subnet 만들기
- VPC 검색
- default VPC는 aws 계정을 생성하자마자 하나가 생성됨

### VPC 생성
- 생성 화면
  - ![image](https://user-images.githubusercontent.com/10006290/191521572-c8cfa64c-9ab6-4873-9668-716f5a45dcae.png)
- 생성 완료
  - ![image](https://user-images.githubusercontent.com/10006290/191521756-00120f0a-ae28-4d53-8ec1-0c1da1f9cc6d.png)
- VPC를 생성하면
  - subnet은 생성해주지 않음
  - 라우팅 테이블은 생성해줌
    - ![image](https://user-images.githubusercontent.com/10006290/191522191-de5f7a83-dac3-4159-ae79-ec7fb0071be1.png)
  - 네트워크 ACL 자동 생성
- 몇가지 내용들은 자동 생성, 몇가지는 수동 생성 필요

### Subnet 생성
- private-subnet, 10.0.1.0/24
- public-subnet, 10.0.0.0/24
- ![image](https://user-images.githubusercontent.com/10006290/191523917-152bb585-01f4-4056-b6aa-113b2f785d47.png)

