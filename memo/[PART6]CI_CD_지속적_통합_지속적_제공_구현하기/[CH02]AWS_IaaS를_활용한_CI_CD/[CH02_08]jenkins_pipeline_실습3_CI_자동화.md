## [CH02_08] jenkins pipeline 실습3 (CI 자동화)
- Jenkins 파이프라인 명세 관련 

### 실습
- deploy/JenkinsFile
```conf
pipeline {
  agent { label 'master' }

  # 넘겨받을 인자들 정의
  parameters {
    booleanParam(name : 'BUILD_DOCKER_IMAGE', defaultValue : true, description : 'BUILD_DOCKER_IMAGE')
    booleanParam(name : 'RUN_TEST', defaultValue : true, description : 'RUN_TEST')
    booleanParam(name : 'PUSH_DOCKER_IMAGE', defaultValue : true, description : 'PUSH_DOCKER_IMAGE')
    booleanParam(name : 'PROMPT_FOR_DEPLOY', defaultValue : false, description : 'PROMPT_FOR_DEPLOY')
    booleanParam(name : 'DEPLOY_WORKLOAD', defaultValue : true, description : 'DEPLOY_WORKLOAD')

    // CI
    string(name : 'AWS_ACCOUNT_ID', defaultValue : '657976307134', description : 'AWS_ACCOUNT_ID')
    string(name : 'DOCKER_IMAGE_NAME', defaultValue : 'demo', description : 'DOCKER_IMAGE_NAME')
    string(name : 'DOCKER_TAG', defaultValue : '1.0.0', description : 'DOCKER_TAG')

    // CD
    string(name : 'TARGET_SVR_USER', defaultValue : 'ec2-user', description : 'TARGET_SVR_USER')
    string(name : 'TARGET_SVR_PATH', defaultValue : '/home/ec2-user/', description : 'TARGET_SVR_PATH')
    string(name : 'TARGET_SVR', defaultValue : '10.0.3.61', description : 'TARGET_SVR')
  }

  # 전체 stage에 영향을 미치는 환경 변수 설정
  ## stage내부에서 정의하면 그대로 국한
  environment {
    REGION = "ap-northeast-2"
    ECR_REPOSITORY = "${params.AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com"
    ECR_DOCKER_IMAGE = "${ECR_REPOSITORY}/${params.DOCKER_IMAGE_NAME}"
    ECR_DOCKER_TAG = "${params.DOCKER_TAG}"
  }

  stages {
    stage('============ Build Docker Image ============') {
        when { expression { return params.BUILD_DOCKER_IMAGE } }
        agent { label 'build' }
        steps {
          # env.WORKSPACE = jenkins default path
          # 해당 디렉터리로 이동하여 명령 수행 
            dir("${env.WORKSPACE}") {
                sh 'docker build -t ${ECR_DOCKER_IMAGE}:${ECR_DOCKER_TAG} .'
            }
        }
        # 빌드가 끝나면, 다음 명령을 항상 수행
        post {
            always {
                echo "Docker build success!"
            }
        }
    }
    
    # 테스트 코드 수행
    stage('============ Run test code ============') {
        when { expression { return params.RUN_TEST } }
        agent { label 'build' }
        steps {
            sh'''
                aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY}
                docker run --rm ${ECR_DOCKER_IMAGE}:${ECR_DOCKER_TAG} /root/.local/bin/pytest -v
            '''
        }
    }
    # docker image push 과정
    # AWS ECR을 사용하기 위해, iam role을 세팅했었음
    # 도커 이미지 생성시, cli 설정을 진행함
    # AWS - Create repository를 통해 임의 repository 생성
    stage('============ Push Docker Image ============') {
        when { expression { return params.PUSH_DOCKER_IMAGE } }
        agent { label 'build' }
        steps {
            echo "Push Docker Image to ECR"
            # ECR 로그인 이후 push
            sh'''
                aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY}
                docker push ${ECR_DOCKER_IMAGE}:${ECR_DOCKER_TAG}
            '''
        }
    }
    stage('Prompt for deploy') {
        when { expression { return params.PROMPT_FOR_DEPLOY } }
        agent { label 'deploy' }
        steps {
            script {
                env.APPROAL_NUM = input message: 'Please enter the approval number',
                                  parameters: [string(defaultValue: '',
                                               description: '',
                                               name: 'APPROVAL_NUM')]
            }

            echo "${env.APPROAL_NUM}"
        }
    }
    stage('============ Deploy workload ============') {
        when { expression { return params.DEPLOY_WORKLOAD } }
        agent { label 'deploy' }
        steps {
            sshagent (credentials: ['aws_ec2_user_ssh']) {
                sh """#!/bin/bash
                    scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
                        deploy/docker-compose.yml \
                        ${params.TARGET_SVR_USER}@${params.TARGET_SVR}:${params.TARGET_SVR_PATH};
                    ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no \
                        ${params.TARGET_SVR_USER}@${params.TARGET_SVR} \
                        'aws ecr get-login-password --region ${REGION} | docker login --username AWS --password-stdin ${ECR_REPOSITORY}; \
                         export IMAGE=${ECR_DOCKER_IMAGE}; \
                         export TAG=${ECR_DOCKER_TAG}; \
                         docker-compose -f docker-compose.yml down;
                         docker-compose -f docker-compose.yml up -d';
                """
            }
        }
    }
  }

  # post cleanup을 통해 이미지를 날려주는 작업을 하기도 하나
  # 현업에서는 각개 브랜치마다 dependency가 존재하여, 작업이 뜸한 시간에 작업하는 것을 추천
  # 파이프라인에 직접 넣는것을 추천하지 않음

  post {
    failure {
      slackSend(
        channel: "#jenkins_test",
        color: "danger",
        message: "[Failed] Job:${env.JOB_NAME}, Build num:#${env.BUILD_NUMBER} @channel (<${env.RUN_DISPLAY_URL}|open job detail>)"
      )
    }
  }
}
```