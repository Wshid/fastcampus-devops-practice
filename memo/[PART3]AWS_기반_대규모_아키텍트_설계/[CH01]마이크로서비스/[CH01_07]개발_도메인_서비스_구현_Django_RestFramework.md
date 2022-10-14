## [CH01_07] (개발) 도메인 서비스 구현 - Django, RestFramework

### user_order/views.py
```python
from rest_framework import viewsets, status
from .models import Shop, Order
from .serializers import ShopSerializer, OrderSerializer

from rest_framework.response import Response

class ShopViewSet(viewsets.ViewSet):
    def list(self, request): #/api/shop
        shops = Shop.objects.all()
        serializer = ShopSerializer(shops, many=True)
        return Response(serializer.data)
    
    def create(self, request): #/api/shop
        serializer = ShopSerializer(data=request.data)
        serializer.isvalid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    def retrive(self, request, pk=None): #/api/shop/<str:idx>
        shop = Shop.objects.get(id=pk)
        serializer = ShopSerializer(shop)
        return Response(serializer.date)

    def update(self, request, pk=None): #/api/shop/<str:idx>
        shop = Shop.objects.get(id=pk)
        serializer = ShopSerializer(instance = shop, data=request.data)
        serializer.isvalid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
    
    def destroy(self, request, pk=None): #/api/shop/<str:idx>
        shop = Shop.objects.get(id=pk)
        shop.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)


class OrderViewSet(viewsets.ViewSet):
    def list(self, request): #/api/order
        orders = Order.objects.all()
        serializer = OrderSerializer(orders, many=True)
        return Response(serializer.data)
    
    def create(self, request): #/api/order
        serializer = OrderSerializer(data=request.data)
        serializer.isvalid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    
    def retrive(self, request, pk=None): #/api/order/<str:idx>
        order = Order.objects.get(id=pk)
        serializer = OrderSerializer(shop)
        return Response(serializer.date)

    def update(self, request, pk=None): #/api/order/<str:idx>
        order = Order.objects.get(id=pk)
        serializer = OrderSerializer(instance = shop, data=request.data)
        serializer.isvalid(raise_exception=True)
        serializer.save()
        return Response(serializer.data, status=status.HTTP_202_ACCEPTED)
    
    def destroy(self, request, pk=None): #/api/order/<str:idx>
        order = Order.objects.get(id=pk)
        Order.delete()
        return Response(status=status.HTTP_204_NO_CONTENT)
```

### user_order/urls.py
```python
from django.urls import path

from .views import ShopViewSet, OrderViewSet

urlpattenrs = [
    path('shop', ShopViewSet.as_view({
        'get':'list',
        'post':'create'
    })),
    path('shop/<str:pk>', ShopViewSet.as_view({
        'get':'retrieve',
        'put':'update',
        'delete':'destroy'
    })),
    path('order', OrderViewSet.as_view({
        'get':'list',
        'post':'create'
    })),
    path('order', OrderViewSet.as_view({
        'get':'retrieve',
        'put':'update',
        'delete':'destroy'
    }))
]
```