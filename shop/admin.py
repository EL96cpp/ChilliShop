from django.contrib import admin
from shop.models import Product


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ["pepper_type", "pepper_color", "number_of_seeds", "price_no_discount", "discount"]
    list_editable = ["price_no_discount", "discount"]
    search_fields = ["pepper_type", "pepper_color", "number_of_seeds"]
    list_filter = ["pepper_type", "discount", "number_of_seeds"]
