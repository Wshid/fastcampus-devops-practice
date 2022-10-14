## [CH01_21] (인프라) AWS CodePipeline을 활용한 CI CD 개요
- AWS에서 jenkins 기능도 활용은 가능
- CI/CD

### CI/CD in AWS
- github commit
- codebuild
  - 서비스에서 코드 빌드
  - buildspec.yaml 업로드
  - 코드 테스트
- codeDeploy
  - AWS BeanStalk에 배포
    - 클릭 몇 번만으로 EC2 생성의 번거로움 해소하여 구동 가능
- codecommit
  - github을 쓰지 않을경우
  - github과 유사, 실습에선 사용하지 않음
- Amazon S3
  - 로그 수집

#### FLOW
- github -> CodeBuild -> CodeDeploy -> AWS BeanStalk
- Amazon S3
