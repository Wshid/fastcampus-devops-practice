## [CH01_04] (개발) 도메인 서비스 구현 - Django, Docker

### 작업 방식
```bash
django-admin startproject order
cd order
python manage.py runserver
```

#### requirements.txt
```conf
Django==3.1.3
djangorestframework==3.12.2
mysqlclient==2.0.1
django-mysql==3.9
django-cors-headers==3.5.0
pika==1.1.0 # rabbitMQ 연결시 필요
```

#### Dockerfile
```Dockerfile
FROM python:3.9
ENV PYTHONUNBUFFERED 1
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
COPY . /app

CMD python manage.py runserver 0.0.0.0:8000
```

#### docker-compose.yml
```yaml
version: '3.8'
services:
  backend:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - 8000:8000
    volumes:
      - .:/app
    depends_on:
      - db
  db:
    image: mysql:5.7.22
    restart: always
    environment:
      MYSQL_DATABASE: admin
      MYSQL_USER: root
      MYSQL_PASSWORD: root
      MYSQL_ROOT_PASSWORD: root
    volumes:
      - .dbdata:/var/lib/mysql # .dbdata라는 local 경로에 저장
    ports:
      - 33066:3306
```

### docker-compose
```bash
docker-compose up
```

### settings.py
```py
INSTALLED_APPS = [
  ...,
  'user_order',
  'rest_framework',
  'corsheader'
]

MIDDLEWARE = [
  ...,
  'corsheaders.middleware.CorsMiddleware'
]

CORS_ORIGIN_ALLOW_ALL = True

DATABASES = {
 'default': {
  'ENGINE': 'django.db.backends.mysql',
  'NAME': 'admin',
  'USER': 'root',
  'PASSWORD': 'root',
  'HOST': 'db',
  'PORT': '3306'
 } 
}
```

### order내 앱생성
```bash
docker-compose exec backend sh

# docker 내부에서 설정
python mange.py startapp user_order
```
