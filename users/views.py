from django.shortcuts import render, redirect
from django.contrib import auth, messages
from django.contrib.auth.views import LoginView
from django.views.generic import CreateView
from django.http import HttpResponseRedirect
from django.contrib.auth.forms import AuthenticationForm
from django.urls import reverse

from users.forms import *
from users.models import *


class RegisterUser(CreateView):
    form_class = RegisterUserForm
    model = User
    template_name = 'users/register.html'
    success_url = 'home'

    def get_context_data(self, **kwargs):
        return super().get_context_data(**kwargs)
    

class LoginUser(LoginView):
    form_class = LoginUserForm
    model = User
    template_name = 'users/login.html'
    success_url = 'users/profile.html'

    def get_context_data(self, **kwargs):
        return super().get_context_data(**kwargs)


def profile(request):
    return render(request, 'users/profile.html')
