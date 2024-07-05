from django.shortcuts import redirect, render
from django.contrib.auth.decorators import login_required
from django.contrib import messages
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import FormView
from django.forms import ValidationError
from django.urls import reverse_lazy
from django.db import transaction

from .forms import CreateOrderForm
from .models import *
from carts.models import Cart


@login_required
def confirm_order(request):
    print("Start confimation!")
    if request.method == 'POST':
        print("Post method!")
        form = CreateOrderForm(data=request.POST)
        if form.is_valid():
            print("Form is valid!")
            try:
                with transaction.atomic():
                    user = request.user
                    cart_items = Cart.objects.filter(user=user)

                    if cart_items.exists():
                        
                        order = Order.objects.create(
                            user=user,
                            phone_number=form.cleaned_data['phone_number'],
                            requires_delivery=form.cleaned_data['requires_delivery'],
                            delivery_address=form.cleaned_data['delivery_address'],
                            payment_on_get=form.cleaned_data['payment_on_get'],
                        )
                        
                        total_price = 0

                        for cart_item in cart_items:
                            product=cart_item.product
                            name=cart_item.product.__str__()
                            price=cart_item.product.final_price()
                            quantity=cart_item.quantity
                            total_price += cart_item.product.final_price()

                            OrderItem.objects.create(
                                order=order,
                                product=product,
                                name=name,
                                price=price,
                                quantity=quantity,
                            )
                        
                        order.total = total_price
                        order.save()

                        cart_items.delete()

                        messages.success(request, 'Заказ оформлен!')
                        print("Order confirmation success!")
                        return redirect('user:profile')
            except ValidationError as e:
                print(e, "Error!")
                messages.success(request, str(e))
        else:
            print("Form validation error!", form.data, form.errors)
    else:
        initial = {
            'first_name': request.user.first_name,
            'last_name': request.user.last_name,
        }

        form = CreateOrderForm(initial=initial)

    context = {
        'title': 'Home - Оформление заказа',
        'form': form,
        'order': True,
    }
    return render(request, 'orders/confirm_order.html', context=context)


# class CreateOrderView(LoginRequiredMixin, FormView):
#     template_name = 'users/includes/order_confirmation.html'
#     form_class = CreateOrderForm
#     success_url = reverse_lazy('users:profile')

#     def get_initial(self):
#         print("Get initial")
#         initial = super().get_initial()
#         initial['first_name'] = self.request.user.first_name
#         initial['last_name'] = self.request.user.last_name
#         return initial

#     def form_valid(self, form):
#         print("Start form validation")
#         try:
#             with transaction.atomic():
#                 user = self.request.user
#                 cart_items = Cart.objects.filter(user=user)

#                 if cart_items.exists():
#                     # Создать заказ
#                     order = Order.objects.create(
#                         user=user,
#                         phone_number=form.cleaned_data['phone_number'],
#                         requires_delivery=form.cleaned_data['requires_delivery'],
#                         delivery_address=form.cleaned_data['delivery_address'],
#                         payment_on_get=form.cleaned_data['payment_on_get'],
#                     )
#                     # Создать заказанные товары
#                     for cart_item in cart_items:
#                         product=cart_item.product
#                         name=cart_item.product.name
#                         price=cart_item.product.sell_price()
#                         quantity=cart_item.quantity


#                         OrderItem.objects.create(
#                             order=order,
#                             product=product,
#                             name=name,
#                             price=price,
#                             quantity=quantity,
#                         )

#                     # Очистить корзину пользователя после создания заказа
#                     cart_items.delete()

#                     print("Order success!")

#                     messages.success(self.request, 'Заказ оформлен!')
#                     return redirect('user:profile')
                
#         except ValidationError as e:
#             print(str(e), "Error")
#             messages.success(self.request, str(e))
#             return redirect('orders:confirm_order')
        
    
#     def form_invalid(self, form):
#         print("Error! Fill all required fields!")
#         messages.error(self.request, 'Заполните все обязательные поля!')
#         return redirect('orders:confirm_order')
    
#     def get_context_data(self, **kwargs):
#         context = super().get_context_data(**kwargs)
#         context['title'] = 'Оформление заказа'
#         context['order'] = True
#         return context