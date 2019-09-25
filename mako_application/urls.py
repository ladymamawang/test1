# -*- coding: utf-8 -*-
"""testapp URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import url

from mako_application import views

urlpatterns = (
    url(r'^$', views.home),
    url(r'^home', views.home),
    url(r'^contact/$', views.contact),
    url(r'^get_capacity/',views.test),
    url(r'api/get_host',views.get_hosts),
    url(r'^blueking/',views.blueking),
    url(r'^free_install/',views.free_install),
    url(r'^update/',views.update),
)
