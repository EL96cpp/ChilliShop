from django.db import models


class Product(models.Model):
    pepper_type = models.CharField(max_length=255, null=False, verbose_name='Тип перца')
    pepper_color = models.CharField(max_length=20, null=False, verbose_name='Цвет перца')
    number_of_seeds = models.CharField(max_length=2, null=False, verbose_name='Число семян')
    image = models.ImageField(upload_to=f'shop/images/', verbose_name='Изображение')
    price_no_discount = models.IntegerField(null=False, verbose_name='Цена без скидки')
    scoville_value = models.IntegerField(null=False, verbose_name='Шкала Сковилла')
    discount = models.IntegerField(null=False, verbose_name='Скидка')

    def final_price(self):
        if self.discount:
            print(round(self.price_no_discount*self.discount/100))
            return round(self.price_no_discount - (self.price_no_discount*self.discount/100))
        
        return self.price_no_discount
    

    def __str__(self) -> str:
        return self.pepper_type + " " + self.pepper_color + ", " + self.number_of_seeds


