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