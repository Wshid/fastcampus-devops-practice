## [CH02_01] jenkins 개요

### Jenkins 개요
- 빌드, 배포, 테스트를 자동화
- 오픈소스인 자동화 서버
- 다양한 플러그인 제공
  - Pipeline, Authentication/Authorization, Git, Docker
- 다양한 확장

#### 실습
- docker-compose를 통한 구성

### Jenkins pipeline
- Pipeline script 정의
```conf
pipeline {
  agent any

  stages {
    stage("Build") {
      steps {
        echo "demo"
      }
    }
  }
}
```
