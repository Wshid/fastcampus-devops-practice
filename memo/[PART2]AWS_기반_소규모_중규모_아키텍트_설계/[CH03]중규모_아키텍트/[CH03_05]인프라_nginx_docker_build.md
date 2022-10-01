## [CH03_05] (인프라) Nginx Docker Build

### docker with background
```bash
docker run -d -p 8000:88000 docker/django

# 실행되고 있는 컨테이너 확인
docker ps

docker stop {container_id}
```

### 작업 환경 정리
- root: fastcampus_test
  - git root
- fastcampus_test/fastcampus
  - django 코드가 담긴 곳

### nginx 구성
```bash
mkdir fastcampus_test/nginx
```
```bash
# uswsgi.ini
[uwsgi]
socket = /src/docker-django/django.sock
master = true

processes = 1
threads = 2

chdir = /src/docker-django
module = fastcampus_test.wsgi

logto = /var/log/uwsgi/uwsgi.log
log-reopen = true

vacuum = true
```

### docker-compose install
```bash
# ubuntu의 경우 docker/docker-compose 별도 다운로드 필요
sudo curl - L https://github.com...
sudo chmod +x /usr/local/bin/docker-compose
```

### nginx.conf
```conf
user root
worker_processes auto
pid /run/nginx.pid

events {
  worker_connections 1024
}

http {
  sendfile on;
  tcp_nopush on;
  tcp_nodelay on;
  keepalive_timetout 65;
  types_ahs_max_size 2048;

  include /etc/nginx/mime.types;
  default_type application/octet-stream;

  ssl_protocols TLSv1 TLSv1.1 TLS1.2; # Dropping SSLv3, ref; POODLE
  ssl_prefer_server_ciphers on;

  access_log /var/log/nginx/access.log;
  error_log /var/log/nginx/error.log;

  gzip on;
  gzip_disable "msie6"

  include /etc/nginx/sites-enabled/*;
}
```

### nginx-app.conf
```conf
upstream uwsgi {
  server unix:/srv/docker-django/apps.sock;
}

server {
  listen 80;
  server_name localhost;
  charset utf-8;
  client_max_body_size 128M;

  location / {
    uwsgi_pass  uwsgi;
    include     uwsgi_params;
  }

  locaion /media/ {
    alias /src/docker-django/.media/;
  }

  location /static {
    alias /srv/docker-django/.static/;
  }
}
```

### Dockerfile
```conf
FROM nginx:latest # 기존 nginx 이미지 다운로드

COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-app.conf /etc/nginx/sites-available/

RUN mkdir -p /etc/nginx/sites-enabled && ln -s /etc/nginx/sites-available/nginx-app.conf /etc/nginx/sites-enabled/

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### docker build
```bash
docker build -t server_dev/nginx
docker run -p 80:80 sever_dev/nginx
```

### 배포 순서
- 현재 django이후 nginx가 구동되어야 함
- 그 반대로 될 경우 문제가 발생
- 이를 `docker-compose`를 통해 해결 가능
