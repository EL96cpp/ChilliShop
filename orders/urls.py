from django.urls import path, re_path
from .views import *

app_name = 'orders'

urlpatterns = [
    path('confirm_order', confirm_order, name='confirm_order'),
    path('delivery/<int:delivery_id>', delivery, name='delivery'),
    path('received_order/<int:order_id>', received_order, name='received_order')
]