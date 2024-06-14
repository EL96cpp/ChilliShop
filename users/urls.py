from django.urls import path, re_path
from .views import *

app_name = 'users'

urlpatterns = [
    path('login/', LoginUser.as_view(), name='login'),
    path('register/', RegisterUser.as_view(), name='register'),
    path('profile/', profile, name='profile')
]