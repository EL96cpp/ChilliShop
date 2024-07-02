from django.urls import path, re_path
from .views import *

app_name = 'orders'

urlpatterns = [
    path('create-order/', CreateOrderView.as_view(), name='confirm_order'),
]