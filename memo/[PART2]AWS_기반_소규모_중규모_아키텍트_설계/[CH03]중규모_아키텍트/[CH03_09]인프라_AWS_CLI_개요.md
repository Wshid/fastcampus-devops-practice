## [CH03_09] (인프라) AWS CLI 개요
- Fargate에 올리되, docker-compose처럼 여러 컨테이너를 올리는 작업

### 실습
- EC2 생성 및 접속
```bash
mkdir docker-server
cd docker-server
git clone {fast_campus git}
cd fastcampus_text
echo "uwsgi" >> requirements.txt
```

### docker 세팅 과정
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

```bash
docker build -t server_dev/django

sudo apt install awscli
aws configure
# access-key,secret-key 입력

aws ecr get-login --no-include-email --region us-east-2
# 결과 내용 복사
-
aws configure
aws ecr get-login --no-include-email --region us-east-2
aws ecr create-repository --repository-name hello-cli --region us-east-2
docker tag {image_name} {uri}
docker push {uri}
```
