from django.forms import BaseModelForm
from django.shortcuts import render, redirect
from django.contrib import auth, messages
from django.contrib.auth.views import LoginView
from django.views.generic import CreateView
from django.http import HttpResponse, HttpResponseRedirect
from django.contrib.auth.forms import AuthenticationForm
from django.urls import reverse, reverse_lazy
from django.template.loader import render_to_string
from django.http import JsonResponse

from users.forms import *
from users.models import *
from carts.models import Cart
from carts.utils import get_user_carts


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

    def get_success_url(self):
        redirect_page = self.request.POST.get('next', None)
        if redirect_page and redirect_page != reverse('user:logout'):
            return redirect_page
        return reverse_lazy('home')

    def form_valid(self, form):
        session_key = self.request.session.session_key
        user = form.get_user()
        if user:
            auth.login(self.request, user)
            if session_key:
                forgot_carts = Cart.objects.filter(user=user)
                if forgot_carts.exists():
                    forgot_carts.delete()
                
                Cart.objects.filter(session_key=session_key).update(user=user)

                messages.success(self.request, f"{user.username}, Вы вошли в аккаунт!")

                return HttpResponseRedirect(self.get_success_url())

    def get_context_data(self, **kwargs):
        return super().get_context_data(**kwargs)



def profile(request):
    user_carts = get_user_carts(request)
    return render(request, 'users/profile.html', {"carts": user_carts})


def logout_user(request):
    auth.logout(request)
    print("Logout call!!!")
    return redirect('home')


def order_confirmation(request):

    user_carts = get_user_carts(request)
    cart_items_html = render_to_string(
        "users/includes/order_confirmation.html", {"carts": user_carts}, request=request
    )
    response_data = {
        "message": "Товар добавлен в корзину",
        "cart_items_html": cart_items_html,
    }

    return JsonResponse(response_data)


def deliveries(request):
    user_carts = get_user_carts(request)
    cart_items_html = render_to_string(
        "users/includes/deliveries.html", {"carts": user_carts}, request=request
    )
    response_data = {
        "message": "Товар добавлен в корзину",
        "cart_items_html": cart_items_html,
    }

    return JsonResponse(response_data)


def received_orders(request):
    user_carts = get_user_carts(request)
    cart_items_html = render_to_string(
        "users/includes/received_orders.html", {"carts": user_carts}, request=request
    )
    response_data = {
        "message": "Товар добавлен в корзину",
        "cart_items_html": cart_items_html,
    }

    return JsonResponse(response_data)