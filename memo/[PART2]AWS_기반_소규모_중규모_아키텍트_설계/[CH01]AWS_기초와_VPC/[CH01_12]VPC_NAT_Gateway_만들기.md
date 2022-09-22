## [CH01_12] (VPC) NAT Gateway 만들기
- private에서 외부로 접속하기 위한 방법
- NAT Gateway 만들기
- NAT Gateway로 Private EC2에 mysql 설치

### NAT Gateway 설치
- public subnet에 위치하도록 설정 필요
- ![image](https://user-images.githubusercontent.com/10006290/191779356-bbe9eae1-9935-4c8a-aed4-cd6608d5a565.png)

### Routing table 수정
- private에 해당하는 Routing table에서
- 0.0.0.0/0을 nat를 참조하도록 변경
- ![image](https://user-images.githubusercontent.com/10006290/191779766-76e4506b-13a7-4246-9c0c-b35b19da8299.png)
