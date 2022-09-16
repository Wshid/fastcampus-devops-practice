## [CH03_06] AWS_계정_SSH_Key_등록_및_EC2_접속_방법
- 키페어 생성
  - ![image](https://user-images.githubusercontent.com/10006290/190640566-f3e68cd8-6dc1-44cc-8341-cc3e9cd9d45b.png)
- fastcampus-test 인스턴스 생성
  - Ubuntu 20.04, t2.micro
- ssh 접속
  ```bash
  ssh -i ./fastcampus.pem ubuntu@3.36.85.220
  ```
  - 정상 접속 확인