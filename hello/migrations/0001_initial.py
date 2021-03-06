# -*- coding: utf-8 -*-
# Generated by Django 1.11.4 on 2017-10-30 11:03
from __future__ import unicode_literals

import datetime
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Customer_History',
            fields=[
                ('id', models.BigIntegerField(primary_key=True, serialize=False)),
                ('category', models.CharField(max_length=2)),
                ('price', models.DecimalField(decimal_places=2, max_digits=8)),
                ('full_name', models.CharField(max_length=500)),
                ('description', models.TextField(max_length=5000)),
            ],
            options={
                'db_table': 'hello_customer_history_v',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Low_Stock',
            fields=[
                ('id', models.BigIntegerField(primary_key=True, serialize=False)),
                ('Stock', models.IntegerField()),
                ('SupplierStock', models.IntegerField()),
                ('SupplierName', models.CharField(max_length=500)),
                ('phone_no', models.CharField(max_length=12)),
                ('address', models.CharField(max_length=500)),
                ('email', models.EmailField(max_length=254)),
            ],
            options={
                'db_table': 'hello_low_stock',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Sales_by_Amount',
            fields=[
                ('id', models.BigIntegerField(primary_key=True, serialize=False)),
                ('date', models.DateField()),
                ('time', models.TimeField()),
                ('order_status', models.CharField(max_length=2)),
                ('total_amount', models.IntegerField()),
            ],
            options={
                'db_table': 'hello_sales_by_amount',
                'managed': False,
            },
        ),
        migrations.CreateModel(
            name='Customer',
            fields=[
                ('customer_id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=500)),
                ('email', models.EmailField(max_length=254)),
                ('hashed_password', models.CharField(max_length=32)),
                ('address', models.TextField(max_length=1000)),
            ],
        ),
        migrations.CreateModel(
            name='Order_Items',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField(default=1)),
            ],
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('product_id', models.AutoField(primary_key=True, serialize=False)),
                ('category', models.CharField(choices=[('CP', 'Computers'), ('AP', 'Appliances'), ('PH', 'Phones'), ('CM', 'Cameras')], max_length=2)),
                ('price', models.DecimalField(decimal_places=2, max_digits=8)),
                ('full_name', models.CharField(max_length=500)),
                ('description', models.TextField(max_length=5000)),
            ],
        ),
        migrations.CreateModel(
            name='Sale',
            fields=[
                ('sale_id', models.AutoField(primary_key=True, serialize=False)),
                ('date', models.DateField(default=datetime.date.today)),
                ('time', models.TimeField(default=datetime.time(23, 59, 59, 999999))),
                ('order_status', models.CharField(choices=[('PS', 'Processing'), ('TS', 'In transit'), ('DV', 'Delivered'), ('RJ', 'Rejected')], default='PS', max_length=2)),
                ('customer', models.ForeignKey(on_delete=django.db.models.deletion.PROTECT, to='hello.Customer')),
            ],
        ),
        migrations.CreateModel(
            name='Stock',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.SmallIntegerField(default=0)),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hello.Product')),
            ],
        ),
        migrations.CreateModel(
            name='Supplier',
            fields=[
                ('supplier_id', models.AutoField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=500)),
            ],
        ),
        migrations.CreateModel(
            name='Supplier_Contact',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('phone_no', models.CharField(max_length=12)),
                ('address', models.CharField(max_length=500)),
                ('email', models.EmailField(max_length=254)),
                ('supplier', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hello.Supplier')),
            ],
        ),
        migrations.CreateModel(
            name='Supplier_Stock',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.SmallIntegerField(default=0)),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hello.Product')),
                ('supplier', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hello.Supplier')),
            ],
        ),
        migrations.CreateModel(
            name='Warehouse',
            fields=[
                ('warehouse_id', models.AutoField(primary_key=True, serialize=False)),
                ('address', models.TextField(max_length=120)),
            ],
        ),
        migrations.AddField(
            model_name='stock',
            name='warehouse',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hello.Warehouse'),
        ),
        migrations.AddField(
            model_name='order_items',
            name='product',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hello.Product'),
        ),
        migrations.AddField(
            model_name='order_items',
            name='sale',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='hello.Sale'),
        ),
        migrations.AddField(
            model_name='customer',
            name='history',
            field=models.ManyToManyField(through='hello.Customer_History', to='hello.Product'),
        ),
    ]
