## [CH02_07] jenkins pipeline 실습3 (Github 연동)

### 실습
- Makefile에 `docker log` 명령어를 통해, jenkins 초기 비밀번호 확인 가능
  ```bash
  make log
  ```
- Customize Jenkins
  - Notification, Security, Grandle 제외
- Create First Admin User 기입
- Instance Configuration

#### Jenkins 페이지 확인
- 새로운 Item - Pipeline
- GitHub Project
  - https://github.com/dev-chulbuji/devops_sample_app_python
- Build Triggers
  - GitHub hook trigger for GITScm polling
- Pipeline
  - Pipeline script from SCM
  - Git
    - https://github.com/dev-chulbuji/devops_sample_app_python
  - Credentials
    - Jenkins가 github 권한이 있어야 설정 가능
    - Add
      - Global credentials
      - UserName: github id
      - password: Personal access token 정의
      - ID: github_jenkins_token(식별 가능한 특정 값)
  - Branch
    - master
  - Script Path
    - deploy/Jenkinsfile
- Build now

#### Github settings
- webhooks
  - Add webhook
    - payload URL: `${jenkins 주소}/github-webhook/`
    - Content type: `application/json`
  - Which event would ...
    - Just the push event
  - Active
  - Recent Deliveries
    - Headers, Payload 확인 가능
- 이후 github의 변경사항 적용 이후, push 하게 되면 자동 배포가 일어나게 됨
  - manage webhook에서 잡히는지 확인
- Github hook log에서 수행 결과 확인