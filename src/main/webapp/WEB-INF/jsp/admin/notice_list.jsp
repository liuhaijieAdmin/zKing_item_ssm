<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/5/5
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../../common/head.jsp"%>
<%@taglib prefix="z" uri="/zking" %>
<!DOCTYPE html>
<html class="x-admin-sm">
<head>
    <meta charset="UTF-8">
    <title>欢迎页面-X-admin2.2</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,user-scalable=yes, minimum-scale=0.4, initial-scale=0.8,target-densitydpi=low-dpi" />
    <link rel="stylesheet" href="${ctx}/css/font.css">
    <link rel="stylesheet" href="${ctx}/css/xadmin.css">
    <script src="${ctx}/lib/layui/layui.js" charset="utf-8"></script>
    <script type="text/javascript" src="${ctx}/js/xadmin.js"></script>
    <!--[if lt IE 9]>
    <script src="https://cdn.staticfile.org/html5shiv/r29/html5.min.js"></script>
    <script src="https://cdn.staticfile.org/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>
<div class="x-nav">
          <span class="layui-breadcrumb">
            <a href="">首页</a>
            <a href="">公告管理</a>
            <a>
              <cite>公告设置</cite></a>
          </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i></a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form layui-col-space5">
                        <div class="layui-inline layui-show-xs-block" action="/notice/noticeList" method="post" >
                            <input type="text" name="nname"  placeholder="请输入用户名" autocomplete="off" class="layui-input">
                        </div>
                        <div class="layui-inline layui-show-xs-block">
                            <button class="layui-btn"  lay-submit="" lay-filter="sreach"><i class="layui-icon">&#xe615;</i></button>
                        </div>
                        <div class="layui-input-inline layui-show-xs-block" >
                            <button class="layui-btn layui-btn-danger" onclick="delAll();return false;"><i class="layui-icon"></i>批量删除</button>
                        </div>
                    </form>
                </div>
                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" lay-filter="checkall" name="" lay-skin="primary">
                            </th>
                            <th>ID</th>
                            <th>公告标题</th>
                            <th>公告内容</th>
                            <th>公告类别</th>
                            <th>公告logo</th>
                            <th>发布时间</th>
                            <th>状态</th>
                            <th>操作</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i" items="${listNotice}" >
                            <tr>
                                <td>
                                    <input type="checkbox" name="id" value="${i.nid}"   lay-skin="primary">
                                </td>
                                <td>${i.nid}</td>
                                <td><z:sub name="${i.nname}" size="5" /></td>
                                <td><z:sub name="${i.ncontent}"/> </td>
                                <td>${i.dictItem}</td>
                                <td title="${i.nimg}" ><z:sub name="${i.nimg}"/></td>
                                <td><fmt:formatDate value="${i.ntime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                                <c:if test="${i.nstatus==1}" >
                                    <td class="td-status">
                                        <span class="layui-btn layui-btn-normal layui-btn-mini">已启用</span></td>
                                    <td class="td-manage">
                                     <a id = "${i.nid}" onclick="member_stop(this,this.id)" href="javascript:;"  title="停用">
                                            <i class="layui-icon">&#xe601;</i>
                                     </a>
                                 </c:if>
                                 <c:if test="${i.nstatus==0}" >
                                    <td class="td-status">
                                        <span class="layui-btn layui-btn-disabled layui-btn-disabled">已停用</span></td>
                                    <td class="td-manage">
                                        <a id = "${i.nid}" onclick="member_stop(this,this.id)" href="javascript:;"  title="启用">
                                            <i class="layui-icon">&#xe601;</i>
                                        </a>
                                 </c:if>
                                    <a title="编辑" onclick="xadmin.add_tab('编辑','${ctx}/notice/noticeEdit?nid=${i.nid}')" href="javascript:;">
                                        <i class="layui-icon">&#xe642;</i>
                                    </a>
                                    <a id="${i.nid}" title="删除" onclick="member_del(this,this.id)" href="javascript:;">
                                        <i class="layui-icon">&#xe640;</i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
                <z:pageLayui pageBean="${pageBean}"/>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    layui.use(['laydate','form'], function(){
        var  form = layui.form;

        // 监听全选
        form.on('checkbox(checkall)', function(data){

            if(data.elem.checked){
                $('tbody input').prop('checked',true);
            }else{
                $('tbody input').prop('checked',false);
            }
            form.render('checkbox');
        });

    });



    /*用户-停用*/
    function member_stop(obj,id){
        var title = $(obj).attr('title');
        layer.confirm('确认要'+title+'吗？',function(index){
            if($(obj).attr('title')=='停用'){
                $.ajax({
                    url : "notice/noticeStatus?status=0&id="+id,
                    dataType:'json',
                    success : function(data) {
                        if(data=="1"){
                            //发异步把用户状态进行更改
                            $(obj).attr('title','启用')
                            $(obj).find('i').html('&#xe62f;');

                            $(obj).parents("tr").find(".td-status").find('span').addClass('layui-btn-disabled').html('已停用');
                            layer.msg('已停用!',{icon: 5,time:1000});
                        }
                    }
                });
            }else{
                $.ajax({
                    url : "notice/noticeStatus?status=1&id="+id,
                    dataType:'json',
                    success : function(data) {
                        if(data=="1"){
                            $(obj).attr('title','停用')
                            $(obj).find('i').html('&#xe601;');

                            $(obj).parents("tr").find(".td-status").find('span').removeClass('layui-btn-mini').html('已启用');
                            layer.msg('已启用!',{icon: 1,time:1000});
                        }
                    }
                });
            }

        });
    }

    /*用户-删除至回收站*/
    function member_del(obj,id){
        layer.confirm('确认要删除到回收站吗？',function(index){
            $.ajax({
                url : "notice/noticeDel?id="+id,
                dataType:'json',
                success : function(data) {
                    if(data="1"){
                        //发异步删除数据
                        $(obj).parents("tr").remove();
                        layer.msg('已移除!',{icon:1,time:1000});
                    }
                }
            });
        });
    }



    function delAll (argument) {
        var ids = [];

        // 获取选中的id
        $('tbody input').each(function(index, el) {
            if($(this).prop('checked')){
                ids.push($(this).val())
            }
        });
        if (""!=ids.toString()){
            layer.confirm('确认要全部删除到回收站吗？'+ids.toString(),function(index){
                $.ajax({
                    url : "notice/noticeDel?id="+ids.toString(),
                    dataType:'json',
                    success : function(data) {
                        if(data="1"){
                            //捉到所有被选中的，发异步进行删除
                            layer.msg('删除成功', {icon: 1});
                            $(".layui-form-checked").not('.header').parents('tr').remove();
                        }
                    }
                });
            });
        }else{
            layer.msg('请选择!',{icon:5,time:1000});
        }
    }
</script>
</html>