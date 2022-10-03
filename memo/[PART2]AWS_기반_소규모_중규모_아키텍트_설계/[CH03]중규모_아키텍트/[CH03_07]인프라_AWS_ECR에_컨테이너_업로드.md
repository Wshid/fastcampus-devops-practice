## [CH03_07] (인프라) AWS ECR에 컨테이너 업로드
- ECR: Elastic Container Registry

### AWS Docker 배포 방식
- Container에 registry에 왜 등록해야하는가?
  - 하나의 이미지를 외부의 저장 및 관리
  - Docker Registry가 존재
    - 유사한 기능을 ECR에서 제공

#### Option 1
- My App -> Docker -> Registry(Docker Registry, ECR) -> ECS -> EC2
- 이후 Registry에서 ECS(Elastic Container Service)에 배포
- ECS내부에 ECR이 포함됨
- 상대적으로 고전적인 방식
- 관리포인트가 많음
  - ECR, ECS, EC2, ...

#### Option 2
- 상대적으로 최근 방식
- My App -> docker -> Registry(Docker Registry, EC$) -> AWS Fargate
- EC2 개별 관리를 하지 않음
- 마치 EC2가 돌아가듯 확인 가능

### AWS CLI
- AWS 서비스를 관리하는 통합 도구
- 도구 하나만 다운로드하여 구성하면
  - 여러 AWS 서비스를 명령줄에서 제어하고 스크립트를 통해 자동화 가능
- Amazon S3에서 효율적으로 파일을 보댄고 받을 수 있는 **간단한 새 파일 명령 세트**를 제공

### 실습
- EC2 생성 및 접속
```bash
curl -fsSL https://get.docker.com/ | sudo sh
sudo usermod -aG docker $USER
mkdir docker -server
vi Dockerfile
```

#### Dockerfile
```conf
FROM python:3.6.7
ENV PYTHONUNBUFFERED 1
RUN apt-get -y update
RUN apt-get -y install vim
RUN mkdir /src/docker-server
ADD . /src/docker-server
WORKDIR /srv/docker-server
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
```

#### Amazon Elastic Container Service
- 해당 서비스 접속(ECS)
- 리포지토리 생성
  - fargate_django 생성
  - 해당 url을 활용

#### IAM 설정
- AWS CLI를 설정하기 위한 계정 정보 세팅
- IAM 접속
- 사용자 추가
- 기존 정책에 연결
  - `AdministratorAccess` 추가
- access-key 확인 및 `aws configuare` 설정
  - secret-key 확인

#### COMMAND
```bash
docker build -t server_dev/django
# 생성한 image와 region에 맞게 진행
# docker tag hello-world:latest aws_account_id.dkr.ecr.us-east-1.amazonaws.com/hello-world
docker tag {image_id} {ecs url}

sudo apt-get install awscli
aws configure # IAM에 들어가서 정보 추가 필요
## access-key, secret-key 추가

aws acr get login --no-include-email --region us-east-2
# 특정 문자열이 노출됨, docker login ... 
## 해당 내용 복사
#docker push aws_account_id.dkr.ecr.us-east-1.amazonaws.com/hello-world
docker push {image_id} {ecs url}
```
- ACS는 비용이 비싸므로, 실습 후 바로 지워주는게 좋음
