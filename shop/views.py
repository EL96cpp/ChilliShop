from django.shortcuts import render, redirect
from django.http import HttpResponse, HttpResponseNotFound, Http404 
from .models import *


# Create your views here.
def index(request):
    return render(request, 'shop/index.html')

def login(request):
    return render(request, 'shop/login.html')

def register(request):
    return render(request, 'shop/register.html')