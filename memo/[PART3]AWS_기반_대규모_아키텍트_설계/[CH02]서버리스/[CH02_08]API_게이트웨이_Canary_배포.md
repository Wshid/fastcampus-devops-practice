## [CH02_08] (AWS 게이트웨이) Canary 배포

### WAY1: Lambda 만을 활용하는 방법
  - Lambda 내에서 가중치를 구성
- Lambda 함수 수정
  - 새로운 버전의 print `Hello from new`으로 수정
- 이후 별칭 생성
  - 동일한 별칭, 가중치 `10%`
  - 저장
- 메서드 새로 생성
  - `GET /shops`, canaryFunction:prod
  - 저장
- 새 스테이지 생성
- 스테이지 변수
  - version:prod

### WAY2: API Gateway를 활용하는 방법
- Lambda 코드내 별칭 새로 생성
  - new 버전
  - 현재 prod까지 2개 존재
- 리소스 생성
  - `GET /shops`
  - lambda 함수: `canaryfunction:${stageVariables.version}`
  - 저장
  - 별칭이 늘어남에 따라, Lambda 함수에 대한 권한 추가 
    ```bash
    aws lambda add-permission --function-name "arn:aws...function:canaryFunction:stable ..."
    aws lambda add-permission --function-name "arn:aws...function:canaryFunction:prod ..."
    ```
- API 배포
  - second 스테이지 생성
  - 스테이지 변수
    - version:stable
  - canary
    - canary 요청 백분율 10%
  - canary 단계 변수
    - stable -> 재정의 값(new)

### 결론
- 강사의 경우 `WAY1`을 더 선호
  - 로컬 설정 문제 및 별칭 관리 문제 때문