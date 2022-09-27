## [CH02_17] (인프라) Django 개발 결과를 EC2에 배포하기
- EC2 생성(ubuntu)

### EC2 생성 이후 명령어
```bash
sudo apt-get update
sudo apt-get install python3
sudo apt-get install python3-pip
sudo apt-get install virtualenv
```

### 로컬 환경 개발 결과의 패키지 확인
```bash
# in local
pip freeze >> requirements.txt
```
- 이후 Github에 모두 코드를 push 이후 clone

### Git deploy 설정
```bash
# in aws, keypair 생성
ssh-keygen -t rsa

ssh-keygen -t rsa -C "email@gamil.com"
```
- pub key를 git config **deploy keys**에 추가

### requirements.txt install
```python
# in aws
sudo apt-get install libmysqlclient-dev
pip install -r requirements.txt
```

### db내의 인바운드 규칙 변경
- SG내에서 8000번 포트를 사용할 수 있도록 활성화 필요

### settings.py 설정
```bash
ALLOWED_HOSTS = [...]
```
- 해당 설정 내부에 접근 가능한 호스트 추가 필요

### django 실행
```bash
python3 manage.py runserver 0.0.0.0:8000
bg # fg의 app을 bg로 이전
disown -h # ssh가 끊어지더라도 수행 되도록 수정
```