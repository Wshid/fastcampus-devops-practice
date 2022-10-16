## [CH02_07] (AWS 게이트웨이) Lambda와 REST API Gateway 연결

### 실습
- API Gateway - RSET API 생성
- API 이름 지정(canaryapi)

#### Lambda 설정
- Lambda 접속
  - 새로 작성(canaryfunction)
    - 세부 옵션으로 aws 어느 자원까지 접근할껀지 권한 명시 가능
  - 작업 - 새버전 발생
  - `:1`와 같은 version postfix 확인
  - 별칭 생성
  - 이름 및 버전 지정

#### REST API 설정
- 작업 - 리소스 생성
  - shops(`/shops`)
- 메서드 생성
  - shops의 GET 방식 설정
  - Lambda 함수 설정
    - region을 타기 때문에 확인 필요
  - Lambda 함수 설정
    - `canaryfunction:prod`
    - 함수 이름 및 별칭 지정
  - 권한 부여 창 발생시 확인

#### 배포
- 작업 - API 배포
- 배포 스테이지(새로운 배포 스테이지)
- 생성 작업 진행
- 스테이지 변수 설정
  - name:prod
