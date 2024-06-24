from django.shortcuts import render, redirect
from django.contrib import auth, messages
from django.contrib.auth.views import LoginView
from django.views.generic import CreateView
from django.http import HttpResponseRedirect
from django.contrib.auth.forms import AuthenticationForm
from django.urls import reverse, reverse_lazy

from users.forms import *
from users.models import *


class RegisterUser(CreateView):
    form_class = RegisterUserForm
    model = User
    template_name = 'users/register.html'
    success_url = reverse_lazy("home") 

    def get_context_data(self, **kwargs):
        return super().get_context_data(**kwargs)
    

class LoginUser(LoginView):
    form_class = LoginUserForm
    model = User
    template_name = 'users/login.html'

    def get_context_data(self, **kwargs):
        return super().get_context_data(**kwargs)


    def get_success_url(self):
        return reverse_lazy("users:profile")


def profile(request):
    return render(request, 'users/profile.html')


def logout_user(request):
    auth.logout(request)
    print("Logout call!!!")
    return redirect('home')


def order_confirmation(request):
    pass