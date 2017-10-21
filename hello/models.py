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

    productId = models.AutoField(primary_key=True)
    category = models.CharField(max_length=2, choices=CATEGORY_CHOICES)
    price = models.DecimalField(decimal_places=2, max_digits=8)
    full_name = models.CharField(max_length=50, blank=False, null=False)
    description = models.TextField(max_length=5000)

    def __str__(self):
        return self.full_name

    def __unicode__(self):
        return self.full_name


class Warehouse(models.Model):
    warehouseId = models.AutoField(primary_key=True)
    address = models.TextField(max_length=100)

    def __str__(self):
        return self.address

    def __unicode__(self):
        return self.address


class Supplier_Contact(models.Model):
    phone_no = models.PositiveIntegerField(null=False, blank=False)
    address = models.CharField(max_length=50, null=False, blank=False)
    email = models.CharField(max_length=25, null=False, blank=False)

    def __str__(self):
        return 'Details for: ' + self.supplier.name

    def __unicode__(self):
        return 'Details for: ' + self.supplier.name


class Supplier(models.Model):
    name = models.CharField(primary_key=True, max_length=20)
    contact_details = models.OneToOneField(
        Supplier_Contact,
        null=True,
        on_delete=models.SET_NULL
    )

    def __str__(self):
        return self.name

    def __unicode__(self):
        return self.name


class Customer(models.Model):
    customerId = models.AutoField(primary_key=True)
    name = models.CharField(max_length=50)
    email = models.EmailField()
    hashed_password = models.CharField(max_length=32)
    address = models.TextField(max_length=100)
    history = models.ManyToManyField(Product, db_table='hello_customer_history')

    def __str__(self):
        return str(self.customerId)

    def __unicode__(self):
        return str(self.customerId)


class Stock(models.Model):
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    warehouse = models.ForeignKey(Warehouse, on_delete=models.CASCADE)
    quantity = models.SmallIntegerField(default=0)

    def __str__(self):
        return str(self.quantity)

    def __unicode__(self):
        return str(self.quantity)


class Supplier_Stock(models.Model):
    supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
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

    saleId = models.AutoField(primary_key=True)
    date = models.DateField(default=datetime.date.today)
    time = models.TimeField(default=datetime.time.max)
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT, null=True)  # FIXME
    items = models.ManyToManyField(Product, through='Order_Items')
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
    quantity = models.SmallIntegerField(default=1)

    def __str__(self):
        return 'Sale{} - product{} x {}'.format(self.sale, self.product, self.quantity)

    def __unicode__(self):
        return 'Sale{} - product{} x {}'.format(self.sale, self.product, self.quantity)
