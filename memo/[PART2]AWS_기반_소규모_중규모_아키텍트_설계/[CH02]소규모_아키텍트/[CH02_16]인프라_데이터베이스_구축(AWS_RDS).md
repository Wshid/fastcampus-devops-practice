## [CH02_16] (인프라) 데이터베이스 구축(AWS RDS)
- RDS
  - 데이터베이스 생성
- ![image](https://user-images.githubusercontent.com/10006290/192514850-b0459201-1d82-4b8d-8286-d44cf51e524d.png)
- ![image](https://user-images.githubusercontent.com/10006290/192514972-89e31223-9505-499c-87c5-c37090acdbce.png)

### mysqlclient 설치
```bash
pip install mysqlclient
```

#### settings.py
```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': '',
        'USER': 'admin',
        'PASSWORD': '...',
        'HOST': '', # database 설정 페이지의 endpoint명
        'PORT': '3306',
        'OPTIONS': {
            'init_command' : "SET sql_mode='STRICT_TRANS_TRABLES'"
        }
    }
}
```
- 엔드포인트 정보
  - ![image](https://user-images.githubusercontent.com/10006290/192516096-c9d127e9-1abb-41fe-8c2f-bd1bc1512a47.png)


### RDS 과금
- 시간당 과금
- free.tier의 경우 300시간 정도
- 다 테스트를 했으면 **삭제**를 해주어야 함