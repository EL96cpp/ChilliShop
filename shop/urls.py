from django.urls import path, re_path
from django.conf.urls import include
from .views import *

urlpatterns = [
    path('', index, name='home'),
    path('filter_products/', filter_products, name='filter_products'),
    path('users/', include('users.urls'))
]