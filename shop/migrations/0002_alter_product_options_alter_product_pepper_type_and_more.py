# Generated by Django 5.0.6 on 2024-07-01 17:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('shop', '0001_initial'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='product',
            options={'verbose_name': 'Товар', 'verbose_name_plural': 'Товары'},
        ),
        migrations.AlterField(
            model_name='product',
            name='pepper_type',
            field=models.CharField(max_length=255, verbose_name='Тип кекича'),
        ),
        migrations.AlterField(
            model_name='product',
            name='scoville_value',
            field=models.IntegerField(verbose_name='Шкала Сковилла'),
        ),
    ]