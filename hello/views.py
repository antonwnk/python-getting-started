from django.shortcuts import render
import hello.models
from django.http import HttpResponse


# Create your views here.
def index(request):
    return render(request, 'index.html')


def db(request):

    return render(request, 'db.html')


def table(request, table_name):
    return HttpResponse('Helo ' + table_name)
