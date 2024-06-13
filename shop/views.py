from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseNotFound, Http404 
from .models import *


# Create your views here.
def index(request):
    pepper_list = Product.objects.values("pepper_type").distinct()
    products = Product.objects.all()
    return render(request, 'shop/index.html', {"pepper_list": pepper_list, "products": products})
