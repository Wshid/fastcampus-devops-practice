## [CH02_02] jenkins pipeline 소개

### Jenkins Pipeline
- `Checkout, Build, Test, Staging, Production` 등의 일련의 과정
- Jenkins 2.x 부터 사용 가능
- Pipeline plugin을 설치해야 함
- CD
- Pipeline as code(DSL, jenkinsfile)

#### Scripted pipeline
- groovy script
- JAVA API reference
- Example
  ```conf
  node {
    stage('Build') {
      //
    }
    stage('Test') {
      //
    }
    stage('Deploy') {
      //
    }
  }
  ```

#### Declarative pipeline
- Jenkins DSL
- isolate complex logic into Jenkins plugin
- Example
  ```conf
  pipeline {
    agent any
    stages {
      stage('Build') {
        steps {
          //
        }
      }
      stage('Test') {
        steps {
          //
        }
      }
      stage('Deploy') {
        steps {
          //
        }
      }
    }
  }
  ```

### Syntax
- Section
  - agent
  - stages
  - steps
  - post
- Directive
  - parameters
  - environments
  - when
  - ...

#### Agent
- pipeline or stage가 실행될 노드 지정
  - none
  - any
  - label
  - node
  - docker
  - dockerfile
  - kubernetes
- 예시
  ```conf
  pipeline {
    agent { label 'service || batch' }
    agent { label 'service && batch' }
    agent { label 'service'}
    agent { label 'batch'}
  }
  ```

#### Stage
- Sections
  - Stages: 순차적인 작업의 명세인 stage의 묶음
  - Steps: Stage에서 실행되는 단계
- Directives
  - Stage
    - agent 설정(optional)
    - steps의 묶음

#### Post
- 위치에 따라 stages들의 작업이 끝난 후 추가적인 steps
- 혹은 stage에 steps들의 작업이 끝난 후 추가적인 step
- Condition
  - always
  - changed
  - fixed
  - regression
  - aborted
  - failure
  - success
  - unstable
  - unsuccessful
  - cleanup

#### Directive
- environment
  - key = value
  - pipeline 내부에서 사용할 환경 변수
  - `credentials()를 통해 jenkins credential에 접근 가능
- parameters
  - pipeline을 trigger할 때 입력 받아야할 변수 정의
  - Type
    - string
    - text
    - booleanParam
    - choice
    - password
- when
  - stage를 실행할 조건 설정

### Jenkins Overview
- developer -> github -> Jenkins -> dockerhub, EC2
- Jenkins -> Notification