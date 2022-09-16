## [CH03_07] AWS CLI 도구 설치 및 사용
- AWS CLI
  - AWS 서비스 관리를 위한 CLI 명령형 도구
- Python 기반

### macOS 설치 방법
```bash
brew install awscli
```

### AWS CLI 자격증명: AWS 액세스 키 발급
- AWS 계정 혹은 IAM 사용자의 액세스 키 발급 필요
- **Access Key ID**: 공개 가능
  - 자격증명 주체를 가리킴
  - 인증 요청한 사람이 누구인가?
- **Secret Access Key**: 공개 불가
  - 자격증명 주체 본인임을 인증
  - 인증 요청한 사람이 정말 A가 맞는가?

### 생성 절차
- ![image](https://user-images.githubusercontent.com/10006290/190643278-41b12a9f-147c-43e9-8d23-28b1a7d097a2.png)
- 이후 엑세스키 발급 이후 다운로드

### AWS CLI 자격증명 설정 우선순위
- 우선순위별 설정 목록
  - **CLI 명령어 옵션**
  - **환경 변수**
  - CLI 자격증명 파일 - `~/.aws/credentials`
  - CLI 설정 파일 - `~/.aws/config`
  - 컨테이너 자격증명 (ECS의 경우)
  - **인스턴스 프로파일 자격증명(EC2의 경우)**
- 상위 일수록 우선순위 높음
- **bold**는 현업에서 많이 사용하는 방법

#### aws/config
- `[default]` 하위 설정

#### 환경 변수
- 여러 환경 변수 제공
  - AWS_ACCESS_KEY_ID
  - AWS_SECRET_ACCESS_KEY
  - AWS_PROFILE

#### CLI 명령어 옵션
- `--profile`
  - access key를 지정하는 방법은 X, 사용자 프로파일 지정만 가능

#### EC2 인스턴스 프로파일
- IAM(Role)을 **EC2 머신**에 부여하기 위한 목적
- EC2내에서 AWS 서비스에 대한 권한 수행 가능

### 로컬 환경 설정
```bash
# 액세스키로 받은 정보를 토대로 KeyId, SecretKey 설정
aws configure 
# 정상 설정 여부 확인
aws sts get-caller-identify

# 키페어 설정 여부
aws ec2 describe-key-pairs #ap-northeast-2

# 결과 출력 형식 설정, default=json (text, table, yaml, ...)
## 특정 명령어 수행시 결과 확인(e.g. aws ec2 describe-key-pair)
```
- `aws configure`명령에서 모두 keypair, output, region, key 설정 가능

#### 사용자 프로파일 설정
- `~/.aws/config`상에 `[profile name]` 섹션 추가 및 여러 사용자 프로파일 등록 가능
- `AWS_PROFILE`혹은 `--profile`옵션을 사용하여 사용자 프로파일로 명령 수행 가능
  ```bash
  export AWS_PROFILE=fastcampus-dev aws sts get-caller-identity
  aws sts get-caller-identity --profile=fastcampus-prod
  ```

### AWS CLI 멀티 사용자 프로파일 예제
- 여러 AWS 계정 운영
- 동일 계정 내 여러 리전 운영
- 동일 계정 내 여러 IAM 역할 전환 수행
- AWS SSO 조직 내 SSO 역할 수행

### aws cli 사용법
```bash
aws --version

# help
aws help
aws <command> help
aws <command> <subcommand> help

# debug 옵션 활성화, awscli 동작 디버깅
aws sts get-caller-identity --debug

# 현재 자격증명 정보 확인
aws sts get-caller-identity
```
