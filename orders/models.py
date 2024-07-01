from django.db import models


class Order(models.Model):
    is_paid = models.BooleanField(default=False, verbose_name="Оплачено")


    class Meta:
        verbose_name = "Заказ"
        verbose_name_plural = "Заказы"