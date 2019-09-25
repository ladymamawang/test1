<%inherit file="/base.mako"/>
<%block name="content">
<div class="king-block king-block-bordered king-block-themed m20">
    <div class="king-block-header king-info">
        <ul class="king-block-options">
            <li>
                <!-- <button type="button"><i class="fa fa-cog"></i></button> -->
            </li>
        </ul>
        <h3 class="king-block-title">查询参数</h3>
    </div>
    <div class="king-block-content">
        <form class="form-horizontal">
            <div class="form-group clearfix ">
                <label class="col-sm-3 control-label bk-lh30 pt0">业务：</label>
                <div class="col-sm-9">
                    <select name="" id="biz_id" class="form-control bk-valign-top">
                        
                    </select>
                </div>
            </div>
            <div class="form-group clearfix ">
                <label class="col-sm-3 control-label bk-lh30 pt0">IP：</label>
                <div class="col-sm-9">
                    <select name="" id="ip" class="form-control bk-valign-top">
                        
                    </select>
                </div>
            </div>
            <div class="form-group clearfix ">
                <label class="col-sm-3 control-label bk-lh30 pt0">Job作业：</label>
                <div class="col-sm-9">
                    <select name="" id="job" class="form-control bk-valign-top">
                        
                    </select>
                </div>
            </div>
            <div class="form-group clearfix">
                <div class="col-sm-9 col-sm-offset-3">
                    <button type="button" class="king-btn mr10  king-success" onclick="search(this)">提交</button>
                    <button type="button" class="king-btn king-default ">取消</button>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="king-block king-block-bordered king-block-themed m20">
    <div class="king-block-header king-info">
        <ul class="king-block-options">
            <li>
                <!-- <button type="button"><i class="fa fa-cog"></i></button> -->
            </li>
        </ul>
        <h3 class="king-block-title">磁盘信息展示</h3>
    </div>
    <div class="king-block-content">
        <table class="table mb0 pr15 ranger-box ">
            <thead></thead>
            <tbody>
                <tr>
                    <td colspan="6"> 没有数据 </td>
                </tr>
            </tbody>
        </table>
        <!-- 设置面板Start -->
        <template id="ranger_nodata_tpl">
            <tr>
                <td colspan="6"> 没有数据 </td>
            </tr>
        </template>
        <template id="header_tpl_1526111412901">
            <tr>
                <th>Filesystem</th>
                <th>Size</th>
                <th>Used</th>
                <th>Avail</th>
                <th>Use%</th>
                <th>Mounted</th>
                
            </tr>
        </template>
        <template id="tpl_1526111412901">
            <tr>
                <td>#Filesystem#</td>
                <td>#Size#</td>
                <td>#Used#</td>
                <td>#Avail#</td>
                <td>#Use%#</td>
                <td>#Mounted#</td>
            </tr>
        </template>
            <!-- 下拉框模板 -->
        <template id="app_tpl">
            <option value="#id#">#name#</option>
        </template>

        <template id="ip_tpl">
            <option value="#ip#">#ip#</option>
        </template>

        <template id="job_tpl">
            <option value="#job_id#">#job_name#</option>
        </template>
        <!-- 设置面板End -->
    </div>
</div>

<div class="king-block king-block-bordered king-block-themed m20">
    <div class="king-block-header king-info">
        <ul class="king-block-options">
            <li>
                <!-- <button type="button"><i class="fa fa-cog"></i></button> -->
            </li>
        </ul>
        <h3 class="king-block-title">磁盘容量趋势</h3>
    </div>
    <button type="button" class="king-btn mr10  king-success" onclick="refresh_chart(this)">刷新图表</button>
    <div class="king-block-content">
        <div style="height: 300px; -webkit-tap-highlight-color: transparent; user-select: none; background-color: rgba(0, 0, 0, 0); cursor: default;" id="chart_1530772671783" class="king-chart-box chart-area " _echarts_instance_="1530762106368"></div>
    </div>
