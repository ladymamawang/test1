# -*- coding: utf-8 -*-
# from django.contrib import admin

# Register your models here.
from django.contrib import admin
from mako_application.models import Script,Operation,Version_msg

admin.site.register(Script)
admin.site.register(Operation)
admin.site.register(Version_msg)