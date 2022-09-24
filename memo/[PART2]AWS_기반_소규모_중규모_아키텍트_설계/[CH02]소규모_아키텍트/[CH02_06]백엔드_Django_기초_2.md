## [CH02_06] (백엔드) Django 기초 2

### Django 관리자 소개
```bash
python manage.py createsuperuser
```
- username, pw 설정
- app 실행 이후 접근
  ```bash
  python manage.py runserver
  ```

### 관리 사이트에서 poll app을 제어 가능하도록 수정
```python
# polls/admin.py
from django.contrib import admin
from .models import Question

admin.site.register(Question)
admin.site.register(Choice)
```

### 뷰 추가하기
- `polls/views.py`에 뷰 추가
  ```python
  def detail(request, question_id):
    return HttpResponse("You're looking at question %s." % question_id)
  ```
- `polls/urls.py` 수정
  ```python
  urlpatterns = [
    path('<int:question_id>/', views.detail, name='detail'),
    ...
  ]
  ```

### 뷰가 실제로 무언가를 하도록 만들기
```python
# polls/views.py
from .models import Question

def index(request):
  latest_question_list = Question.objects.order_by('-pub_date')[:5]
  output = ', '.join([q.question_text for q in latest_question_list])
  return HttpResponse(output)
```

### templates
- 실제 html을 리턴하기 위함
- `polls/templates/polls`하위에 파일 생성
  ```html
  <!-- index.html -->
  {% if latest_question_list %}
    <ul>
    {% for question in latest_question_list %}
      <li><a href="/polls/{{ question.id }}/">{{ question.question_text}} </a></li>
    {% endfor %}
  {% else %}
    <p>No polls are available.</p>
  {% endif %}
  ```
- views.py 수정
  ```python
  def index(request):
    #latest_question_list = Question.objects.order_by('-pub_date')[:5]
    #template = loader.get_template('polls/index.html')
    #context = {
    #  'latest_question_list': latest_question_list,
    #}
    #return HttpResponse(template.render(context, request))

    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    context = {'latest_question_list': latest_question_list}
    return render(request, 'polls/index.html', context)
  ```

### 404 에러 일으키기
```python
# polls/views.py
## WAY 1
def detail(request, question_id):
  try:
    question = Question.objects.get(pk=question.id)
  except Question.DoesNotExist:
    raise Http404("Question does not exist")
  return render(request, 'polls/detail.html', context)

## WAY 2
from django.shortcuts import get_object_or_404, render

def detail(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'polls/detail/html', {'question': question})
```

### 템플릿 시스템 사용하기
```html
<!-- polls/templates/polls/detail.html -->
<h1> {{ question.question_text }} </h1>
<ul>
  {% for choice in question.choice_set.all %}
    <li> {{ choice.choice_text }} </li>
  {% endfor %}
</ul>
```
 