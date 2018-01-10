<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2018-01-09
  Time: 0:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%
    String userName=request.getParameter("username");
    String password=request.getParameter("password");
//    System.out.println(userName);
//    System.out.println(password);
    if(userName==""&&userName==null&&password==""&&password==null)
    {
%>
<script language="javascript">
    alert("请输入用户名密码！！！");
    history.back();
</script>
<%  }
    else{
    try{
        Class.forName("com.hxtt.sql.access.AccessDriver"); //JDBC-ODBC桥接器
        System.out.println("驱动已加载");
        try {
            String absPath=new java.io.File(application.getRealPath(request.getRequestURI())).getParent();
            absPath=new java.io.File(absPath).getParent();
            absPath=absPath.replace("\\","/")+"/database/orderMgr.mdb";
            //System.out.println(absPath);

            Connection con = DriverManager.getConnection("jdbc:Access:///"+absPath, "", "");
            if (!con.isClosed()) {
                System.out.println("数据库连接成功!");
                Statement stat = con.createStatement();
                String sql = "select * from userInfo where userAccount='"+userName+"' and passWord='"+password+"'";
                ResultSet rs = stat.executeQuery(sql);
                if(rs.next())
                {
                    String account=rs.getString("userAccount");
                    String name=rs.getString("userName");
                    String nId=rs.getString("ID");
                    String uType=rs.getString("userType");
//                    System.out.println(name);
//                    System.out.println(nId);
                    session.setAttribute("account",account);
                    session.setAttribute("name",name);
                    session.setAttribute("ID",name);
                    session.setAttribute("type",uType);
                    String pageName="index";

                    if(uType.equals("1")){
                        pageName="user";
                    }
                    else if(uType.equals("3")){
                    pageName="consign";
                    }
%>
<script language="javascript">
    window.location.href="<%=pageName%>.jsp";
</script>
<%
                }
                else
                {
%>
<script language="javascript">
    alert("登录失败！！！");
    history.back();
</script>
<%
                    }
            } else {
                System.out.println("数据库连接失败!");
            }
        }catch(Exception ee)
        {System.out.println("数据库连接异常!");}
    }
    catch(ClassNotFoundException e) {
        System.out.print(e+"     驱动加载失败");
    }
    }
%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
