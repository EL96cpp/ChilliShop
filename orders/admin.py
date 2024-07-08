from django.contrib import admin
from .models import Order

@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ["user", "phone_number", "requires_delivery", "payment_on_get", 
                    "is_paid", "status", "total", "created_timestamp", "received_timestamp"]
    search_fields = ["id",]

