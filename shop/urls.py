from django.urls import path, re_path
from django.conf.urls import include
from .views import *

urlpatterns = [
    path('', index, name='home'),
    path('users/', include('users.urls'))
]