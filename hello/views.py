from django.shortcuts import render
from django.http import HttpResponse

import hello.models as models
import hello.tables as tables



# Create your views here.
def index(request):
    return render(request, 'index.html')

def db(request):
    table_names = {
        'Customer History': 'Customer_History',
        'Sales by Amount': 'Sales_by_Amount',
        'Low Stock': 'Low_Stock'
    }

    if 'table' not in request.GET:
        return render(request, 'db.html', {'table_names': table_names})
    else:
        table_key = request.GET['table']
        table_name = table_names[table_key]
        try:
            Model = models.__dict__[table_name]
        except KeyError:
            return HttpResponse('<h1> nice try hacker</h1>')
        Table = tables.__dict__[table_name + 'Table']

        table = Table(Model.objects.all())
        return render(request, 'db-table.html', {'table': table, 'table_names': table_names})
