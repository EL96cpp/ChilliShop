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
    if request.method == 'POST':
        form = CreateOrderForm(data=request.POST)
        if form.is_valid():
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
                            total_price += cart_item.product_price()

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
                        return redirect('user:profile')
            except ValidationError as e:
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


@login_required
def delivery(request, delivery_id):
    delivery = Order.objects.filter(id=delivery_id)
    delivery_items = OrderItem.objects.filter(order=delivery_id)
    print(delivery_items.count(), "delivery items")
    print(delivery[0].pk, "delivery")
    return render(request, 'orders/delivery.html', {"delivery": delivery[0], "delivery_items": delivery_items})


@login_required
def received_order(request, order_id):
    print(order_id)
    return render(request, 'orders/received_order.html')