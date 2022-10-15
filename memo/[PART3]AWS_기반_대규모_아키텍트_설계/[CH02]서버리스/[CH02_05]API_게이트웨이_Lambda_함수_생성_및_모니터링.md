## [CH02_05] (AWS 게이트웨이) Lambda 함수 생성 및 모니터링
- AWS -> Lambda 검색

### 작업 방법
- 함수 생성 - 새로 작성
- 함수 이름 설정
- 함수 생성
- 코드 소스 확인(python)
- 함수명은 고정 필요, event, context argument를 가짐
- 코드 수정 이후 deploy 진행
  - 실행 가능한 상태로 설정됨
- 실행 방법
  - GUI, Trigger 등 여러가지 방법이 있음
  - Test를 눌러 수행 가능
- 트리거 구성
- 테스트 이벤트 구성(Configure Test Event)
  - 이벤트 이름 지정
  - 하단 코드(json) 생성
- 생성된 테스트 클릭
  - 지정했던 json(parameter)에 따라 수행됨

### 동적 테스트 방법
- 입력값을 넣는 방법?
  - event 입력 값을 활용하여 설정
- 테스트 입력값에 json 형태로 설정한 이후(e.g. key1)
  - `event['key1']`와 같이 호출

### 디버깅 방법
- 모니터링 탭
- cloudwatch에서 로그 보기
  - `cloudWatch - 로그 그룹`으로 연결 됨
- **로그 스트림** 클릭
  - 쌓인 로그 확인 가능
  - 각 lambda 함수의 실행 결과가 업데이트 되었을 때 기입됨
