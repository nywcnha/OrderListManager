<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2018-01-07
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    session.removeAttribute("account");
    session.removeAttribute("type");
    session.removeAttribute("name");
    session.removeAttribute("ID");
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>订单管理登录</title>
    <link rel="stylesheet" href="css/amazeui.css" />
    <link rel="stylesheet" href="css/other.min.css" />
</head>
<body class="login-container">
<div class="login-box">
    <div class="logo-img">
        <img src="images/loge.jpg" alt="" />
    </div>
    <form action="loginPost.jsp" class="am-form"   id="ue-form">
        <div class="am-form-group">
            <label for="doc-username"><i class="am-icon-user"></i></label>
            <input type="text" name="username" id="doc-username" minlength="3" placeholder="输入用户名" required />
        </div>

        <div class="am-form-group">
            <label for="doc-pword"><i class="am-icon-key"></i></label>
            <input type="password" name="password" id="doc-pword" placeholder="输入密码" required/>
        </div>
        <button class="am-btn am-btn-secondary"  type="submit">登录</button>
    </form>
</div>
</body>
</html>

