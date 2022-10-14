## [CH01_08] (개발) 도메인 서비스 구현 - Django, ViewSets
- views.py 이전 파일 참고

### order/urls.py
```python
urlpatterns = [
    ...
    path('api/', include('user_order.urls'))
]
```