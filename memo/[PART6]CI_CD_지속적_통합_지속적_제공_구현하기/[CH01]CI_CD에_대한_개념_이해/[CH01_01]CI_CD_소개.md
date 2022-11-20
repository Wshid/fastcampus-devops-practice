## [CH01_01] CI/CD 소개
- CI/CD, CR(Continuous Reliability)

### AS-IS/TO-BE
- AS-IS. 배포 일정을 잡고
  - 그 일정에 맞추어 feature별 merge
  - merge conflict/integration issue
- TO-BE.
  - git 형태로 코드 관리
  - 이전 머지 및 형상 관리
  - 이후 릴리즈
  - 하루에 n번도 배포 가능

### CI/CD conecept
- CI(Continuous Integeration): 지속적 통합
- CD(Continuous Delivery or Continuous Deployment) - 지속적 전달/배포
- Jenkins의 CI/CD
  - 소프트웨어 배포 프로세스를 빠르게
    - 주기를 짧게 가져가고, 자동화
  - agile principle의 핵심 원칠