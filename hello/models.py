from django.db import models
import datetime


# Create your models here.


class Product(models.Model):
    COMPUTERS = 'CP'
    APPLIANCES = 'AP'
    PHONES = 'PH'
    CAMERAS = 'CM'
    CATEGORY_CHOICES = (
        (COMPUTERS, 'Computers'),
        (APPLIANCES, 'Appliances'),
        (PHONES, 'Phones'),
        (CAMERAS, 'Cameras')
    )

    product_id = models.AutoField(primary_key=True)
    category = models.CharField(max_length=2, choices=CATEGORY_CHOICES)
    price = models.DecimalField(decimal_places=2, max_digits=8)
    full_name = models.CharField(max_length=500, blank=False, null=False)
    description = models.TextField(max_length=5000)

    def __str__(self):
        return self.full_name

    def __unicode__(self):
        return self.full_name


class Warehouse(models.Model):
    warehouse_id = models.AutoField(primary_key=True)
    address = models.TextField(max_length=120)

    def __str__(self):
        return self.address

    def __unicode__(self):
        return self.address


class Supplier(models.Model):
    supplier_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=500)

    def __str__(self):
        return self.name

    def __unicode__(self):
        return self.name


class Supplier_Contact(models.Model):
    supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)
    phone_no = models.CharField(max_length=12, blank=False)
    address = models.CharField(max_length=500, blank=False)
    email = models.EmailField()

    def __str__(self):
        return 'Details for: ' + self.supplier.name

    def __unicode__(self):
        return 'Details for: ' + self.supplier.name


class Customer(models.Model):
    customer_id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=500)
    email = models.EmailField()
    hashed_password = models.CharField(max_length=32)
    address = models.TextField(max_length=1000)
    history = models.ManyToManyField(Product, through='Customer_History')

    def __str__(self):
        return str(self.customer_id)

    def __unicode__(self):
        return str(self.customer_id)


class Stock(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE)
    quantity = models.SmallIntegerField(default=0)

    def __str__(self):
        return str(self.quantity)

    def __unicode__(self):
        return str(self.quantity)


class Supplier_Stock(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)
    quantity = models.SmallIntegerField(default=0)

    def __str__(self):
        return str(self.quantity)

    def __unicode__(self):
        return str(self.quantity)


class Sale(models.Model):
    PROCESSING = 'PS'
    IN_TRANSIT = 'TS'
    DELIVERED = 'DV'
    REJECTED = 'RJ'
    ORDER_STATUS_CHOICES = (
        (PROCESSING, 'Processing'),
        (IN_TRANSIT, 'In transit'),
        (DELIVERED, 'Delivered'),
        (REJECTED, 'Rejected')
    )

    sale_id = models.AutoField(primary_key=True)
    date = models.DateField(default=datetime.date.today)
    time = models.TimeField(default=datetime.time.max)
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT)
    order_status = models.CharField(
        max_length=2,
        choices=ORDER_STATUS_CHOICES,
        default=PROCESSING
    )

    def __str__(self):
        return self.date.__str__() + ' ' + self.time.__str__()

    def __unicode__(self):
        return self.date.__str__() + ' ' + self.time.__str__()


class Order_Items(models.Model):
    sale = models.ForeignKey(Sale)
    product = models.ForeignKey(Product)
    quantity = models.IntegerField(default=1)

    def __str__(self):
        return 'Sale{} - product{} x {}'.format(self.sale, self.product, self.quantity)

    def __unicode__(self):
        return 'Sale{} - product{} x {}'.format(self.sale, self.product, self.quantity)


class Customer_History(models.Model):
    id = models.BigIntegerField(primary_key=True)
    customer = models.ForeignKey(Customer, on_delete=models.DO_NOTHING)
    product = models.ForeignKey(Product, on_delete=models.DO_NOTHING)
    product_category = models.CharField(max_length=2)
    product_price = models.DecimalField(decimal_places=2, max_digits=8)
    product_name = models.CharField(max_length=500)
    product_description = models.TextField(max_length=5000)

    class Meta:
        managed = False
        db_table = 'hello_customer_history_v'


class Low_Stock(models.Model):
    id = models.BigIntegerField(primary_key=True)
    product = models.ForeignKey(Product, on_delete=models.DO_NOTHING)
    stock = models.IntegerField()
    supplierstock = models.IntegerField()
    suppliername = models.CharField(max_length=500)
    phone_no = models.CharField(max_length=12)
    address = models.CharField(max_length=500)
    email = models.EmailField()

    class Meta:
        managed = False
        db_table = 'hello_low_stock'


class Sales_by_Amount(models.Model):
    id = models.BigIntegerField(primary_key=True)
    sale = models.ForeignKey(Sale, on_delete=models.DO_NOTHING)
    date = models.DateField()
    time = models.TimeField()
    order_status = models.CharField(max_length=2)
    customer = models.ForeignKey(Customer, on_delete=models.DO_NOTHING)
    total_amount = models.IntegerField()

    class Meta:
        managed = False
        db_table = 'hello_sales_by_amount'