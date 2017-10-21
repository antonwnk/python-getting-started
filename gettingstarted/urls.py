from django.conf.urls import include, url

from django.contrib import admin
from django.views.generic import RedirectView

admin.autodiscover()

import hello.views

# Examples:
# url(r'^$', 'gettingstarted.views.home', name='home'),
# url(r'^blog/', include('blog.urls')),

urlpatterns = [
    url(r'^$', hello.views.index, name='index'),
    url(r'^db/?$', hello.views.db, name='db'),
    url(r'^admin/', include(admin.site.urls)),

    # table urls
    url(r'^table-(?P<table_name>\w+)/?$', hello.views.table),

]
