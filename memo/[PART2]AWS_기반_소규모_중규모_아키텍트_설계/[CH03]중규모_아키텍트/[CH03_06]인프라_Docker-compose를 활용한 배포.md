## [CH03_06] (인프라) Docker-Compose를 활용한 배포

### 실습 환경
```bash
# directory hierarchy
docker-jango
  fastcampus_teest
  nginx

vi docker-compose.yml
```

#### docker-compose.yml
```yml
version: '3'
services:
  nginx:
    container_name: nginx
    build: ./nginx
    image: docker-django/nginx
    restart: always # 항상 재시작
    ports:
      - "80:80"
    volumes:
      - ./fastcampus_test:/src/docker-django
      - ./log:/var/log/nginx
    depends_on: # django라는 컨테이너에 의존함. 먼저 실행되고 있어야 nginx가 수행 됨
      - django
  
  django:
    container_name: django
    build: ./fastcampus_test
    image: docker-django/django
    restart: always
    command: uwsgi --ini uwsgi.ini
    volumes:
      - ./fastcampus_test:/srv/docker-django
      - ./log:/var/log/uwsgi
```

#### 명령 수행
```bash
docker image rm --force {container_id}
docker-compose up -d --build
docker-compose ps
```

### in AWS
- ECR에서 해당 기능들을 수행한다고 함
