# Generated by Django 5.0.6 on 2024-07-08 05:19

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('carts', '0003_cart_received_timestamp'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='cart',
            name='received_timestamp',
        ),
    ]
