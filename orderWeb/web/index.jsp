<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2018-01-07
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*"%>
<%@ page import="org.json.*"%>
<html>
<head>
  <meta charset="utf-8">
  <meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <title>订单管理小系统</title>
  <link rel="stylesheet" href="js/layui/css/layui.css">
</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
  <div class="layui-header">
    <div class="layui-logo">订单管理小系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <%
      if(session.getAttribute("account")==null){
    %>
    <script language="javascript">
        window.location.href="login.jsp";
    </script>
    <%
        return;
      }
      String userType =session.getAttribute("type").toString();
      String userName =session.getAttribute("name").toString();


    out.println(" <ul class=\"layui-nav layui-layout-left\">");
      if(userType.equals("2")) {
        out.println("<li class=\"layui-nav-item layui-this\"><a href=\"index.jsp\">订单管理</a></li>");
      }
      else  if(userType.equals("3"))
        out.println(" <li class=\"layui-nav-item \"><a href=\"consign.jsp\">发货管理</a></li>");
      else  if(userType.equals("1"))
        out.println("<li class=\"layui-nav-item\"><a href=\"user.jsp\">用户管理</a></li>");
      out.println(" </ul>");
    %>

    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="images/title_img.jpg" class="layui-nav-img">
          <%=userName%>
        </a>
      </li>
      <li class="layui-nav-item"><a href="login.jsp">退出</a></li>
    </ul>
  </div>

  <div class="layui-body">
<div>
    <blockquote class="layui-elem-quote mylog-info-tit">
      <div class="layui-inline">
        <form class="layui-form" id="userSearchForm">
          <div class="layui-input-inline" style="width:110px;">
            <select name="searchTerm" >
              <option value=""></option>
              <option value="userName" selected>收货人</option>
              <option value="userName">经手人</option>
              <option value="userName" >订单号</option>
              <option value="userName">物流公司</option>
              <option value="userName">物流单号</option>
            </select>
          </div>
          <div class="layui-input-inline" style="width:145px;">
            <input type="text" name="searchContent" value="" placeholder="请输入关键字" class="layui-input search_input">
          </div>
          <div class="layui-inline">
            <label class="layui-form-label">下单日期</label>
            <div class="layui-input-inline">
              <input type="text" class="layui-input" id="date_day" placeholder="yyyy-MM-dd">
            </div>
          </div>
        </form>
      </div>
      <div class="layui-inline">
        <button class="layui-btn" data-type="addOrder"><i class="layui-icon">&#xe615;</i>查询</button>
        <button class="layui-btn" data-type="addOrder"><i class="layui-icon">&#xe615;</i>月查询</button>
        <%--<button class="layui-btn" lay-filter="formDemo"><i class="layui-icon">&#xe621;</i>导出</button>--%>
        <button class="layui-btn" data-type="addOrder"><i class="layui-icon">&#xe608;</i> 添加订单</button>
      </div>
    </blockquote>
</div>
    <table lay-filter="user" id="user_table" class="table_margin"></table>
    <script type="text/html" id="bar">
      <a class="layui-btn layui-btn-xs" lay-event="detail">编辑</a>
      <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
      <a class="layui-btn layui-btn-xs" lay-event="print">打印</a>
    </script>
  </div>

  <div class="layui-footer" style="text-align:center;">
    <!-- 底部固定区域 -->
    © orderWebProject

  </div>
</div>
<script src="js/layui/layui.js"></script>
<script>
    //JavaScript代码区域
    layui.use(['form', 'layedit', 'element', 'table','laydate', 'laypage', 'layer'], function(){
        var form = layui.form;
        var table = layui.table;
        var laypage = layui.laypage;
        var laydate = layui.laydate;
        var element = layui.element;
        var layer = layui.layer;

        laydate.render({
            elem: '#date_day'
        });
        var nCount=0;
        //执行一个 table 实例
        table.render({
            elem: '#user_table'
            ,height: 500
            ,url: 'indexPost.jsp?opera=get' //数据接口
            ,page: true //开启分页
            ,cols: [[ //表头
                {field: 'orderCode', title: '订单编号', width:120, sort: true, fixed: 'left'}
                ,{field: 'shrName', title: '收货人', width:100, fixed: 'left'}
                ,{field: 'shrPhone', title: '联系电话', width:120, fixed: 'left'}
                ,{field: 'shrAddress', title: '收货人地址', width:150, fixed: 'left'}
                ,{field: 'payMethod', title: '结算方式', width: 120, fixed: 'left'}
                ,{field: 'handlers', title: '经手人', width: 120, sort: true, fixed: 'left'}
                ,{field: 'shipList', title: '发货清单', width: 300}
                ,{field: 'consignor', title: '发货人', width: 80}
                ,{field: 'consignUnit', title: '发货单位', width: 120}
                ,{field: 'orderTime', title: '下单时间', width: 135}
                ,{field: 'consignTime', title: '发货时间', width: 135}
                ,{field: 'logisNumber', title: '物流单号', width: 135}
                ,{field: 'logisUnit', title: '物流公司', width: 135}
                ,{field: 'remark', title: '备注', width: 135}
                ,{fixed: 'right', width: 165, align:'center', toolbar: '#bar'}
            ]]
            ,limits: [10, 20, 30,50]
            ,limit: 10 //每页默认显示的数量
            ,method:"post"
            ,where:{"orderTime":"ssss"}
        });

        //监听工具条
        table.on('tool(demo)', function(obj){ //注：tool是工具条事件名，test是table原始容器的属性 lay-filter="对应的值"
            var data = obj.data //获得当前行数据
                ,layEvent = obj.event; //获得 lay-event 对应的值
            if(layEvent === 'detail'){
                layer.msg('查看操作');
            } else if(layEvent === 'del'){
                layer.confirm('真的删除行么', function(index){
                    obj.del(); //删除对应行（tr）的DOM结构
                    layer.close(index);
                    //向服务端发送删除指令
                });
            } else if(layEvent === 'edit'){
                layer.msg('编辑操作');
            }
        });


    });
</script>
</body>
</html>
