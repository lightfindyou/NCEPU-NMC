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
<%@ page import="java.beans.Statement" %>
<%@ page import="java.sql.DriverManager" %>

<html>
<head>
    <title></title>
</head>
<body>
  <%
      String name=new String(request.getParameter("name").getBytes("ISO8859-1"),"UTF-8");
//      String name=request.getParameter("name");
//      String name="梁仟";
      System.out.println(name);
      Class.forName("com.mysql.jdbc.Driver");
      String url="jdbc:mysql://127.0.0.1:3306/nmcTracker";
      Connection connection;
      java.sql.Statement statement;
      connection= DriverManager.getConnection(url,"root","*****");
      statement=  connection.createStatement();
      String insertSql="INSERT INTO registration(memberName, firstRegist) VALUES(" + "'" + name + "',"+ "now()" + ");";
      statement.executeUpdate(insertSql);
      connection.close();




  %>
  <h2>签到成功，请返回</h2>
  <a href="index.jsp">
      <input type="button" value="返回">
  </a>

<%--<jsp:forward page="index.jsp">--%>
</body>
</html>