</div>
</%block>
<script>
    function renderTpl(str, cfg) {
            var re = /(#(.+?)#)/g;

            return str.replace(re, function() {
                var val = cfg[arguments[2]]+'';
                if(typeof val == 'undefined') {
                    val = '';
                }
                return val;
            });
        }
    
    /*
    * 查询表单级联数据拉取
    */
    function select_ip(biz_id){
        //级联选择ip
        $('#ip').html('');
        $.get('${SITE_URL}get_capacity/get_ip_by_bizid/', {'biz_id': biz_id}, function(data){
                if(data.result){
                    var _html = '';
                    var list = data.data;
                    var tpl = $('#ip_tpl').html();
                    for (var i=0,len=list.length; i < len; i++){
                        var item = list[i];
                        _html += renderTpl(tpl, item)
                    }
                    $('#ip').html(_html);
                }else{
                    alert("获取失败")
                }
            }, 'json')
        }
    
    function select_job(biz_id){
        //级联选择job
        $('#ip').html('');
        $.get('${SITE_URL}get_capacity/get_job_list/', {'biz_id': biz_id}, function(data){
                if(data.result){
                    var _html = '';
                    var list = data.data;
                    var tpl = $('#job_tpl').html();
                    for (var i=0,len=list.length; i < len; i++){
                        var item = list[i];
                        _html += renderTpl(tpl, item)
                    }
                    $('#job').html(_html);
                }else{
                    alert("获取失败")
                }
            }, 'json')
        }
    
    /*
    * 表单查询事件提交，获取作业执行结果
    */
    function search(obj){
        var biz_id = $('#biz_id').val();
        var ip = $('#ip').val();
        var job_id = $('#job').val();
        $.post('${SITE_URL}get_capacity/execute_job/', {'biz_id': biz_id, 'ip': ip, 'job_id': job_id}, function(data){
                console.log(data)
                if(data.result){
                    var job_instance_id = data.data;
                    // 异步请求后台数据
                    get_capacity(job_instance_id, biz_id, ip);
                }else{
                    alert("获取失败")
                }
            }, 'json');
    }
    
    //获取作业执行结果，渲染表格
    function get_capacity(job_instance_id, biz_id, ip){
        $.ajax({
            url: '${SITE_URL}get_capacity/get_capacity/',
            type: 'GET',
            data: {'biz_id': biz_id, 'job_instance_id': job_instance_id, 'ip': ip},
            dataType: 'json',
            success: function(res){
                var _html = ' ';
                var list = res.data;
                console.log(list)
                if(list.length){
                    var tpl = $('#tpl_1526111412901').html();
                    var headerTpl =  $('#header_tpl_1526111412901').html();
                    for (var i=0,len=list.length; i < len; i++){
                        var item = list[i];
                        _html += renderTpl(tpl, item)
                    }
                    $('.ranger-box thead').html(renderTpl(headerTpl,res.catalogues));
                }else{
                    _html = $('#ranger_nodata_tpl').html();
                    $('.ranger-box thead').html('');
                    //作业未执行完，则继续轮询获取执行结果
                    setTimeout(function () {get_capacity(job_instance_id, biz_id, ip)}, 1 * 1000)
                }
                $('.ranger-box tbody').html(_html);
            }
        });
    }

    $(function(){
        /*
        * 查询表单级联数据拉取
        */
        $.get('${SITE_URL}get_capacity/get_biz_list/', function(data){
                if(data.result){
                    var _html = '';
                    var list = data.data;
                    var tpl = $('#app_tpl').html();
                    for (var i=0,len=list.length; i < len; i++){
                        var item = list[i];
                        _html += renderTpl(tpl, item)
                    }
                    $('#biz_id').html(_html);

                    var biz_id = $("#biz_id").val();
                    select_ip(biz_id);
                }else{
                    alert("获取失败")
                }
            }, 'json')
        
        //业务选择下拉绑定change事件
        $("#biz_id").change(function(){
            var biz_id = $("#biz_id").val();
            console.log(biz_id)
            select_ip(biz_id);
            select_job(biz_id);
        });
    })
        
</script>
<script>
    /*
    * 渲染图表数据
    */
    function createEStandLineChart(conf){    
        var myChart = echarts.init(document.getElementById(conf.selector));
        var legendData = []
        for(var i=0; i < conf.data.series.length;i++){
            legendData.push(conf.data.series[i].name)
        }
        myChart.setOption({
            tooltip : {
                trigger: 'axis'
            },
            legend: {
                y: 'bottom',
                data:legendData
            },
            toolbox: {
                show : true,
                feature : {
                    mark : {show: true},
                    dataView : {show: true, readOnly: false},
                    magicType : {show: true, type: ['bar','line']},
                    restore : {show: true},
                    saveAsImage : {show: true}
                }
            },
            calculable : true,
            xAxis : [
                {
                    type : 'category',
                    data : conf.data.xAxis
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    splitArea : {show : true}
                }
            ],
            series : conf.data.series
        });
        }
    function initEStandLineChart(conf){
        $.ajax({
            url: conf.url,
            type: 'GET',
            dataType: conf.dataType,
            success: function(res){
                //获取数据成功
                console.log(res.data)
                if (res.result){
                    createEStandLineChart({
                        selector: conf.containerId, // 图表容器
                        data: res.data, // 图表数据
                    });
                }
            }
        })
    }
</script>
<script>
    $(function(){
        initEStandLineChart({
            url: '${SITE_URL}get_capacity/chartdata/',
            dataType: 'json',
            containerId: 'chart_1530772671783'
        });   
    });

    function refresh_chart(obj){
        initEStandLineChart({
            url: '${SITE_URL}get_capacity/chartdata/',
            dataType: 'json',
            containerId: 'chart_1530772671783'
        });   
    }
</script>