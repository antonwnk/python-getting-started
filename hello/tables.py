import django_tables2 as tables
from hello.models import *

class ProductTable(tables.Table):
    class Meta:
        model = Product
        attrs = {'class': 'table'}