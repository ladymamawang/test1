# -*- coding: utf-8 -*-
import json
import datetime
import base64
import time
from celery.task  import task
from django.shortcuts import render,HttpResponse
from blueking.component.shortcuts import get_client_by_request
from mako_application.models import Script,Operation,Version_msg
from django.conf import settings
from mako_templates.mymako import render_json,render_mako_tostring,render_mako


# 开发框架中通过中间件默认是需要登录态的，如有不需要登录的，可添加装饰器login_exempt
# 装饰器引入 from blueapps.account.decorators import login_exempt
def home(request):
    """
    首页
    """
    return render(request, 'mako_application/home.mako')




def contact(request):
    """
    联系我们
    """
    return render(request, 'mako_application/contact.mako')

def test(request):
    result, biz_list, message = get_biz_list(request)
    scripts = Script.objects.all()
    return render(request, 'mako_application/test2.mako',{"biz_list": biz_list
                                                        ,"scripts": scripts})

def blueking(request):
    biz_names = ''
    versions = Version_msg.objects.values_list("name",flat=True)
    result, biz_list, message = get_biz_list(request)
    for biz in biz_list:
        biz_name = biz['name']
        biz_names =  '%s,%s'%(biz_name,biz_names)
        
    #search_host_in_hosts(request)
    #add_host_to_biz(request)
    nodeman_host_import(request)
    
    return render(request,'mako_application/blueking.mako',{
        "versions":versions,
        "biz_list": biz_names,
        "models":''
    })


def free_install(request):
    biz_names = ''
    versions = Version_msg.objects.values_list("name",flat=True)
    result, biz_list, message = get_biz_list(request)
    for biz in biz_list:
        biz_name = biz['name']
        biz_names =  '%s,%s'%(biz_name,biz_names)
        
    #search_host_in_hosts(request)
    #add_host_to_biz(request)
    nodeman_host_import(request)
    
    return render(request,'mako_application/free_install.mako',{
        "versions":versions,
        "biz_list": biz_names,
        "models":''
    })
    
def update(request):
    biz_names = []
    versions = Version_msg.objects.values_list("name",flat=True)
    result, biz_list, message = get_biz_list(request)
    for biz  in biz_list:
        biz_names.append(biz.get('name'))
    #search_host_in_hosts(request)
    #add_host_to_biz(request)
    nodeman_host_import(request)
    
    return render(request,'mako_application/update.mako',{
        "versions":versions,
        "biz_list": biz_names,
        "models":''
    })



def get_biz_list(request):
    biz_list = []
    client = get_client_by_request(request)
    kwargs = {
        'fields': ['bk_biz_id', 'bk_biz_name']
    }
    resp = client.cc.search_business(**kwargs)

    if resp.get('result'):
        data = resp.get('data', {}).get('info', {})
        for _d in data:
            biz_list.append({
                'name': _d.get('bk_biz_name'),
                'id': _d.get('bk_biz_id'),
            })
    return resp.get('result'), biz_list, resp.get('message')
    
def search_host_in_hosts(request):
    ip = '10.0.15.80'
    client = get_client_by_request(request)
    kwargs = {
        "ip": {
            "data": ['10.0.5.187'
            ],
            "exact": 1,
            "flag": "bk_host_innerip"
        },
        "condition":    [
            {
                "bk_obj_id": "host",
                "fields": [],
                "condition": []
            },
            {
                "bk_obj_id":"module",
                "fields":[],
                "condition":[]
            },
            {
                "bk_obj_id":"set",
                "fields":[],
                "condition":[]
            },
            {
                "bk_obj_id":"biz",
                "fields":[],
                "condition":[]
            },
            {
            "bk_obj_id": "object",
            "fields": [],
            "condition": [
                {
                    "field": "bk_inst_id",
                    "operator": "$eq",
                    "value": 76
                }
            ]
            }
        ],
        "page": {
            "start": 0,
            "limit": 10,
            "sort": "bk_host_id"
        },
        "pattern": ""
    }
    resp = client.cc.search_host(**kwargs)
    print(resp)
    if resp.get('result'):
        print('yes')

def add_host_to_biz(request):
    client = get_client_by_request(request)
    kwargs = {
        "host_info":{
        "0": {
            "bk_host_innerip": "10.0.0.1",
            "bk_cloud_id": 0,
            "import_from": "3"
        }
        }
    }
    resp = client.cc.add_host_to_resource(**kwargs)
    
    
def add_biz_list(request):
    biz_name = '测试业务２'
    client = get_client_by_request(request)
    kwargs = {
        "data": {
        "bk_biz_name": biz_name,
        "bk_biz_maintainer": "admin",
        "bk_biz_productor": "admin",
        "bk_biz_developer": "admin",
        "bk_biz_tester": "admin",
        "time_zone": "Asia/Shanghai",
        "language": "1",
        "bk_supplier_id":"0"
        }
    }
    resp = client.cc.create_business(**kwargs)
    if resp.get('result'):
        print(resp.get('result'))
    else:
        print(u'没成功')
    



