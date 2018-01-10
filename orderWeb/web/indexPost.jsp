<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2018-01-09
  Time: 0:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.json.*"%>
<%
    if(session.getAttribute("account")==null){
%>
<script language="javascript">
    window.location.href="login.jsp";
</script>
<%
        return;
    }
    String operaStr=request.getParameter("opera");
    String resCount=request.getParameter("count");
    String pageNum=request.getParameter("page");
    String limits=request.getParameter("limit");
     System.out.println("resCount:"+resCount+"    pageNum:"+pageNum+"    limits:"+limits);
    String absPath=new java.io.File(application.getRealPath(request.getRequestURI())).getParent();
    absPath=new java.io.File(absPath).getParent();

    if(operaStr.equals("get")) {
        response.setContentType("text/json; charset=UTF-8");
        PrintWriter outStr=response.getWriter();
//        select top 50 * from pagetest//9900  分页数*每页行数
//        where id>(select max(id) from (select top 9900 id from pagetest order by id)a)
//        order by id
        ResultSet rst =getQueryResult("select * from orderList ",absPath);
        String dataResult=resultGetToJson(rst);
        if(dataResult.equals(""))
            outStr.println("{\"code\":\"0001\",\"msg\":\"未找到数据！\",\"count\":0,\"data\":[]");
        else
            outStr.println("{\"code\":\"0000\",\"msg\":\"获取成功！！ \",\"count\":"+getResultCount(rst)+",\"data\":" + dataResult +"}");
        return;

        //JSONArray array = new JSONArray();
    }
    else if(operaStr.equals("add")) {

    }
    else if(operaStr.equals("update")) {

    }
    else if(operaStr.equals("del")) {

    }
%>
<%!
    ResultSet getQueryResult(String strSql,String dbPath)throws SQLException {
        ResultSet rs = null;
        try {
            Class.forName("com.hxtt.sql.access.AccessDriver"); //JDBC-ODBC桥接器
            System.out.println("驱动已加载");
            try {
                dbPath = dbPath.replace("\\", "/") + "/database/orderMgr.mdb";
                Connection con = DriverManager.getConnection("jdbc:Access:///" + dbPath, "", "");
                if (!con.isClosed()) {
                    System.out.println("数据库连接成功!");
                    Statement stat = con.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);

                    rs = stat.executeQuery(strSql);
                } else {
                    System.out.println("数据库连接失败!");
                    return null;
                }
            } catch (Exception ee) {
                System.out.println("数据库连接异常!");
                return null;
            }
        } catch (ClassNotFoundException e) {
            System.out.print(e + "     驱动加载失败");
            return null;
        }
        return rs;
    }
    String getResultCount(ResultSet rst)throws SQLException
    {
        rst.last();//移到最后一行
        int count = rst.getRow();
        rst.beforeFirst();//移到初始位置
        return Integer.toString(count);
    }
    String resultGetToJson(ResultSet rs) throws SQLException,JSONException {
        JSONArray array = new JSONArray();

/*888888888888888888888888888888888888888888888888888888888888888888888888888888888*/
        try {
            // 获取列数
            ResultSetMetaData metaData = rs.getMetaData();
            int columnCount = metaData.getColumnCount();

            // 遍历ResultSet中的每条数据
            while (rs.next()) {
                JSONObject jsonObj = new JSONObject();

                // 遍历每一列
                for (int i = 1; i <= columnCount; i++) {
                    String columnName = metaData.getColumnLabel(i);
                    String value = rs.getString(columnName);
                    jsonObj.put(columnName, value);
                }

                array.put(jsonObj);
            }
        } catch (Exception ee) {
            System.out.print(ee + "     查询结果转JSON失败");
        }
/*888888888888888888888888888888888888888888888888888888888888888888888888888888888*/

        return array.toString();
    }

%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
