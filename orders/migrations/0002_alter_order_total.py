# Generated by Django 5.0.6 on 2024-07-05 09:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('orders', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='total',
            field=models.IntegerField(default=0, verbose_name='Сумма заказа'),
        ),
    ]
