## [CH02_13] (AWS Lambda) Layers

### 개념
- Lambda를 생성하면, 상단에 Layers가 노출됨(아이콘)
- lambda function이 특정 layer 위에서 동작한다는 의미
- 해당 layer에 패키지 설치 등과 같은 환경 구성 가능
  - 여러가지 lambda function에서 활용 가능

### 실습
- 계층 생성
- 파일 업로드 가능
  - 필요한 패키지를 zip 파일로 만들어서 업로드 가능
  - pip 패키지로 구성한 파일들을 만들어 업로드 가능
- zip 파일 만들기
  - anaconda 활용
  - 다음 명령 수행
    ```python
    # 현재 디렉터리에 결과 저장
    pip install requests -t 

    # 현재 디렉터리에 생성된 파일을 하나로 묶어 zip 파일 생성
    ```
- 환경 설정(python 버전 지정)
- lambda - layers 편집
- 사용자 지정 계층 requests 선택, 버전 선택
