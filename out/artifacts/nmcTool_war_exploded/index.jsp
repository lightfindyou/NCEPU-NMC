<%--
  Created by IntelliJ IDEA.
  User: Leong
  Date: 2015/10/18
  Time: 1:02

  Updated by Howard.
  Date: 2015/12/07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>

<%!
    Connection conn;
    Statement statement;
    ResultSet resultSetForAll;

    String url = "jdbc:mysql://59.67.225.80:3306/nmctracker";
    String username = "root";
    String password = "wgxh5197";
%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);

        statement = conn.createStatement();
    }catch (Exception e){
        out.print("<script>alert('连接服务器失败');</script>");
    }
%>

<html>
<head>
    <title>日常</title>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <link rel="stylesheet" href="css/reset.css" />
    <link rel="stylesheet" href="css/style.css" />
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/other.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script type="text/javascript"></script>

    <script type="text/javascript">
        var winWidth = 0;
        var winHeight = 0;
        function findDimensions() //函数：获取页面尺寸
        {
            //获取窗口宽度
            if (window.innerWidth)
                winWidth = window.innerWidth;
            else if ((document.body) && (document.body.clientWidth))
                winWidth = document.body.clientWidth;
            //获取窗口高度
            if (window.innerHeight)
                winHeight = window.innerHeight;
            else if ((document.body) && (document.body.clientHeight))
                winHeight = document.body.clientHeight;

            //通过深入Document内部对body进行检测，获取窗口大小
            if (document.documentElement  && document.documentElement.clientHeight &&
                    document.documentElement.clientWidth)
            {
                winHeight = document.documentElement.clientHeight;
                winWidth = document.documentElement.clientWidth;
            }
            //在这里写你的处理函数，winWidth和winHeight这两个全局变量分别是页面宽度和高度

        }
        findDimensions();                  //调用函数，获取数值
        window.onresize=findDimensions;    //绑定窗口尺寸改变事件
    </script>
    <script type="text/javascript">
        function mySubmit1 () {
            document.forms["form1"].action="submit.jsp";
            document.form1.submit();
        }
        function mySubmit2 () {
            document.forms["form2"].action="endDuty.jsp";
            document.form2.submit();
        }
    </script>
    <script>
        $(function() {
            var availableTags = [
                <%
                try{
                    resultSetForAll = statement.executeQuery("SELECT memberName FROM member");
                    while (resultSetForAll.next()){
                %>
                <%="\""+ resultSetForAll.getObject(1).toString() + "\"" + ","%>
                <%
                  }
                }catch (Exception e){
                    out.print("<script>alert('拉取 availableTags 失败');</script>");
                }
                %>
            ];
            $( "#tags" ).autocomplete({
                source: availableTags
            });
        });
    </script>
</head>

<body>
<div class="head">
    <img src="images/logo.png" alt="" />
    <img src="images/text.png" alt="" />
</div>
<div class="left" id="left">
    <div class="left_list">
        <ul>
            <li><a href="index.jsp">签到</a></li>
            <%--<li><a href="">未完成事项</a></li>--%>

            <li><a href="jilu.html">新问题记录</a></li>
            <%--<li><a href="">问题总览</a></li> --%>
        </ul>
    </div>
    <div class="left_bottom">
        <ul>
            <!-- <li><a href="">关于</a></li> -->
        </ul>
    </div>
</div>

<div class="right">
    <div class="right_1">
        <form name="form1" method="post">
            <ul>
                <li class="ui-widget">姓名&nbsp;:&nbsp;<input type="" name="submitName" id="tags"  style="width:150px;" />
                <li></li>
                <li><div class="right_1_button"><a href="javascript:mySubmit1 ()">开始值班</a></div></li>
            </ul>
        </form>
    </div>

    <%!
        ResultSet resultSetOnline ;
        ArrayList<String> online;
        int size;
        int rollNum;
        int rowNum;
    %>
    
    <%
        try{
            resultSetOnline = statement.executeQuery("SELECT * FROM online");
            online = new ArrayList<String>();
            
            while (resultSetOnline.next())
                online.add(resultSetOnline.getObject(1).toString());

            size = online.size();
            rollNum = size/3;
            rowNum = size%3;
        }catch (Exception e){
            out.print("<script>alert('拉取正在值班失败');</script>");
        }

    %>

    <div class="right_2">
        <div class="right_2_1">
            <ul><li>正在值班&nbsp;:&nbsp;</li></ul><li></li><li></li></div>
        <div class="right_2_2">
            <form name="form2" method="post">

                <%
                    if (size == 0){
                %>
                <li>暂无</li><li></li><li></li><li></li>
                <%
                }else {
                    for (int i = 0; i < rollNum; i++){
                %>
                <ul>
                    <%for (int j = 0; j < 3; j++){%>
                    <li><input type='checkbox' name='endName' value=<%=online.get(i*3+j)%>><%=online.get(i*3+j)%></li>
                    <%}%>
                    <li></li>
                </ul>
                <%
                    }
                    for (int i = 0; i < rowNum; i++){
                %>
                <ul>
                    <li><input type='checkbox' name='endName' value=<%=online.get(size-rowNum+i)%>><%=online.get(size-rowNum+i)%></li>
                    <%
                        };
                        for (int j = 0; j < 4-rowNum; j++){
                    %>
                    <li></li>
                    <%}%>
                </ul>

                <div class="right_2_button"><a href="javascript:mySubmit2 ()" >结束值班</a></div>
                <%}%>
            </form>
        </div>    </div>

    <div class="right_3">
        <div class="right_3_1">
            <ul><li>最近值班&nbsp;:&nbsp;</li></ul>
            <li></li><li><a href=""> </a>&nbsp;&nbsp;<a href=""> </a></li>
        </div>

        <div class="right_3_2">
            <ul><li>所在部门</li><li>姓名</li><li>开始时间</li><li>结束时间</li></ul>

            <%!
                ResultSet resultSetHistory;
                String par2 = "MM-dd HH:mm";
                SimpleDateFormat sdf2 = new SimpleDateFormat(par2);
            %>
            <%
                try {
                    resultSetHistory = statement.executeQuery(
                            "SELECT department, member.memberName, firstRegist, lastRegist " +
                                    "FROM member, registration " +
                                    "WHERE member.memberName=registration.memberName " +
                                    "AND lastRegist is NOT null " +
                                    "ORDER BY registraionId DESC LIMIT 9");
                    while (resultSetHistory.next()){
            %>
            <ul><li><%=resultSetHistory.getString(1)%></li><li><%=resultSetHistory.getString(2)%></li><li><%=sdf2.format(resultSetHistory.getObject(3))%></li><li><%=sdf2.format(resultSetHistory.getObject(4))%></li></ul>
            <%
                    }
                } catch (Exception e) {
                        out.print("<script>alert('拉取最近值班失败');</script>");
                    }

            %>

        </div>
        <div class="right_3_3">
            <ul><li></li><li></li></ul>
        </div>
    </div>
</div>
</body>
</html>
