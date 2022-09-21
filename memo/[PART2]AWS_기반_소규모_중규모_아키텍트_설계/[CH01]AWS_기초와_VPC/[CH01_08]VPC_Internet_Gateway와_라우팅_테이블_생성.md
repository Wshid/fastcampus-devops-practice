## [CH01_08] (VPC) Internet Gateway와 라우팅 테이블 생성

### IGW 생성
- ![image](https://user-images.githubusercontent.com/10006290/191524884-3ccec7b0-8396-41aa-b128-6e4f9b247a72.png)
- 기본적으로 생성하면 `Detached` 상태
- VPC 연결 필요
  - ![image](https://user-images.githubusercontent.com/10006290/191525056-9c39ba61-7680-4b7f-bc2f-3ad82d100492.png)
- VPC 연결시 attach

### Routing Table 생성
- 기본적으로 생성되는 Routing table도 있지만
  - public에 해당하는 각각의 Routing Table 생성
    - ![image](https://user-images.githubusercontent.com/10006290/191525648-908492b8-aa91-4e18-b01d-aa27448b9d90.png)
- 이후 VPC 구성시 생성된 테이블을 private 용도로 변경

### Subnet 연결 편집
- public에 맞게 각각 RTB에 Subnet을 연결
  - ![image](https://user-images.githubusercontent.com/10006290/191526230-6feff682-8e8a-450f-95f4-ef13ec93be94.png)
- private의 경우에는 기본 라우팅 테이블을 참조하기 때문에, 굳이 연결할 필요 x

### RTB 편집
- public의 경우 외부 통신을 위해 IGW 연결 필요
- CIDR 순서별로 우선순위를 가짐
  - ![image](https://user-images.githubusercontent.com/10006290/191526902-ceea533b-99f9-4520-827b-515a64bfcaa6.png)
- private은 외부 연결이 필요 없기때문에 따로 설정 필요 X
