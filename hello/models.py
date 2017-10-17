from django.db import models
import datetime

# Create your models here.


class Product(models.Model):
    pId = models.AutoField(primary_key=True)
    price = models.DecimalField(decimal_places=2, max_digits=8)
    full_name = models.CharField(max_length=50, blank=False, null=False)
    description = models.TextField(max_length=400)

    def __str__(self):
        return self.full_name

    def __unicode__(self):
        return self.full_name


class Warehouse(models.Model):
    whId = models.AutoField(primary_key=True)
    address = models.TextField(max_length=100)

    def __str__(self):
        return self.address

    def __unicode__(self):
        return self.address


class Supplier(models.Model):
    name = models.CharField(primary_key=True, max_length=20)

    def __str__(self):
        return self.name

    def __unicode__(self):
        return self.name


class Sale(models.Model):
    # def current_time(self):
    #     return datetime.datetime.now().time()

    saleId = models.AutoField(primary_key=True)
    date = models.DateField(default=datetime.date.today)
    time = models.TimeField(auto_now_add=True)

    def __str__(self):
        return self.date.__str__() + ' ' + self.time.__str__()

    def __unicode__(self):
        return self.date.__str__() + ' ' + self.time.__str__()


class Customer(models.Model):
    customerId = models.AutoField(primary_key=True)
    address = models.TextField(max_length=100)

    def __str__(self):
        return self.customerId

    def __unicode__(self):
        return self.customerId

class Stock(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE)
    quantity = models.SmallIntegerField(default=48)

class Supplier_Contact(models.Model):
    supplier = models.OneToOneField(Supplier, on_delete=models.CASCADE)
    phone_no = models.PositiveIntegerField(null=False, blank=False)
    address = models.CharField(max_length=50, null=False, blank=False)
    email = models.CharField(max_length=25, null=False, blank=False)