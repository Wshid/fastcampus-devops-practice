## [CH03_04] (인프라) Django Docker Build

### Django 실행
- 이후 기존 코드 git clone
- github의 write 권한을 얻기 위해서는
  - deploy key 등록 과정을 거치면 됨

#### requirements.txt 수정
- git clone 받은 프로젝트내 `requirements.txt`에 다음과 같은 내용 추가
```conf
...
sqlparse==0.3.1
uwsgi # 새로 추가된 부분
```

#### 다음 과정
```bash
curl -fsSL https://get.docker.com/ | sudo sh
sudo usermod -aG docker $USER # docker의 권한 설정
docekr -V(OFF AND ON)
vi Dockerfile
```

#### Dockerfile
```bash
FROM python:3.6.7 # default image로 python 3.6.7이 이미 설치된 이미지를 로드

ENV PYTHONUNBUFFERED 1

# Docker container 실행 후 구동될 내용
RUN apt-get -y update
RUN apt-get -y install vim

RUN mkdir /src/docker-django

# 지금 디렉터리를 /src/docker-django로 옮김
ADD . /srv/docker-django

# 현재 디렉터리 수정
WORKDIR /srv/docker-django

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# 8000번 포트를 가지고 있음
EXPOSE 8000

# 컨테이너를 모두 만든 이후, 다음 ㅁㅇ령 수행
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
```

#### docker build
```bash
docker build -t docker:/django .
docker image list
docker run -p 8000:8000 docker/django
```
