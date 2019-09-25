<%inherit file="/base.mako"/>
<%block name="content">
    <div class="king-page-box">
        <div class="king-layout1-header">
            <nav>
                <div style="overflow:hidden;" class="king-header king-header2  ">
                    <div class="king-header-inner">
                        <div class="king-header-brand">
                            <a href="javascript:;">
                                <img src="https://magicbox.bk.tencent.com/static_api/v3/bk/images/logo3.png" alt="" class="logo"> </a>
                        </div>
                        <div class="king-header-list list2">
                            <ul>
                                <li> <a href="javascript:;"><i class="glyphicon glyphicon-shopping-cart"></i></a> </li>
                                <li> <a href="javascript:;"><i class="glyphicon glyphicon-search"></i></a> </li>
                            </ul>
                        </div>
                        <div class="king-header-list list1">
                            <ul>
                                <li class="active">
                                    <a class="list-home f14" href="${SITE_URL}mako/blueking/">
                                        <span>已验证版本安装</span>
                                    </a>
                                </li>
                                <li>
                                    <a class="list-home f14" href="${SITE_URL}mako/free_install/">
                                        <span>自定义安装</span>
                                    </a>
                                </li>
                                <li>
                                    <a class="list-home f14" href="${SITE_URL}mako/update/">
                                        <span>更新</span>
                                    </a>
                                </li>
                                <li>
                                    <a class="list-home f14" href="javascript:void(0);">
                                        <span>合作伙伴</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <div class="king-layout1-main clearfix">
            <!-- sidebar start -->
            <div class="king-layout1-sidebar" style="width:216px;">
                <ul class="king-timeline-simple  ">
                    <li class="info">
                        <div class=""> 
                            <span class="timeline-simple-date">2016-08-11 08:00</span>
                        </div>
                    </li>
                    <li class="primary">
                        <div class=""> 
                            <span class="timeline-simple-date">2016-05-11 10:00</span>
                        </div>
                    </li>
                    <li class="success">
                        <div class=""> 
                            <span class="timeline-simple-date">2016-08-12 18:00</span>
                        </div>
                    </li>
                    <li class="warning">
                        <div class=""> 
                            <span class="timeline-simple-date">2016-08-11 20:00</span>
                        </div>
                    </li>
                    <li class="warning">
                        <div class=""> １２
                            <span class="timeline-simple-date"></span>
                        </div>
                    </li>
                    <li class="">
                        <div class=""> ３
                            <span class="timeline-simple-date"></span>
                        </div>
                    </li>
                    <li class="">
                        <div class=""> ６
                            <span class="timeline-simple-date"></span>
                        </div>
                    </li>
                    <li class="">
                        <div class=""> ３４５
                            <span class="timeline-simple-date"></span>
                        </div>
                    </li>
                </ul>
            </div>
            <!-- sidebar end -->
            <!-- content start -->
            <div class="king-content-wrap">
                <div class="king-layout1-content" style="margin-left: 216px;">
                    <form action='/test2/' method="post" class="form-vertical p15" enctype="multipart/form-data">
                        <div class="king-pearls king-parls king-justified-pearls">
                            <div class="king-pearl done">
                                <span class="king-pearl-number f12">1</span>
                                <span class="king-pearl-title f12">选择版本号</span>
                            </div>
                            <div class="king-pearl">
                                <span class="king-pearl-number f12">2</span>
                                <span class="king-pearl-title f12">提交表单或ip</span>
                            </div>
                            <div class="king-pearl">
                                <span class="king-pearl-number f12">3</span>
                                <span class="king-pearl-title f12">上传配置文件</span>
                            </div>
                            <div class="king-pearl">
                                <span class="king-pearl-number f12">4</span>
                                <span class="king-pearl-title f12">检查主机业务</span>
                            </div>
                            <div class="king-pearl">
                                <span class="king-pearl-number f12">5</span>
                                <span class="king-pearl-title f12">开始安装</span>
                            </div>
                        </div>
                        <!-- 设置面板Start -->
                        <!-- 设置面板End -->
                        <div class="form-group ">
                            <label>选择业务：</label>
                             <select name="" id="script_type" class="form-control bk-valign-top">
                                % for biz in biz_list:
                                    <option value="${ biz }">${ biz }</option>
                                % endfor
                            </select>
                                <div class="king-block-content clearfix" id="dome1">
                                % for  model in models:
                                    <ul class="ul-box">
                                        <li>
                                          <label><input tabindex="1" type="checkbox" id="input-2" checked>${ model }</label>
                                        </li>
                                    </ul>
                                % endfor
                                </div>
                        </div>
                        <div class="form-group" >
                            <label>更新模块名称：</label>
                            <input type="text" class="form-control" name="domain" placeholder="name">
                            <p class="help-block"></p>
                        </div>
                        <div class="form-group" >
                            <label>包文件下载地址：</label>
                            <input type="text" class="form-control" name="domain" placeholder='www'>
                            <p class="help-block"></p>
                        </div>
                        <div class="form-group ">
                            <label>填写admin登录密码：</label>
                            <input type="text" class="form-control" name="domain" placeholder="默认为blueking" value='blueking'>
                            <p class="help-block"></p>
                        </div>                        
                         <div class="form-group ">
                            <label>密码：</label>
                            <input type="password" class="form-control" id="" name="passwd" placeholder="主机统一密码" >
                            <p class="help-block"></p>
                        </div>
   
                        <div class="form-group">
                                <button type="submit" class="king-btn mr10  king-success">提交</button>
                                <button type="button" class="king-btn king-default ">取消</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- content end -->
        </div>
    </div>

</%block>
