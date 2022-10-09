## [CH01_06] (개발) 도메인 서비스 구현 - Django, Models

### models.py
```python
from django.db import models

class Shop(models.Model):
    shop_name = models.CharField(max_length=20)
    shop_address = models.CharField(max_length=40)

class Order(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    order_date = models.DateTimeField('date ordered', auto_now_add=True)
    address = models.CharField(max_length=40)
    deliver_finish = models.BooleanField(default=0)
```

### 모델 생성 이후 작업
```bash
docker-compose up
docker-compose exec backend sh

python manage.py makemigrations
python manage.py migrate
```

### user_order/serializers.py
```python
from rest_framework import serializers
from user_order.models import Shop, Order

class ShopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        fields = '__all__'

class OrderSerializer(serializers.ModelSerializer):
    class Meta:
        model = Order
        fields = '__all__'    
```
