# Generated by Django 5.0.6 on 2024-07-08 05:03

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('carts', '0002_cart_session_key_alter_cart_user'),
    ]

    operations = [
        migrations.AddField(
            model_name='cart',
            name='received_timestamp',
            field=models.DateTimeField(blank=True, null=True, verbose_name='Дата получения'),
        ),
    ]