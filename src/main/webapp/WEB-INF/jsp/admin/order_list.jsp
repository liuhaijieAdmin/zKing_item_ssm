<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/5/5
  Time: 12:51
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
</head>
<body>
<div class="x-nav">
            <span class="layui-breadcrumb">
                <a href="">首页</a>
                <a href="">订单管理</a>
                <a>
                    <cite>订单列表</cite></a>
            </span>
    <a class="layui-btn layui-btn-small" style="line-height:1.6em;margin-top:3px;float:right" onclick="location.reload()" title="刷新">
        <i class="layui-icon layui-icon-refresh" style="line-height:30px"></i>
    </a>
</div>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md12">
            <div class="layui-card">
                <div class="layui-card-body ">
                    <form class="layui-form" action="/express/expressList" method="post" >
                        <div class="layui-input-inline layui-show-xs-block">
                            <input class="layui-input" placeholder="开始日" name="dateOne" id="start"></div>
                        <div class="layui-input-inline layui-show-xs-block">
                            <input class="layui-input" placeholder="截止日" name="dateTwo" id="end"></div>
                        <%--<div class="layui-input-inline layui-show-xs-block">--%>
                            <%--<select name="contrller">--%>
                                <%--<option>支付方式</option>--%>
                                <%--<option>支付宝</option>--%>
                                <%--<option>微信</option>vvv--%>
                                <%--<option>货到付款</option></select>--%>
                        <%--</div>--%>
                        <div class="layui-input-inline layui-show-xs-block">
                            <select name="esid">
                                <option value="">订单状态</option>
                                <option value="1">等待物流公司确认</option>
                                <option value="2">等待物流公司揽件</option>
                                <option value="3">快递运输中</option>
                                <option value="4">等待收件人签收</option>
                                <option value="5">收件人已签收</option>
                                </select>
                        </div>
                        <div class="layui-input-inline layui-show-xs-block" >
                            <input type="text" value="${orderId}" name="orderid" placeholder="请输入订单号" autocomplete="off" class="layui-input"></div>
                        <div class="layui-input-inline layui-show-xs-block">
                            <button onsubmit="" class="layui-btn" lay-submit="" lay-filter="sreach">
                                <i class="layui-icon">&#xe615;</i></button>
                        </div>
                    </form>
                </div>
                <div class="layui-card-header">
                    <button class="layui-btn layui-btn-danger" onclick="delAll()">
                        <i class="layui-icon"></i>批量删除</button>
                    <button class="layui-btn" onclick="xadmin.open('添加用户','./order-add.html',800,600)">
                        <i class="layui-icon"></i>添加</button></div>
                <div class="layui-card-body ">
                    <table class="layui-table layui-form">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" lay-filter="checkall" lay-skin="primary">
                            </th>
                            <th>订单编号</th>
                            <th>快递名称</th>
                            <th>下单账号</th>
                            <th>付款金额</th>
                            <th>发货时间</th>
                            <th>订单状态</th>
                            <th>快递当前位置</th>
                            <th>备注</th>
                            <th>操作</th></tr>
                        </thead>
                        <tbody>
                        <c:forEach var="i" items="${expressList}">
                        <tr>
                            <td>
                                <input type="checkbox" name="id" value="${i.eid}" lay-skin="primary"></td>
                            <td>${i.orderid}</td>
                            <td>${i.ordername}</td>
                            <td>${i.user.uaccount}</td>
                            <td>${i.orderprice}</td>
                            <td><fmt:formatDate value="${i.shippertime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                            <td>${i.expressStatus.esname}</td>
                            <td>${i.orderaddress}</td>
                            <td>${i.orderremark}</td>
                            <td class="td-manage">
                                <a title="查看取件人" onclick="xadmin.open('查看取件人','${ctx}/express/expressGet?name=${i.eid},1',350,250)" href="javascript:;">
                                    <i class="layui-icon">&#xe63c;</i></a>
                                <a title="查看发件人" onclick="xadmin.open('查看发件人','${ctx}/express/expressGet?name=${i.eid},2',350,250)" href="javascript:;">
                                    <i class="layui-icon">&#xe63c;</i></a>
                                <a title="删除" id="${i.eid}" onclick="member_del(this,this.id)" href="javascript:;">
                                    <i class="layui-icon">&#xe640;</i></a>
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
<script src="${ctx}/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${ctx}/js/xadmin.js"></script>
<script>layui.use(['laydate', 'form'],
    function() {
        var laydate = layui.laydate;
        var  form = layui.form;
        //执行一个laydate实例
        laydate.render({
            elem: '#start' //指定元素
        });

        //执行一个laydate实例
        laydate.render({
            elem: '#end' //指定元素
        });

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

/*用户-删除*/
function member_del(obj, id) {
    layer.confirm('确认要删除吗？',
        function() {
            $.ajax({
                url : "express/expressDel?id="+id,
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
        layer.confirm('确认要把所勾选的删除吗？'+ids.toString(),function(index){
            $.ajax({
                url : "express/expressDel?id="+ids.toString(),
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
