from django.shortcuts import render
import hello.models
from django.http import HttpResponse


# Create your views here.
def index(request):
    return render(request, 'index.html')


def db(request):

    prod = hello.models.Product()

    return render(request, 'db.html', {'models': [prod]})

