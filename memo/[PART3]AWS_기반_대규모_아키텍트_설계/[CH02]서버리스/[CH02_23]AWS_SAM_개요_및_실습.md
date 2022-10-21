## [CH02_23] (부록) AWS SAM 개요 및 실습

### AWS SAM
- AWS SAM(AWS Serverless Application Model)
- 서버리스 어플리케이션 개발을 위해 필요 기능들을 코드로 관리
- AWS Lambda 콘솔에서 하는 일을 **코드화**, 체계화 시킬 수 있음
- `Cloudformation`보다 훨씬 간단하게 가능
- 실습 전
  - AWS CLI Install
  - AWS CLI Configure
  - SAM Install
  - Docker Install(선택)

### 실습
```bash
pip install aws-sam-cli
sam --version

sam init
# Choice: 1(AWS Quick Start Templates
# PAckage Type: 1(Zip)
# runtime: 2(python3.9)
# application template: 1(Hello World)


cd start
cd events

cat event.json

cd ../
cd hello_world

cd ../
vi template.yaml
# hello world라는 lambda function을 붙이는 과정 확인 가능
```
- AWS 계정 설정을 간단히 적용 가능