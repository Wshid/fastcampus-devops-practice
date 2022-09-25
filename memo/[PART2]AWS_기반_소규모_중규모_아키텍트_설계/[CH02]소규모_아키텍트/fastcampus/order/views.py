from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from order.models import Shop, Menu, Order, Orderfood
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from order.serializers import ShopSerializer

# Create your views here.

# 해당 annotation을 추가해야 정상적으로 구동됨
@csrf_exempt
def shop(request):
    if request.method =='GET':
        shop = Shop.objects.all()
        # json 형태로 db의 값을 반환하기 위한 Serializer
        serializer = ShopSerializer(shop, many=True)
        return JsonResponse(serializer.data, safe=False)
    
    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = ShopSerializer(data=data)
        if serializer.is_valid():
            # 데이터가 쌓이는 과정
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)