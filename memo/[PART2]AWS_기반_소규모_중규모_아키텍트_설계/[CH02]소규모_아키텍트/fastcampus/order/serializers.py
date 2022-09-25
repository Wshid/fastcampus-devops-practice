from rest_framework import serializers
from order.models import Shop, Menu, Order, Orderfood

class ShopSerializer(serializers.ModelSerializer):
    class Meta:
        model = Shop
        fields = '__all__'