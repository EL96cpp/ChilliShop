from django.conf.urls.static import static
from chillishop import settings

from django.contrib import admin
from django.urls import path, include
from shop.views import *
from users.views import *
from carts.views import *
from orders.views import *


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include("shop.urls")),
    path('users/', include('users.urls', namespace='user')),
    path('carts/', include('carts.urls', namespace='cart')),
    path('orders/', include('orders.urls', namespace='orders'))
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
