## [CH02_09] Models 제작

### 초기화 작업
```python
python3 -m venv venv
source venv/bin/activate

pip install django
django-admin startproject fastcampus

cd fastcampus
python manage.py startapp order
```

### Project 내부 설정
- `fastcampus/settings.py` INSTALLED_APPS 추가
  - `'order'` url 항목 추가
- `order/models.py` 코드 수정
- makemigrations
  ```python
  python manage.py makemigrations
  python manage.py migrate # db.sqlite3 파일 생성
  ```
  - ![image](https://user-images.githubusercontent.com/10006290/192125738-6851bfdd-0edb-40ff-8d44-4d25f1cd311a.png)

### views.py 구성
- djangorestframework 설치
  ```bash
  pip install djangorestframework
  ```
- `fastcampus/settings.py` INSTALLED_APPS 추가
  - `rest_framework` 추가
- view 파일 작성
- https://www.django-rest-framework.org/tutorial/1-serialization/#using-modelserializers
  - Serializer 추가 등 참고

### django 실행
```bash
python manager.py runserver
```
- 이후 파일 내용이 변경되었을때, 저장만 해도 자동 업데이트

### ionsomina
- postman과 같은 api test tool
- 인터넷에서 다운로드
- POST TEST
  - ![image](https://user-images.githubusercontent.com/10006290/192126526-c7ca0b3d-9811-4572-8077-1d0c0fde2255.png)
- GET TEST
  - ![image](https://user-images.githubusercontent.com/10006290/192126550-9ed7d307-adbf-4206-b30e-35759600c85f.png)
  - 데이터 유입 확인