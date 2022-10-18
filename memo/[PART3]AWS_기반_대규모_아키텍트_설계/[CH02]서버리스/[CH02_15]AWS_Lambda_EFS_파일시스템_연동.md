## [CH02_15] (AWS Lambda) EFS 파일시스템 연동
- 람다 함수에 EFS에 접근할수 있는 권한을 주어야 함

### 실습
- 람다 함수 생성
- 구성 - Execution Role
- IAM 페이지 - 정책 연결
- 권한 추가
  - AWSLambdaVPCAccessExecutionRole
  - AmazonElasticFileSystemClientReadWriteAccess
- Lambda 페이지 - VPC 설정
  - VPC, Subnet 설정
  - 보안그룹: EFS에 지정된 보안 그룹 지정
- Lambda 페이지 - 파일 시스템
  - 파일 시스템 추가
  - EFS 파일 시스템 지정
  - 액세스 지점 설정
  - 로컬 탑재 경로: Lambda 로컬 경로 지정
    - `/mnt/msg`

#### Lambda 코드 수정
- 코드 참고: https://aws.amazon.com/ko/blogs/aws/new-a-shared-file-system-for-your-lambda-functions/
```python
import os
import fcntl

MSG_FILE_PATH = '/mnt/msg/content'


def get_messages():
    try:
        with open(MSG_FILE_PATH, 'r') as msg_file:
            fcntl.flock(msg_file, fcntl.LOCK_SH)
            messages = msg_file.read()
            fcntl.flock(msg_file, fcntl.LOCK_UN)
    except:
        messages = 'No message yet.'
    return messages


def add_message(new_message):
    with open(MSG_FILE_PATH, 'a') as msg_file:
        fcntl.flock(msg_file, fcntl.LOCK_EX)
        msg_file.write(new_message + "\n")
        fcntl.flock(msg_file, fcntl.LOCK_UN)


def delete_messages():
    try:
        os.remove(MSG_FILE_PATH)
    except:
        pass


def lambda_handler(event, context):
    method = event['requestContext']['http']['method']
    if method == 'GET':
        messages = get_messages()
    elif method == 'POST':
        new_message = event['body']
        add_message(new_message)
        messages = get_messages()
    elif method == 'DELETE':
        delete_messages()
        messages = 'Messages deleted.'
    else:
        messages = 'Method unsupported.'
    return messages
```
- 이후 Deploy

### 사용 예시
- AI 모델 학습은 다른 머신에서 구현하여 EFS에 저장
- 이후 Lambda와 같은 다른 컴포넌트에서 접근 가능