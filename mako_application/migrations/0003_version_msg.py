# -*- coding: utf-8 -*-
# Generated by Django 1.11.2 on 2019-09-23 15:44
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('mako_application', '0002_operation'),
    ]

    operations = [
        migrations.CreateModel(
            name='Version_msg',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=100)),
                ('script', models.TextField()),
                ('models', models.TextField()),
            ],
        ),
    ]