from django.shortcuts import render
from django.http import HttpResponse

import hello.models as models
import hello.tables as tables



# Create your views here.
def index(request):
    return render(request, 'index.html')


def db(request):
    # model_classes = [item for item in models.__dict__.items() if item[0][0].isupper()]
    # table_names = [item[0].replace('_', ' ') for item in model_classes]
    table_names = ['Product']


    if 'table' not in request.GET:
        return render(request, 'db.html', {'table_names': table_names})
    else:
        table_name = request.GET['table']
        Model = models.__dict__[table_name]
        Table = tables.__dict__[table_name + 'Table']

        if not Model:
            return HttpResponse('<h1> nice try hacker</h1>')

        table = Table(Model.objects.all())
        return render(request, 'db-table.html', {'table': table, 'table_names': table_names})
