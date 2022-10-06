## [CH03_16] (인프라) AWS CodeCommit

### AWS CodeCommit
- Github와 유사한 코드 저장소 및 형상 관리 서비스
- AWS CodeCommit은 `git`기반의 리포지토리를 호스팅
- S3의 모든 코드를 **암호화**하여 저장(AWS KMS)
- IAM 인증을 통해 `push/pull`에 대한 권한 관리
- 5명 미만까지는 무료

### 실습
- IAM 사용자 추가
  - codecommit 사용자 추가
- 기존 정책 직접 연결
  - AWSCodeCommitFullAccess
- access-key, secret-key 확인
- 보안자격증명
  - 해당 사용자 접속
    - AWS CodeCommit에 대한 HTTPS Git 자격 증명
    - 자격 증명 생성 
- EC2 생성
- EC2 접속 및 awscli 설치(기존 실습 참고)
  ```bash
  sudo apt update
  sudo apt install awscli
  aws configure
  ```
- codeCommit 검색
- repository 생성(git history와 동일)
- EC2 접속
  ```bash
  git clone {gitCommit 주소}
  git config --lcoal username "song"
  git config --local user.email {email}
  git init
  git add 
  git commit -m "..."
  git push -u origin 
  ```
- 실상 사용 방식은 github과 동일
