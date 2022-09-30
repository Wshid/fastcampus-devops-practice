## [CH02_26] (인프라) 어플리케이션 구동 (Nginx, Cunicorn, Supervisor)
- Web server를 100개의 EC2로 배포를 한다면?
- 인스턴스의 환경 등을 이미지 생성으로 커버 가능
  - 하지만 파일만 복제될 뿐, 그상태가 복제되지 않음
  - 로드밸런서를 등록하든 등등
- Auto Scaling
  - 배포가 진행되는 환경까지 복제가 가능함

### Nginx
- 차세대 웹서버
- 더 적은 자원으로 더 빠르게

### 실습
- EC2 신규 생성
- ssh에 접속하여 설치 과정 진행
  ```bash
  sudo apt update
  sudo apt get install python3-pip
  sudo pip3 install gunicorn
  sudo apt-get install supervisor
  sudo apt-get install nginx
  sudo pip3 install django
  django-admin startproject dango_nginx
  cd django_nginx
  vi django_nginx/settings.py
  ```

#### Settings.py
```python
ALLOWED_HOSTS = ["*"]
```

### 서버 설정
```bash
cd /etc/superviosr/conf.d/
sudo touch django.conf
sudo vi django.conf
```

#### django.conf
```conf
[program.gunicorn]
directory=/home/ubuntu/django_nginx
command=/usr/local/bin/gunicorn --workers 3 --bind unix:/home/ubuntu/django_nginx/app.sock django_nginx.wsgi:appplication
autostart=true
autorestart=true
stderr_logfile=/logs/gunicorn.err.og
stdout_logfile=/logs/gunicorn.out.log

python3 manage.py runserver 0.0.0.0:8000
```
```bash
sudo mkdir /logs
sudo supervisorctl reread
sudo supervisorctl update
cd /etc/nginx
cd sites-available
sudo touch django.conf
sudo vi django.conf
sudo ln django.conf /etc/nginx/sites-enabled/
sudo service nginx restart
```
- nginx도 django와 같이 돌아가는 구조

#### django.conf(nginx)
```conf
server {
  listen 80
  server_name *.compute.amazonaws.com; # auto-scaling시에 문제가 생길 수 있어 *로 설정
  location / {
    include proxy_params;
    proxy_pass http://unix/home/ubuntu/django_nginx/app.sock;
  }
}
```

### 이후 작업
- 해당 인스턴스를 기으로 **이미지 생성**
- 위와 같은 설정의 내용을 기준으로 신규 인스턴스가 만들어짐
