## [CH02_05] (백엔드) Django 기초 1

### 프로젝트 만들기
```bash
django-admin startproject mysite
```

### 파일별 설정
- manage.py
  - main과 같은 역할
- settings.py
  - django의 다양한 세팅 존재
  - e.g. 데이터베이스, 언어 
- urls.py
  - 어디로 보낼껀지, 컨트롤러 역할

### 서버 실행
```
python manage.py runserver
```

### 설문조사 앱 만들기
- django내에 여러 앱을 구동 시킬 수 있음
```bash
# polls directory가 생성됨
python manage.py startapp polls
```
- `views.py`, `models/py`
- 사용자가 접근하였을 때,
  - mysite.urls 참조
  - 내부 내용에 polls로 redirect되었다면
  - polls/urls를 참조

### DB 관련 작업
```bash
# DB Migration
python manage.py migrate
```
- 운영하기 위한 DB table 생성
- db.sqlite3에 작성된 sql에 맞는 쿼리 수행
- 모델 만드는 작업
  ```python
  # Question 모델
  class Question(modesl.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')
  
  class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
  ```

### 앱을 정식 포함시키기
- mysite/settings.py 내용 수정
```python
INSTALLED_APPS = [
  'polls.apps.PollsConfig', ...
]
```
- 다음 명령 수행
  ```bash
  python manage.py makemigrations polls
  ```
  - 이 명령 수행 이후, `polls/migrations/00001_initial.py` 파일이 자동으로 생성됨
- 마이그레이션 수행
  ```bash
  python manage.py migrate
  ```

### 쉘을 가지고 놀기
```bash
python manage.py shell
```