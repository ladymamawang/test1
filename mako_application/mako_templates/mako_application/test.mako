<!--HTML-->
<div class="king-block king-block-bordered">
    <div class="king-block-header king-gray-light">
        <h3 class="king-block-title">基础示例</h3>
    </div>
    <div class="king-block-content clearfix" id="dome1">
        <ul class="ul-box">
            <li>
              <label><input tabindex="1" type="checkbox" id="input-1"> Checkbox 1</label>
            </li>
            <li>
              <label><input tabindex="1" type="checkbox" id="input-2" checked> Checkbox 2</label>
            </li>
        </ul>
    </div>
</div>



<!--JS-->
<script src="https://magicbox.bk.tencent.com/static_api/v3/assets/icheck-1.x/icheck.min.js"></script>
<script type="text/javascript">
$(function () {
    $('#dome1 input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue'
    });
 
    //设置不同风格的皮肤
    $('.tab-content .tab-pane').each(function () {
        var me = $(this),
            skin = me.attr('id');
        me.find('input').iCheck({
            checkboxClass: 'icheckbox_' + skin + '-blue',
            radioClass: 'iradio_' + skin + '-blue'
        })
    });
 
    //切换皮肤颜色
    $('.colors li').click(function () {
        var self = $(this);
 
        if (!self.hasClass('active')) {
            self.siblings().removeClass('active');
            var color = self.attr('class') ? '-' + self.attr('class') : '',
                checkbox_default = 'icheckbox_minimal',
                radio_default = 'iradio_minimal';
 
            $('.tab-content .tab-pane').each(function () {
                var me = $(this),
                    skin = me.attr('id'),
                    checkbox_default = 'icheckbox_' + skin,
                    radio_default = 'iradio_' + skin;
                me.find('ul:eq(0)>li>div') //找到复选框
                .removeClass() //移除旧样式
                .addClass(checkbox_default + color) //增加新样式
                .iCheck('update'); //更新插件
 
                me.find('ul:eq(1)>li>div') //找到单选框
                .removeClass()
                    .addClass(radio_default + color)
                    .iCheck('update');
            });
            self.addClass('active');
        };
    });
 
    //综合示例
    $('#dome2 input').iCheck({
        checkboxClass: 'icheckbox_square-blue'
    });
    $('#dome2 button').on('click', function () {
        var me = $(this),
            action = me.attr('action');
        switch (action) {
        case "checkAll":
            $('#dome2 input').iCheck('check'); //设置选中
            break;
        case "unCheckAll":
            $('#dome2 input').iCheck('uncheck'); //取消选中
            break;
        case "toggle":
            $('#dome2 input').iCheck('toggle'); //状态切换
            break;
        case "disable":
            $('#dome2 input').iCheck('disable'); //禁用
            break;
        case "enable":
            $('#dome2 input').iCheck('enable'); //启用
            break;
        case "clear":
            $('#log').val('');
            break;
        }
    });
 
    function log(e) {
        var target = e.target;
        var msg = "事件类型：" + e.type + ", 对象：" + $(target).parents('label').text();
        $('#log').val(msg + "\r\n" + $('#log').val());
    }
 
    //事件绑定
    var events = ["ifClicked", "ifChanged", "ifChecked", "ifUnchecked", "ifToggled", "ifDisabled", "ifEnabled"]
    $.each(events, function (index, event) {
        $('#dome2 input').on(event, function (e) {
            log(e);
        });
    });
 
});
</script>
