<%--
  Created by IntelliJ IDEA.
  User: Leong
  Date: 2015/10/18
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page pageEncoding="UTF-8" %>
<html>
<head>
    <title></title>
</head>
<body>
  <%
      Class.forName("com.mysql.jdbc.Driver");
      String url="jdbc:mysql://127.0.0.1:3306/nmcTracker";
      Connection connection;
      java.sql.Statement statement;
      connection= DriverManager.getConnection(url,"root","******");
      statement=  connection.createStatement();


    request.setCharacterEncoding("UTF-8");
//    String[] name=new String(request.getParameterValues("name"))
    String[] name=request.getParameterValues("name");
    for (int i=0;i<name.length;i++){
        String temp  = new String(name[i].getBytes("ISO8859-1"),"UTF-8");
      System.out.println(temp);
        String insertSql="UPDATE nmctracker.registration SET lastRegist=now() WHERE memberName='"+temp+"' AND lastRegist is NULL;";
        statement.executeUpdate(insertSql);
    }
    System.out.println(name.length);
      connection.close();
  %>
</body>
</html>
