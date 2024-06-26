from django.urls import path, re_path
from .views import *

app_name = 'cart'

urlpatterns = [
    path('cart_add/', cart_add, name='cart_add'),
    path('cart_change/', cart_change, name='cart_change'),
    path('cart_remove/', cart_remove, name='cart_remove')
]