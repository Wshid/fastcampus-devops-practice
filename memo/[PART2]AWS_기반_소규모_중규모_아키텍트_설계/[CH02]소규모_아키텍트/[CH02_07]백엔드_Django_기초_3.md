## [CH02_07] (백엔드) Django 기초 3

### 템플릿에서 하드코딩 된 URL 제거하기
- urls.py에 지정된 `detail`의 이름을 사용
```html
<li><a href="{% url 'detail' question.id %}"> {{ question.question_text }} </a> </li>
```

### url의 이름 공간 정의
```python
# polls/urls.py
app_name = 'polls'
urlpatterns = [
  path('', views.index, name='index'),
  ...
]
```
- html에서 사용시 `polls:detail`과 같이 사용
  ```html
  <li><a href="{% url 'polls:detail' question.id %}"> {{ question.question_text }} </a> </li>
  ```

### Form 처리
- 사용자 입력을 받아 `Vote`관련 처리로 반환
- Reference: https://docs.djangoproject.com/en/4.1/intro/tutorial04/
```html
<!-- polls/templates/polls/detail.html -->
<form action="{% url 'polls:vote' question.id %}" method="post">
{% csrf_token %}
<fieldset>
    <legend><h1>{{ question.question_text }}</h1></legend>
    {% if error_message %}<p><strong>{{ error_message }}</strong></p>{% endif %}
    {% for choice in question.choice_set.all %}
        <input type="radio" name="choice" id="choice{{ forloop.counter }}" value="{{ choice.id }}">
        <label for="choice{{ forloop.counter }}">{{ choice.choice_text }}</label><br>
    {% endfor %}
</fieldset>
<input type="submit" value="Vote">
</form>
```

#### urls.py 추가
```python
# polls/urls.py
path('<int:question_id>/vote/', views.vote, name='vote'),
```

#### views.py 수정
- `vote()` 함수 추가
```python
polls/views.py¶
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import get_object_or_404, render
from django.urls import reverse

from .models import Choice, Question
# ...
def vote(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        # Redisplay the question voting form.
        return render(request, 'polls/detail.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:
        selected_choice.votes += 1
        selected_choice.save()
        # Always return an HttpResponseRedirect after successfully dealing
        # with POST data. This prevents data from being posted twice if a
        # user hits the Back button.
        return HttpResponseRedirect(reverse('polls:results', args=(question.id,)))
```
