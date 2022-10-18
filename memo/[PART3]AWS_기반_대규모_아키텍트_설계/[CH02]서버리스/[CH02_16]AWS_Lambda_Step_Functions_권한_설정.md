## [CH02_16] (AWS Lambda) Step Functions 권한 설정
- API의 호출 결과에 따라 작동하는 함수
- Lambda함수의 지나친 독립성을 보완

### 실습
- lambda 함수 생성
  - lambdastep1, lambdastep2

#### lambdastep1
```python
import json
def lambda_handler(message, context):
response = {}
response['type'] = message['type']
return response
```
- 이후 deploy

#### lambdastep2
```python
import json
def lambda_handler(message, context):
response = {}
response['type'] = message['type']
return response
```
- 이후 deploy

#### 이후 작업
- 함수 ARN을 각각 복사
  - lambda 함수를 구분하는 값
- IAM 설정
  - step function에서 lambda를 접근하기 위한 역할 생성 필요
  - Step Functions 클릭
  - AWSLambdaRole 클릭
    - 이미 존재한다면 확인 불필요
  - 역할 이름 지정
    - StepFunctionLambdaRole
  - 역할 만들기
