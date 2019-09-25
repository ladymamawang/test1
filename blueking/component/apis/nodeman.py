# -*- coding: utf-8 -*-
from ..base import ComponentAPI


class CollectionsNODE(object):
    """Collections of JOB APIS"""

    def __init__(self, client):
        self.client = client

        self.create_task = ComponentAPI(
            client=self.client, method='POST',
            path='/api/c/compapi{bk_api_ver}/nodeman/create_task/',
            description=u'导入主机'
        )