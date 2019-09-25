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
