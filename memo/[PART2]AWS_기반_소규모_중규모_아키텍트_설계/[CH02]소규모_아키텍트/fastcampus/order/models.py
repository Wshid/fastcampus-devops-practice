from django.db import models

# Create your models here.
 
class Shop(models.Model):
    shop_name = models.CharField(max_length=20)
    shop_address = models.CharField(max_length=40)
    # id는 자동 생성됨

class Menu(models.Model):
    # id에 의해 사라지면, 같이 사라지도록 구성(CASCADE)
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    food_name = models.CharField(max_length=20)

class Order(models.Model):
    shop = models.ForeignKey(Shop, on_delete=models.CASCADE)
    order_Date = models.DateTimeField('date ordered')
    address = models.CharField(max_length=40)
    
    # 배달 예상시간은 차후 설정되므로, 기본값 -1로 설정
    estimated_time = models.IntegerField(default=-1)
    deliver_finish = models.BooleanField(default=0)

class Orderfood(models.Model):
    order = models.ForeignKey(Order, on_delete=models.CASCADE)
    food_name = models.CharField(max_length=20)