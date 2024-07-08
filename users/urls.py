from django.urls import path, re_path
from .views import *

app_name = 'users'

urlpatterns = [
    path('login/', LoginUser.as_view(), name='login'),
    path('logout/', logout_user, name='logout'),
    path('register/', RegisterUser.as_view(), name='register'),
    path('profile/', profile, name='profile'),
    path('profile/order_confirmation', order_confirmation, name='order_confirmation'),
    path('profile/deliveries', deliveries, name='deliveries'),
    path('profile/received_orders', received_orders, name='received_orders')
    
]