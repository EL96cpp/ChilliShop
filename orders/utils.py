from .models import Order, OrderItem

def get_user_deliveries(request):
    orders = Order.objects.filter(user=request.user, status='В обработке')
    return orders


def get_user_received_orders(request):
    received_orders = Order.objects.filter(user=request.user, status='Получен')
    return received_orders