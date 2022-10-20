## [CH02_17] (AWS Lambda) Lambda Step Functions 구현

### 실습
- Step Functions 검색
  - 작동 방법 - 단순 DAG를 통해 작업 연결 가능
- 상태 머신 생성
- 코드로 워크플로 작성
  - StartAt: 상태값 중 하나 택일
  - States: 상태값
- 코드 작성
  ```json
  {
    "comment": "A Simple AWS ... ",
    "StartAt": "Start",
    "States": {
        "Start": {
            "Type": "Choice",
            # 분기 방식 지정
            "Choices": [
                {
                    # json 형식의 type 키 확인, first라면 lambdastep1 호출
                    "Variable": "$.type",
                    "StringEquals": "first",
                    "Next": "lambdastep1"
                },
                {
                    "Variable": "$.type",
                    "StringEquals": "second",
                    "Next": "lambdastep1"
                }
            ]
        },
        "lambdastep1": {
            "Type": "Task",
            "Resource": "arn:...:lambdastep1",
            "End": true
        },
        "lambdastep2": {
            "Type": "Task",
            "Resource": "arn...:lambdastep2",
            "End": true
        }
    }
  }
  ```
- 상태 머신 이름 지정
- 권한
  - 기존 역할 선택 - StepFunctionLambdaRole
- 상태 머신 생성
- 실행 시작
  ```json
  {
    "type": "first"
  }
  ```
  - 완료
- Graph inspector에서 내용 확인 가능
