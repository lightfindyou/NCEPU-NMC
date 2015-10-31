<%--
  Created by IntelliJ IDEA.
  User: Leong
  Date: 2015/10/18
  Time: 1:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" errorPage="index.jsp" %>
<%@ page import="java.sql.*,java.util.*,java.lang.*" %>
<%@ page pageEncoding="UTF-8" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    String url="jdbc:mysql://*****:3306/nmctracker?useUnicode=true&characterEncoding=UTF-8";
    Connection con;
    ResultSet resultset;
    Statement stmt;
    List apartment=new ArrayList();
    con=DriverManager.getConnection(url,"root","******");
    stmt=con.createStatement();
    resultset=stmt.executeQuery("select distinct department from nmctracker.member order by department; ");
    while(resultset.next()){
        apartment.add(resultset.getString(1));
    }
    ResultSet resultSetOfMemberName=stmt.executeQuery("SELECT memberName FROM member");
%>
<html>
<head>
    <title>日常</title>
    <meta http-equiv="content-type" content="text/html;charset=UTF-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <link rel="stylesheet" href="css/reset.css" />
    <link rel="stylesheet" href="css/style.css" />
    <script src="js/jquery-1.9.1.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/alert.js"></script>




    <%
        String status= (String) session.getAttribute("status");
        System.out.println(status);
        session.invalidate();
    %>

    <%--<%--%>

    <%--//      String status= (String) session.getAttribute("status");--%>
    <%--//      session.invalidate();--%>
    <%--//      System.out.println("status:"+status);--%>
    <%--//      System.out.println(status.equals(new String ("true")));--%>

    <%--if (status.equals(new String ("true"))){%>--%>
    <%--<script type="text/javascript">--%>
    <%--sucess();--%>
    <%--</script>--%>
    <%--<%}--%>
    <%--else if (status.equals(new String ("false"))) {%>--%>
    <%--<script type="text/javascript">--%>
    <%--fail();--%>
    <%--</script>--%>
    <%--<%}--%>
    <%--%>--%>
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
            document.forms["form1"].action="sublmitRegistion.jsp";
            document.form1.submit();
        }
        function mySubmit2 () {
            document.forms["form2"].action="EndDuty.jsp";
            document.form2.submit();
        }
    </script>
    <script>
        $(function() {
            var availableTags = [
                <%
                  while (resultSetOfMemberName.next()){
                    out.println("\""+resultSetOfMemberName.getString(1)+"\""+",");
                  }
                  out.println("\""+"TEST"+"\"");
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
            <li><a href="">未完成事项</a></li>

            <li><a href="jilu.jsp">新问题记录</a></li>
            <li><a href="">问题总览</a></li>
        </ul>
    </div>
    <div class="left_bottom">
        <ul>
            <li><a href="">关于</a></li>
        </ul>
    </div>
</div>
<div class="right">
    <div class="right_1">
        <form name="form1" method="get">
            <ul>
                <li class="ui-widget">姓名&nbsp;:&nbsp;<input type="" name="name" id="tags" style="width:150px;" />
                </li>

                <%
                    if (status==null){
                        status="";
                    }
                %>

                <li><p style="text-decoration-color: bisque"><%=status%></p>
                </li>

                </select>
                <li><div class="right_1_button"><a href="javascript:mySubmit1 ()">开始值班</a></div></li>
            </ul>
        </form>
    </div>

    <%
        String sqlqueryOnDuty="SELECT * FROM nmctracker.registration where lastRegist is null limit 9;";
        ResultSet resultSet =stmt.executeQuery(sqlqueryOnDuty);
        List list=new ArrayList();
        while (resultSet.next()){
            list.add(resultSet.getString(2));
        }
        while (list.size()!=12){
            list.add("***");
        }
    %>

    <div class="right_2">
        <div class="right_2_1">
            <ul><li>正在值班&nbsp;:&nbsp;</li></ul><li></li><li></li></div>
        <div class="right_2_2">
            <form name="form2" action="">

                <%
                    for (int i=0;i<4;i++){%>
                <ul>
                    <%for (int j=0;j<3;j++){%>

                    <li>
                        <input type='checkbox' name="name" value="<%=list.get(i*3+j)%>">
                        <%=list.get(i*3+j)%>
                    </li>
                    <%}%>
                    <li></li>
                </ul>
                <%}
                %>


                <div class="right_2_button"><a href="javascript:mySubmit2 ()" >结束值班</a></div>
            </form>
        </div>
        <div class="right_2_3"><ul><li></li><li></li><li></li></ul></div>
    </div>
    <div class="right_3">
        <div class="right_3_1">
            <ul><li>最近值班&nbsp;:&nbsp;</li></ul>
            <li></li><li><a href="index.jsp">上一页</a>&nbsp;&nbsp;<a href="index.jsp">下一页</a></li>
        </div>

        <%
            String sqlQueryDuty="select member.department,registration.memberName,registration.firstRegist,registration.lastRegist from member,registration\n" +
                    "where member.memberName=registration.memberName AND lastRegist is NOT null ORDER BY registraionId DESC LIMIT 9";
            ResultSet res=stmt.executeQuery(sqlQueryDuty);
        %>

        <div class="right_3_2">
            <ul><li>所在部门</li><li>姓名</li><li>开始时间</li><li>结束时间</li></ul>
            <%
                while(res.next()){
                    out.println("<ul><li>"+res.getString(1)+"</li><li>"+res.getString(2)+"</li><li>"+res.getString(3)+"</li><li>"+res.getString(4)+"</li></ul>");
                }
                con.close();
            %>
        </div>
        <div class="right_3_3">
            <ul><li></li><li></li></ul>
        </div>
    </div>
</div>
</body>
</html>
