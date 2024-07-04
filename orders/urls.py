from django.urls import path, re_path
from .views import *

app_name = 'orders'

urlpatterns = [
    path('confirm_order', confirm_order, name='confirm_order'),
]