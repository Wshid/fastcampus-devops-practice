from django.shortcuts import render
from django.http import HttpResponse, JsonResponse
from order.models import Shop, Menu, Order, Orderfood
from django.views.decorators.csrf import csrf_exempt
from rest_framework.parsers import JSONParser
from order.serializers import ShopSerializer, MenuSerializer

# Create your views here.

# 해당 annotation을 추가해야 정상적으로 구동됨
@csrf_exempt
def shop(request):
    if request.method =='GET':
        # shop = Shop.objects.all()
        # # json 형태로 db의 값을 반환하기 위한 Serializer
        # serializer = ShopSerializer(shop, many=True)
        # return JsonResponse(serializer.data, safe=False)
 
        shop = Shop.objects.all()
        return render(request, 'order/shop_list.html', {'shop_list': shop})
    
    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = ShopSerializer(data=data)
        if serializer.is_valid():
            # 데이터가 쌓이는 과정
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

@csrf_exempt
def menu(request, shop):
    if request.method =='GET':
        menu = Menu.objects.filter(shop=shop)
        # json 형태로 db의 값을 반환하기 위한 Serializer
        # many=True, 여러개가 있어도 상관없다는 의미
        # serializer = MenuSerializer(menu, many=True)
        # return JsonResponse(serializer.data, safe=False)
        return render(request, 'order/menu_list.html', {'menu_list': menu, 'shop':shop})
    
    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = MenuSerializer(data=data)
        if serializer.is_valid():
            # 데이터가 쌓이는 과정
            serializer.save()
            return JsonResponse(serializer.data, status=201)
        return JsonResponse(serializer.errors, status=400)

from django.utils import timezone
@csrf_exempt
def order(request):
    if request.method == 'POST':
        address = request.POST['address']
        shop = request.POST['shop']
        food_list = request.POST.getlist('menu')
        order_date = timezone.now()

        shop_item = Shop.objects.get(pk=int(shop))

        # shop_time내에 Order database에 새로 row 생성
        shop_item.order_set.create(address=address, order_Date=order_date, shop=int(shop))

        order_item = Order.objects.get(pk = shop_item.order_set.latest('id').id)
        for food in food_list:
            order_item.orderfood_set.create(food_name = food)

        return HttpResponse(status=200)
    elif request.method == 'GET':
        order_list = Order.objects.all()
        return render(request, 'order/order_list.html', {'order_list': order_list})
