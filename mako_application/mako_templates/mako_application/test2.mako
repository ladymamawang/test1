<%inherit file="/base.mako"/>
<%block name="content">
    <div class="king-page-box">
        <div class="king-container clearfix">
            <nav role="navigation" class="navbar navbar-default king-horizontal-nav2    f14 ">
                <div class="container " style="width:100%;overflow:hidden;">
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle collapsed navbar-toggle-sm" data-toggle="collapse" data-target="#king-horizontal-nav2-collapse">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <a class="navbar-brand" href="javascript:;">
                            <img src="https://magicbox.bk.tencent.com/static_api/v3/bk/images/logo3.png" alt="" class="logo"> </a>
                    </div>
                    <div class="collapse navbar-collapse navbar-responsive-collapse" id="king-horizontal-nav2-collapse">
                        <ul class="nav navbar-nav">
                            <li class="king-navbar-active"><a href="javascript:void(0);">首页</a></li>
                            <li><a href="javascript:void(0);">数据统计</a></li>
                            <li><a href="javascript:void(0);">单据统计</a></li>
                        </ul>
                        <ul class="nav navbar-nav navbar-right">
                            <li>
                                <a href="javascript:;">
                                    <span>管理者</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div class="king-block king-block-bordered king-block-themed mb0">
                <div class="king-block-header king-info">
                    <ul class="king-block-options">
                        <li>
                            <!-- <button type="button"><i class="fa fa-cog"></i></button> -->
                        </li>
                    </ul>
                    <h3 class="king-block-title">面板标题</h3>
                </div>
                <div class="king-block-content">
                    <form class="form-horizontal">
                        <div class="form-group clearfix ">
                            <label class="col-sm-3 control-label bk-lh30 pt0">参数：</label>
                            <div class="col-sm-9">
                                <select name="" id="biz_id" class="form-control bk-valign-top">
                                    % for biz in biz_list:
                                        <option value="${ biz['id'] }">${ biz['name']}</option>
                                    % endfor
                                </select>
                            </div>
                        </div>
                        <div class="form-group clearfix ">
                            <label class="col-sm-3 control-label bk-lh30 pt0">脚本参数：</label>
                            <div class="col-sm-9">
                                <!--
                                <select name="" id="biz_id" class="form-control bk-valign-top">
                                    % for i in [1,2,34]:
                                        <option value="${ i }">${ i }</option>
                                    % endfor
                                </select>
                                -->
                                <input type='text' id="script-sparam" class="form-control bk-valign-top" placeholder='可选'>
                            </div>
                        </div>
                        <div class="form-group clearfix ">
                            <label class="col-sm-3 control-label bk-lh30 pt0">选择脚本：</label>
                            <div class="col-sm-9">
                                <select name="" id="script_type" class="form-control bk-valign-top">
                                    % for script in scripts:
                                        <option value="${ script.id }">${ script.name }</option>
                                    % endfor
                                </select>
                            </div>
                        </div>
                        <div class="form-group clearfix">
                            <div class="col-sm-9 col-sm-offset-3">
                                <button type="button" class="king-btn mr10  king-success">提交</button>
                                <button type="button" class="king-btn king-default ">取消</button>
                            </div>
                        </div>
                    </form>
                    <div class="king-block king-block-bordered king-block-themed mb0">
                        <div class="king-block-header king-info">
                            <ul class="king-block-options">
                                <li>
                                    <!-- <button type="button"><i class="fa fa-cog"></i></button> -->
                                </li>
                            </ul>
                            <h3 class="king-block-title">面板标题</h3>
                        </div>
                        <div class="king-block-content">
                            <!-- 设置面板End -->
                        </div>
                    </div>
                    <div class="king-block king-block-bordered king-block-themed mb0">
                        <div class="king-block-header king-info">
                            <ul class="king-block-options">
                                <li>
                                    <!-- <button type="button"><i class="fa fa-cog"></i></button> -->
                                </li>
                            </ul>
                            <h3 class="king-block-title">面板标题</h3>
                        </div>
                        <div class="king-block-content">
                            <div style="height: 300px; position: relative;" id="chart_1569034703163" class="king-chart-box chart-line  k-chart" data-role="chart"></div>
                        </div>
                    </div>
                    <form class="form-horizontal"></form>
                </div>
            </div>
        </div>
        <tbody id="host-tbody"></tbody>
    </div>
    <script>
        $(function(){
            get_host()
            $("#biz_id").change(function(){
                get_host()
            });
        });
        $(function(){
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

                // 异步请求后台数据
                $.ajax({
                    url: 'https://magicbox.bk.tencent.com/static_api/v3/components/table7/data.json',
                    type: 'GET',
                    success: function(res){
                        var _html = ' ';
                        var list = res.items;
                        var tpl = $('#tpl_15690827662262').html();
                        var headerTpl =  $('#header_tpl_15690827662262').html();
                        for (var i=0,len=list.length; i < len; i++){
                            var item = list[i];
                            _html += renderTpl(tpl, item)
                        }
                        $('.ranger-box2 tbody').html(_html);
                        $('.ranger-box2 thead').html(renderTpl(headerTpl,res.catalogues));
                    }
                });
            });
    </script>
    <script>
        function get_host() {
            $.ajax({
                url: '${ SITE_URL }api/get_hosts',
                type: 'GET',
                data: {"biz_id": $("#biz_id").val(), "script_type": $("#script_typ  e").val()},
                success: function (res) {
                    if (res.result) {
                        $('#table_demo2 tbody').html(res.data)
                        //init_table();
                    } else {
                        alert(res.message);
                    }
                    //$('#table_demo2 tbody').html(_html);
                    // initTableCheckbox();
                }
            });
        }

        // 创建图表
        function createKendoLineChart(conf){
            $(conf.selector).kendoChart({
                transitions: false,
                legend: {
                   position: "bottom"
                },
                colors: ['yellow'],
                theme : 'bootstrap',
                seriesDefaults: {
                    type: 'line',
                    style: "smooth",
                    markers: {
                        visible: false
                    }
                },
                series: conf.data.series,
                categoryAxis: {
                    majorGridLines : {
                        visible: false
                    },
                    categories: conf.data.categories,
                    labels: {
                        rotation: "auto"
                    }
                },
                tooltip: {
                    visible: true,
                    template: "#= category # #= value #"
                }
            });
            //重新绘制
            $(window).on('resize',function(){
                var chart = $(conf.selector).data("kendoChart");
                chart.redraw();
            });
        }
        
        function initKendoLineChart(conf){
            // 异步请求后台数据
            $.ajax({
                url: conf.url,
                type: 'GET',
                dataType: conf.dataType,
                success: function(res){
                    //获取数据成功
                    if (res.result){
                        var data = {
                            series: res.data.series,
                            categories: res.data.categories
                        };
                        createKendoLineChart({
                            selector: conf.container, // 图表容器
                            data: data // 图表数据
                        });
                    }
                }
            });
        }
    </script>
    <script>
        $(function(){
            initKendoLineChart({
                url: 'https://magicbox.bk.tencent.com/static_api/v3/components/charts_line/demo.json',
                dataType: 'json',
                container: '#chart_1569034703163'
            });
        });
    </script>
</%block>
