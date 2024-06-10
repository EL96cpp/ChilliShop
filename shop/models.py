from django.db import models

# Create your models here.
class Product(models.Model):
    pepper_type = models.CharField(max_length=255, null=False)
    pepper_color = models.CharField(max_length=20, null=False)
    number_of_seeds = models.CharField(max_length=2, null=False)
    image = models.ImageField(upload_to=f'shop/images/')
    price_no_discount = models.IntegerField(null=False)
    scoville_value = models.IntegerField(max_length=8, null=False)
    discount = models.IntegerField(null=False)

    def get_final_price(self):
        if self.discount:
            print(round(self.price_no_discount*self.discount/100))
            return round(self.price_no_discount - (self.price_no_discount*self.discount/100))
        return self.price_no_discount



