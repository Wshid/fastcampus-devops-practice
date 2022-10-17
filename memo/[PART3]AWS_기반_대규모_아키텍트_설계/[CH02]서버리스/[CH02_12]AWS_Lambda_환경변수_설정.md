## [CH02_12] (AWS Lambda) 환경변수 설정

### 실습
- 환경변수 필요 이유
- Lambda의 내부 변수, 민감정보를 코드상에 표현하지 않기 위함
  - 하드 코딩 x
- Lambda 접속 - 구성 - 환경 변수
- 환경변수 편집
  - 키, 값 형태 설정
- Lambda 코드 내에서 다음과 같이 설정
  ```python
  import os
  # secret 환경 변수를 가져옴
  print(os.getenv("secret"))
  ```

### 보안 관련
- 현재 위와 같이 설정하면 결국 plain text로 노출됨
- 제대로 보안을 만족하려면 KMS를 사용하여 암호화 된 값을 Lambda 환경 변수로 설정
- lambda내에서 복호화하여 활용