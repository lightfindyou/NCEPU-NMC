<%--
  Created by IntelliJ IDEA.
  User: Leong
  Date: 2015/10/18
  Time: 1:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.*,java.sql.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>

<html>
<head>
    <title></title>
</head>
<body>
<%
    String  name=new String(request.getParameter("name").getBytes("ISO8859-1"),"UTF-8");
    Class.forName("com.mysql.jdbc.Driver");
    String url="jdbc:mysql://********:3306/nmcTracker";
    Connection connection;
    java.sql.Statement statement;
    connection= DriverManager.getConnection(url,"root","****");
    statement=  connection.createStatement();
    String inputName=null;
    String status="签到失败,核对姓名/联系管理员";
    String forwardUrl="index.jsp";

    String contain=null,online=null;
    //查询是否存在该用户
    ResultSet resultSetContain=statement.executeQuery("SELECT memberName FROM member WHERE memberName='"+name+"'");
    while (resultSetContain.next()){
        contain=resultSetContain.getString(1);
    }
    resultSetContain.close();

    //onduty
    ResultSet resultSetOnline=statement.executeQuery("SELECT online.memberName FROM online WHERE memberName='"+name+"'");
    while (resultSetOnline.next()){
        online=resultSetOnline.getString(1);
    }
    resultSetOnline.close();

    if (name.equals(contain)){
        status="你已经在值班";
        if (!name.equals(online)){
            status="签到成功，开始值班";
            String insertSql="INSERT INTO registration(memberName, firstRegist) VALUES(" + "'" + name + "',"+ "now()" + ");";
//            statement.executeUpdate(insertSql);
        }
    }
    session.setAttribute("status",status);
    connection.close();
    response.sendRedirect(forwardUrl);


%>

</body>
</html>