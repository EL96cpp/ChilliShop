from django.shortcuts import render
from django.template.loader import render_to_string
from django.db.models import F
from django.http import JsonResponse
from django.core.paginator import Paginator
from .models import Product
from carts.utils import get_user_carts


def index(request):
    
    only_sales = request.GET.get('sales_only', None)
    order_by = request.GET.get('order_by', None)
    lower_price_limit = request.GET.get('lower_price_limit', 0)
    upper_price_limit = request.GET.get('upper_price_limit', None)

    print(only_sales, order_by, lower_price_limit, upper_price_limit)

    products = Product.objects.all()

    print("products no filters", products.count())

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

    print("products after filters", products.count())

    user_cart = get_user_carts(request)

    paginator = Paginator(products, 6)

    page_number = request.GET.get('page')
    print("page number", page_number)

    current_page = paginator.get_page(page_number)

    page_obj = paginator.get_page(page_number)

    return render(request, 'shop/index.html', {"products": current_page, "carts": user_cart, "page_obj": page_obj})



def filter_products(request):

    only_sales = request.GET.get('sales_only', None)
    order_by = request.GET.get('order_by', None)
    lower_price_limit = request.GET.get('lower_price_limit', 0)
    upper_price_limit = request.GET.get('upper_price_limit', None)


    products = Product.objects.all()

    if only_sales == 'true':
        products = products.filter(discount__gt=0)

    if lower_price_limit:
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).filter(price__gt=lower_price_limit)

    if upper_price_limit:
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).filter(price__lt=upper_price_limit)
    
    if order_by == "price":
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).order_by("price")
    elif order_by == "-price":
        products = products.annotate(price=F('price_no_discount')-F('price_no_discount')*F('discount')/100).order_by("-price")


    paginator = Paginator(products, 6)

    page_number = request.GET.get('page')
    print("page number", page_number)

    current_page = paginator.get_page(page_number)

    products_html = render_to_string("shop/includes/products.html", {"products": current_page}, request=request)

    response_data = {
        "message": "Количество изменено",
        "products_html": products_html,
    }

    return JsonResponse(response_data)
