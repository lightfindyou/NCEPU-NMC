<%--
  Created by IntelliJ IDEA.
  User: Howard
  Date: 12/05/2015
  Time: 15:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title></title>
</head>
<body>

<%!
    Connection conn;
    Statement statement;

    String url = "jdbc:mysql://59.67.225.80:3306/nmctracker";
    String username = "root";
    String password = "wgxh5197";
%>

<%
        response.setCharacterEncoding("utf-8");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            statement = conn.createStatement();

            String[] name = request.getParameterValues("endName");
            
              for (String i:name) {
                String temp = new String(i.getBytes("ISO8859-1"), "UTF-8");

                statement.executeUpdate("UPDATE nmctracker.registration SET lastRegist=now() WHERE memberName='" + temp + "'");
              } 
              out.print("<script>alert('结束值班成功');location.href='index.jsp';</script>");
            
            conn.close();
          }catch (Exception e){
                        out.print("<script>alert('结束值班失败');location.href='index.jsp';</script>");

        }
%>
</body>
</html>
