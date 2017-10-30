import django_tables2 as tables
from hello.models import *

class ProductTable(tables.Table):
    class Meta:
        model = Product
        attrs = {'class': 'table'}

class Customer_HistoryTable(tables.Table):
    class Meta:
        model = Customer_History
        attrs = {'class': 'jumbotron table'}

class Low_StockTable(tables.Table):
    class Meta:
        model = Low_Stock
        attrs = {'class': 'jumbotron table'}

class Sales_by_AmountTable(tables.Table):
    class Meta:
        model = Sales_by_Amount
        attrs = {'class': 'jumbotron table'}