<%@page import="com.sun.java.accessibility.util.AccessibilityListenerList"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*,java.text.*,model.*,control.*" %>
<% 
	String[] minister = connDB.getMinister(); 
    String[] lastTwe = null;
    lastTwe = connDB.getLastTwe();
    int num = lastTwe.length;
    ArrayList<String[]> lastNine = new ArrayList<String[]>();
    lastNine = connDB.getLastNine();
    ArrayList<HashMap<String,String>> notsolved = connDB.getnotsolved();
	int sum = connDB.getRecNum();
	int pagecount = sum%10==0?sum/10:sum/10+1;
    ArrayList<HashMap<String,String>> allRec = (ArrayList<HashMap<String,String>>)request.getAttribute("all");
    if(allRec==null){
    	allRec = connDB.getAllRec(sum-10,sum);
    }
    int pageNow = (request.getAttribute("pageNow")==null)?1:(int)request.getAttribute("pageNow");
    
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>NMC</title>
    <link rel="stylesheet" type="text/css" href="css/index.css">
</head>
 
<body>
    <!-- logo和导航栏 -->
    <div class="title">
        <!-- logo -->
        <div class="title-logo">
            <img src="pictures/logo.png" alt="网管协会">
        </div>
        <!-- 导航栏 -->
        <div class="title-nav">
            <a href="#scroll-tab-1" class="title-nav_a title-nav_a_add" onclick="nav_add(0)">签到</a>
            <a href="#scroll-tab-2" class="title-nav_a" onclick="nav_add(1)">问题记录</a>
            <a href="#scroll-tab-3" class="title-nav_a" onclick="nav_add(2)" id="DaiBan">待办事项<em><%=notsolved.size() %></em></a>
            <a href="#scroll-tab-4" class="title-nav_a" onclick="nav_add(3)">问题总览</a>
        </div>
    </div>
    <main class="content">
        <!-- 主体部分 -->
        <section id="scroll-tab-1" class="tab tab-first">
            <div>
            	<form action="/NMC/hd?event=start" method="post">
            		<table class="table-hover table-shape table-text" id="table_1">
                    <thead></thead>
                    <tbody class="tbody-td">
                        <tr>
                            <td style="text-align: left;">当前时间 <%=new SimpleDateFormat("yyyy / M / dd").format(Calendar.getInstance().getTime()) %></td>
                            <td id="onwork" style="width:44.9%;">
                                <span>姓名：</span>
                                <label for="onwork-input" id="onwork-input-label" class="onwork-input-label" style="text-align: left;">
                                    输入姓氏可自动补全</label>
                                <input type="text" name="onwork" id="onwork-input">
                            </td>
                            <td class="td-button">
                                <button class="mdl-button mdl-button--fab" type="submit" >开始值班</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            	</form>
            </div>
            <div class="interval">
	            <form action="/NMC/hd?event=end1" method="post">
	                <table class="table-shape table-hover table-text" id="table-2">
	                    <thead>
	                        <tr>
	                            <td>值班部长：</td>
	                        </tr>
	                    </thead>
	                    <tbody class="tbody-td">
	                        <tr>
	                            <td>
	                                <input type="checkbox" name="mem1" value=<%=minister[0] %> ><%=minister[0] %></td>
	                            <td>
	                                <input type="checkbox" name="mem1" value=<%=minister[1] %> ><%=minister[1] %></td>
	                            <td>
	                                <input type="checkbox" name="mem1" value=<%=minister[2] %> ><%=minister[2] %></td>
	                            <td class="td-button">
	                                <button class="mdl-button mdl-button--fab " type="submit">结束值班</button>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	            </form>
            </div>
            <div class="interval">
            	<form action="/NMC/hd?event=end2" method="post">
	                <table class="table-shape table-hover table-text " id="table-3">
	                    <thead>
	                        <tr>
	                            <td>正在值班：</td>
	                        </tr>
	                    </thead>
	                    <tbody class="tbody-td">
	                        <tr>
	                            <td>
	                                <input type=<%= lastTwe[0]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[0]!=null?lastTwe[0]:null %>  ><%=lastTwe[0]!=null?lastTwe[0]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[1]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[1]!=null?lastTwe[1]:null %>  ><%=lastTwe[1]!=null?lastTwe[1]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[2]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[2]!=null?lastTwe[2]:null %>  ><%=lastTwe[2]!=null?lastTwe[2]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[3]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[3]!=null?lastTwe[3]:null %>  ><%=lastTwe[3]!=null?lastTwe[3]:"" %></td>
	                        </tr>
	                        <tr>
	                            <td>
	                                <input type=<%= lastTwe[4]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[4]!=null?lastTwe[4]:null %>  ><%=lastTwe[4]!=null?lastTwe[4]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[5]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[5]!=null?lastTwe[5]:null %>  ><%=lastTwe[5]!=null?lastTwe[5]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[6]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[6]!=null?lastTwe[6]:null %>  ><%=lastTwe[6]!=null?lastTwe[6]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[7]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[7]!=null?lastTwe[7]:null %>  ><%=lastTwe[7]!=null?lastTwe[7]:"" %></td>
	                            
	                        </tr>
	                        <tr>
	                            <td>
	                                <input type=<%= lastTwe[8]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[8]!=null?lastTwe[8]:null %>  ><%=lastTwe[8]!=null?lastTwe[8]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[9]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[9]!=null?lastTwe[9]:null %>  ><%=lastTwe[9]!=null?lastTwe[9]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[10]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[10]!=null?lastTwe[10]:null %>  ><%=lastTwe[10]!=null?lastTwe[10]:"" %></td>
	                            <td>
	                                <input type=<%= lastTwe[11]!=null?"checkbox":"hidden" %> name="mem2" value=<%=lastTwe[11]!=null?lastTwe[11]:null %>  ><%=lastTwe[11]!=null?lastTwe[11]:"" %></td>
	                            
	                        </tr>
	                        <tr>
	                            <td></td>
	                            <td></td>
	                            <td></td>
	                            <td class="td-button">
	                                <button class="mdl-button mdl-button--fab " type="submit">结束值班</button>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	            </form>
            </div>
            <div class="interval">
                <table class="table-shape table-hover table-text" id="">
                    <thead>
                        <tr>
                            <td>最近值班：</td>
                        </tr>
                    </thead>
                    <tbody class="tbody-td">
                        <tr id="table3-title">
                            <td>所在部门</td>
                            <td>姓名</td>
                            <td>开始时间</td>
                            <td>结束时间</td>
                        </tr>
                        <tr style="font-size: 8px;">
                            <td style="padding:0 88px;">
                                <hr style="border:1px solid #ccc;width:950px;">
                            </td>
                        </tr>
                        <%
                        for(String[] item:lastNine){
                        	out.write("<tr><td>运行"+connDB.getDepartment(item[0])+"部</td><td>"+ item[0] +"</td><td>"+item[1]+"</td><td>"+item[2]+"</td></tr>");
                        }
                        %>
                    </tbody>
                </table>
            </div>
            <footer class="interval"></footer>
        </section>
        <section id="scroll-tab-2" class="tab">
            <div class="table-shape table-hover">
            <form method="post" name="proform">
                <table class="table-text" id="table2-1">
                    <thead>
                        <tr>
                            <td colspan="2" style="padding-left: 24px;">问题记录:</td>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="width:84px;padding-left: 24px;">账 号：</td>
                            <td>
                                <input type="number" name="account" value=""></input>
                            </td>
                            <td style="width:84px;padding-left: 24px;">电 话：</td>
                            <td>
                                <input type="tel" name="tele" value=""></input>
                            </td>
                            <td style="width:84px;padding-left: 24px;">时 间： </td>
                            <td>
                                <input type="datetime" name="time" value=""></input>
                            </td>
                        </tr>
                        <tr>
                            <td style="width:84px;padding-left: 24px;">楼宇号：</td>
                            <td>
                                <input type="number" name="building" value=""></input>
                            </td>
                            <td style="width:84px;padding-left: 24px;">房 间：</td>
                            <td>
                                <input type="number" name="room" value=""></input>
                            </td>
                            <td style="width:84px;padding-left: 24px;">记录人：</td>
                            <td>
                                <input type="text" name="recorder" value=""></input>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <hr style="border:1px solid #ccc;width:780px;margin:10px auto;" style="position: relative;">
                <div>
                        <table class="table-text " id="table2-2">
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" name="reason" value="1">认证失败，无法连接认证服务器
                                    </td>
                                    <td>
                                        <input type="radio" name="reason" value="2">在线用户数量达到上限
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" name="reason" value="3">动态IP地址类型绑定错误
                                    </td>
                                    <td>
                                        <input type="radio" name="reason" value="4">IP地址仿冒
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" name="reason" value="5">获取IP信息失败
                                    </td>
                                    <td>
                                        <input type="radio" name="reason" value="6">找不到网卡
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" name="reason" value="7">与已有IP地址冲突
                                    </td>
                                    <td>
                                        <input type="radio" name="reason" value="8">其他
                                        <input type="text" name="other" value="" class="other" style="margin-left: 5px;"></input>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <hr style="border:1px solid #ccc;width:1050px;margin:10px auto;">
                        <table class="table-text " id="table2-3">
                            <tbody>
                                <tr>
                                    <td>
                                        <input type="radio" name="reason" value="9">寝室需要检查端口
                                    </td>
                                    <td>
                                        <input type="radio" name="reason" value="10">教师办公室维修
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <input type="radio" name="reason" value="11">楼层交换机需要重启
                                    </td>
                                    <td id="td-button">
                                        <!-- <button type="button" class="mdl-button mdl-button--fab " id="return">返回</button> -->
                                        <button type="button" class="mdl-button mdl-button--fab " id="still" onclick="notsolved()" >标记未解决</button>
                                        <button type="button" class="mdl-button mdl-button--fab " id="finish" onclick="solved()" >解决并提交</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                </div>
                </form>
            	</div>
            	<%
            		if(request.getAttribute("tip")!=null){
            			out.write("<br><br><div style=\"color: red;text-align: center;font-family: Microsoft YaHei;font-size: 20px;\">"+request.getAttribute("tip")+"</div>");
            		}
            	%>
        </section>
        <section id="scroll-tab-3" class="tab">
            <div class="table-shape table-hover">
                <table class="table-text" id="table3-1">
                    <thead>
                        <tr>
                            <td>待办事项：</td>
                        </tr>
                    </thead>
                    <tbody>
                    <%
                    		int i=1;
                    		for(HashMap<String,String> pro:notsolved){
                    			out.write("<tr><td>"+i+". "+pro.get("reason")+"</td></tr>");
                    			if(pro.containsKey("building")){
                    				out.write("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;楼宇："+pro.get("building")+
                    				(pro.containsKey("room")?"&nbsp;&nbsp;&nbsp;&nbsp;房间："+pro.get("room"):"")+
                    				(pro.containsKey("recordby")?"&nbsp;&nbsp;&nbsp;&nbsp;记录人："+pro.get("recordby"):"")+
                    				"</td></tr>");
                    			}
                    			if(pro.containsKey("account")){
                    				out.write("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;账号:"+pro.get("account")+
                    				(pro.containsKey("tel")?"&nbsp;&nbsp;&nbsp;&nbsp;电话："+pro.get("tel"):"")+
                    				(pro.containsKey("time")?"&nbsp;&nbsp;&nbsp;&nbsp;时间："+pro.get("time"):"")+
                    				"</td></tr>");
                    			}
                    			out.write("<form action=/NMC/hd?event=changestate&id="+ pro.get("id")+" method=\"post\" type=\"hidden\"><tr><td><button type=\"submit\" class=\"mdl-button mdl-button--fab \" id=\"finish\" >解决并提交</button></td></tr></form>");
                    			i++;
                    		}
                    		
                    	%>
                    </tbody>
                </table>
            </div>
        </section>
        <section id="scroll-tab-4" class="tab">
        	<div class="table-shape table-hover">
                <table class="table-text" id="table3-1">
                    <thead>
                        <tr>
                            <td>问题总览：</td>
                        </tr>
                    </thead>
                    <tbody>
                    	<%
                    		int j=1;
                    		for(HashMap<String,String> pro:allRec){
                    			out.write("<tr><td>"+j+". "+pro.get("reason")+"</td></tr>");
                    			if(pro.containsKey("building")){
                    				out.write("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;楼宇："+pro.get("building")+
                    				(pro.containsKey("room")?"&nbsp;&nbsp;&nbsp;&nbsp;房间："+pro.get("room"):"")+
                    				(pro.containsKey("recordby")?"&nbsp;&nbsp;&nbsp;&nbsp;记录人："+pro.get("recordby"):"")+
                    				"</td></tr>");
                    			}
                    			if(pro.containsKey("account")){
                    				out.write("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;账号:"+pro.get("account")+
                    				(pro.containsKey("tel")?"&nbsp;&nbsp;&nbsp;&nbsp;电话："+pro.get("tel"):"")+
                    				(pro.containsKey("time")?"&nbsp;&nbsp;&nbsp;&nbsp;时间："+pro.get("time"):"")+
                    				"</td></tr>");
                    			}
                    			
                    			out.write("<tr><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
                    				((pro.get("solved").equals("1"))?"已解决":"<div style=\"color: red\">待解决</div>")+
                    				"</td></tr>");
                    			j++;
                    		}
                    		out.write("<tr align=\"center\">");
                    		for(int t=(pageNow-3)<1?1:pageNow-3;t<=((pageNow+3)<pagecount?(pageNow+3):pagecount);t++){
                    			out.write("<td><a href=\"/NMC/hd?event=jump&page="+t+"\">"+t+"</a></td>");
                    		}
                    		out.write("</tr>");
                    	%>
                    </tbody>
                </table>
            </div>
        </section>
        
    </main>
    <script src="js/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
    function nav_add(a) {
        /*选中导航栏的样式改变及对应的选项卡*/
        if (a == 1)
            $(".title").addClass("title_1");
        else
            $(".title").removeClass("title_1");
        if (a == 2) {
            $(".title").addClass("title_2");
            $("em").css("display", "none");
            $("#DaiBan").addClass("daiban");
        } else {
            $(".title").removeClass("title_2");
            $("#DaiBan").removeClass("daiban");
        }
        if (a == 3)
            $(".title").addClass("title_3");
        else
            $(".title").removeClass("title_3");
        var div = $(".title-nav_a");
        var tab = $(".tab");
        div.removeClass("title-nav_a_add");
        $(div[a]).addClass("title-nav_a_add");
        $(tab).css("display", "none");
        $(tab[a]).css("display", "block");
    };


    $(document).ready(function() {
        if (true) {
            /*input的获得焦点动态及失去焦点动态*/
            $("#onwork-input").focus(function() {
                $("#onwork-input-label").animate({
                        top: "24px",
                        fontSize: "13px"
                    }, 150)
                    .css("color", "#3F51B5");
                $("#onwork").addClass("is-focused");
                /*            $(this).css("border-bottom", "2px #3f51b5 solid");*/
            });
        }


        $("#onwork-input").blur(function() {
            var inputValue = document.getElementById('onwork-input').value;

            if (inputValue == "") {
                $("#onwork-input-label").animate({
                        top: "+=16px",
                        fontSize: "16px"
                    }, 150)
                    .css("color", "rgba(0,0,0,.26)");
                $("#onwork").removeClass("is-focused");
                /*            $(this).css("border-bottom","1px rgba(0,0,0,.26) solid");*/
            }
        });

    });

    function otherInput() {
        /*第二个选项卡的其他input标签*/
        var check = document.getElementById("other").checked;

        if (check == true) $('.other').css('visibility', 'visible');
        else $('.other').css('visibility', 'hidden');
    };
    $('#next').click(function() {
        $('#form-1').css('display', 'none');
        $('#form-2').css('display', 'block');
    });
    $('#return').click(function() {
        $('#form-1').css('display', 'block');
        $('#form-2').css('display', 'none');
    });
    function solved(){
    	if(confirm("确认提交？")){
    		proform.action='/NMC/hd?event=prorec&solved=1';
    		proform.submit();
    	}
    }
    function notsolved(){
    	if(confirm("确认提交？")){
    		proform.action='/NMC/hd?event=prorec&solved=0';
    		proform.submit();
    	}
    }
    
    </script>
</body>

</html>
