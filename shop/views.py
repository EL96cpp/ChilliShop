from django.shortcuts import render, redirect
from django.db.models import F
from django.http import HttpResponse, HttpResponseNotFound, Http404 
from .models import *
from carts.utils import get_user_carts


def index(request):
    
    only_sales = request.GET.get('only_sales', None)
    order_by = request.GET.get('order_by', None)
    lower_price_limit = request.GET.get('lower_price_limit', 0)
    upper_price_limit = request.GET.get('upper_price_limit', None)

    products = Product.objects.all()

    if only_sales:
        products = products.filter(discount__gt=0)

    if lower_price_limit:
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).filter(price__gt=lower_price_limit)

    if upper_price_limit:
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).filter(price__lt=upper_price_limit)
    
    if order_by == "price":
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).order_by("price")
    elif order_by == "-price":
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).order_by("-price")

    user_cart = get_user_carts(request)

    return render(request, 'shop/index.html', {"products": products, "carts": user_cart})
