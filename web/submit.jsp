<%--
  Created by IntelliJ IDEA.
  User: Howard
  Date: 11/24/2015
  Time: 11:42
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
    ResultSet resultSetContain;
    ResultSet resultSetOnline;

    String submitName;

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

        submitName=new String(request.getParameter("submitName").getBytes("ISO8859-1"),"UTF-8");

        resultSetContain = statement.executeQuery("SELECT memberName FROM member WHERE memberName='"+submitName+"'");

        if (!resultSetContain.next())
            out.print("<script>alert('输入的姓名不在数据库中');location.href='index.jsp';</script>");
        else {
            resultSetOnline = statement.executeQuery("SELECT memberName FROM online WHERE memberName='"+submitName+"'");
            if (resultSetOnline.next())
                out.print("<script>alert('您已经签到');location.href='index.jsp';</script>");
            else {
                statement.executeUpdate("INSERT INTO registration(memberName, firstRegist) VALUES('" + submitName + "',"+ "now()" + ");");
                out.print("<script>alert('签到成功');location.href='index.jsp';</script>");
            }
        }

        conn.close();

    }catch (Exception e){
        out.print("<script>alert('提交失败');location.href='index.jsp';</script>");

    }

%>
<h1></h1>
</body>
</html>
