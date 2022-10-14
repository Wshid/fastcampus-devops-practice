## [CH01_23] (인프라) Elastic Beanstalk를 활용한 배포

### 구성 방법
- AWS내에서 Elastic Beanstalk 검색
- 플랫폼: python
- 샘플 어플리케이션
  - python의 경우 '코드 업로드'시 복잡함
- 환경 생성
- 이후 바로 배포가 됨
- 배포를 위한 ec2 우분투 생성
- 우분투 접속
  ```
  sudo apt-get update
  sudo apt-get install python3-pip
  
  export PATH=$PATH:/opt/aws/eb/linux/python2.7/
  export PATH=~/.local/bin:$PATH

  curl -O https://bootstrap.pypa.io/get-pip.py
  pip3 install awsebcli --upgrade --user

  eb --version
  sudo apt install awscli

  sudo apt install python3-virtualenv
  virtualenv ~/eb-virt
  source ~/eb-virt/bin/activate
  pip install django==2.2
  django-admin startproject ebdjango

  cd django
  pip freeze > requirements.txt
  mkdir .exextensions
  cd .ebextensions
  vi django.config
  ```

#### django.config
```yaml
option_settings:
  aws:elasticbeanstalk:container:python:
  WSGIPath: ebdjango.wsgi:application
```

#### 이후 구성
```bash
cd ../
cd ebdjango
vi settings.py
```

#### settings.py
```python
ALLOWED_HOSTS = ["*"]
```

#### 이후 구성
```bash
cd ..
deactivate

# eb 환경 생성
eb init -p python-3.6 django-tutorial
## aws access-id, secret-key 입력(IAM)
## 사용자 추가, AdministratorAccess로 생성, 키는 별도 없음

eb init
eb create django1-env

eb status

eb deploy
# 배포 url 확인
```
- 프로젝트 생성, eb instance내애 django.config를 만듦
- 이후 배포가 자동으로 일어남