def get_hosts(request):
    biz_id = request.GET.get("biz_id", 0)
    if biz_id:
        biz_id = int(biz_id)
    else:
        return HttpResponse(json.dumps({
            'result': False,
            'message': "must provide biz_id to get hosts"
        }))

    client = get_client_by_request(request)
    resp = client.cc.search_host({
        "page": {"start": 0, "limit": 5, "sort": "bk_host_id"},
        "ip": {
            "flag": "bk_host_innerip|bk_host_outerip",
            "exact": 1,
            "data": []
        },
        "condition": [
            {
                "bk_obj_id": "host",
                "fields": [
                    # "bk_cloud_id",
                    # "bk_host_id",
                    # "bk_host_name",
                    # "bk_os_name",
                    # "bk_os_type",
                    # "bk_host_innerip",
                ],
                "condition": []
            },
            # {"bk_obj_id": "module", "fields": [], "condition": []},
            # {"bk_obj_id": "set", "fields": [], "condition": []},
            {
                "bk_obj_id": "biz",
                "fields": [
                    "default",
                    "bk_biz_id",
                    "bk_biz_name",
                ],
                "condition": [
                    {
                        "field": "bk_biz_id",
                        "operator": "$eq",
                        "value": biz_id
                    }
                ]
            }
        ]
    })
    hosts = [{
        "ip": host['host']['bk_host_innerip'],
        "os": host['host']['bk_os_name'],
        "bk_cloud_id": host['host']['bk_cloud_id'][0]["id"],
    } for host in resp['data']['info']]
    table_data = json.dumps({
        'hosts': hosts,
    }   )
    return render_json({
        'result': True,
        'data': table_data,
        'message': "success"
    })
def execute(request):
    """执行任务"""

    biz_id = request.POST.get("biz_id")
    script_type = request.POST.get("script_type")
    script_param = request.POST.get("script_param", "")
    ips = request.POST.getlist("ips[]")

    if biz_id:
        biz_id = int(biz_id)

    if script_type:
        script_type = int(script_type)

    try:
        script_content = Script.objects.get(id=script_type).script
    except Script.DoesNotExist:
        return render_json({"result": False, "message": "script not exist!"})

    client = get_client_by_request(request)

    task = run_script.delay(client, biz_id, script_content, script_param, ips)

    opt = Operation.objects.create(
        biz=biz_id,
        script=Script.objects.get(id=script_type),
        machine_numbers=len(ips),
        celery_id=task.id,
        argument=script_param,
        user=request.user.username
    )

    return render_json({"result": True, "data": opt.celery_id, "message": "success"})


@task
def run_script(client, biz_id, script_content, script_param, ips):
    """快速执行脚本"""

    # 执行中
    Operation.objects.filter(celery_id=run_script.request.id).update(
        status="running"
    )

    resp = client.job.fast_execute_script(
        bk_biz_id=biz_id,
        account="root",
        script_param=base64.b64encode(script_param),
        script_content=base64.b64encode(script_content),
        ip_list=[{"bk_cloud_id": 0, "ip": ip} for ip in ips]
    )

    # 启动失败
    if not resp.get('result', False):
        Operation.objects.filter(celery_id=run_script.request.id).update(
            log=json.dumps([resp.get("message")]),
            end_time=datetime.datetime.now(),
            result=False,
            status="start_failed"
        )

    task_id = resp.get('data').get('job_instance_id')
    poll_result = poll_job_task(client, biz_id, task_id)

    # 查询日志
    resp = client.job.get_job_instance_log(job_instance_id=task_id, bk_biz_id=biz_id)
    ip_logs = resp['data'][0]['step_results'][0]['ip_logs']
    status = resp['data'][0]['status']

    result = True if status == 3 else False
    Operation.objects.filter(celery_id=run_script.request.id).update(
        log=json.dumps(ip_logs),
        end_time=datetime.datetime.now(),
        result=result,
        status="successed" if result else "failed"
    )


def poll_job_task(client, biz_id, job_instance_id):
    """true/false/timeout"""

    count = 0

    res = client.job.get_job_instance_status(job_instance_id=job_instance_id, bk_biz_id=biz_id)

    while res.get('data', {}).get('is_finished') is False and count < 30:
        res = client.job.get_job_instance_status(job_instance_id=job_instance_id, bk_biz_id=biz_id)
        count += 1
        time.sleep(3)

    return res
    
def nodeman_host_import(request):
    ip = '10.0.0.4'
    client = get_client_by_request(request)
    kwargs = {
        "bk_biz_id": 2,
        "creator": "admin",
        "hosts": [
            {
                "inner_ips":ip,
                "outer_ip": ip,
                "os_type":"LINUX",
                "has_cygwin":False,
                "port":22,
                "account":"root",
                "auth_type":"PASSWORD",
                "password":'asdfadsf',
                "key":" "
            }
        ],
        "bk_cloud_id":"adf",
        "node_type":"PAGENT",
        "op_type":"INSTALL",
    }
    resp = client.nodeman.create_task(**kwargs)

