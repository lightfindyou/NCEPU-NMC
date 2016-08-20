package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class connDB extends Thread{
	//连接数据库
	public static Connection con = null;
	public static Statement stat;
	public static ResultSet rs;
	public static int recnum = 0;
	public static boolean on = false;
	public static String[] lastTwe = new String[12];
	public static String[] minister = new String[3];
	public static String department = new String();
	public static ArrayList<String[]> lastNine = new ArrayList<String[]>();
	public static ArrayList<HashMap<String,String>> notsolved = new ArrayList<HashMap<String,String>>();
	public static ArrayList<HashMap<String,String>> prorec = new ArrayList<HashMap<String,String>>();
	private static void closeRes(){
		try{
			if(rs!=null){  
				rs.close();
			}
			if(stat!=null){
				stat.close();
			}
			if(con!=null){
				con.close();
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
	}
	public static Connection getConn(){
		try{
			String url = "jdbc:mysql://localhost/nmc?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&useSSL=false";
			con = DriverManager.getConnection(url,"root","123456");
		}catch(SQLException e){
			e.printStackTrace();
		}
		return con;
	}
	
	public static String[] getLastTwe(){
		try{
			for(int i=0;i<lastTwe.length;i++){
				lastTwe[i] = null;
			}
			Connection con = getConn();
			stat=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			rs = stat.executeQuery("select count(*) from timerec where endtime is null");
			rs.next();
			int num = rs.getInt(1);
			num = num>12?num-12:0;
			rs = stat.executeQuery("select distinct name from timerec where endtime is null order by starttime DESC limit "+num+",12");
			int i = 0;
			while(rs.next()){
				lastTwe[i] = rs.getString(1);
				i++;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		
		return lastTwe;
	}
	
	public static boolean updateTi(String name){
		boolean flag = false;
		try{
			Connection con = getConn();
			stat=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			SimpleDateFormat sdf = new SimpleDateFormat("MM-dd HH:mm");
			String time = sdf.format(new Date());
			String update = "insert into timerec set name=\'"+name+"\',starttime=\'"+time+"\'";
			if(stat.executeUpdate(update)!=0){
				flag = true;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return flag;
	}
	
	public static void updateTiEn(String name){
		try{
			con = getConn();
			stat = con.createStatement();
			String time = new SimpleDateFormat("MM-dd HH:mm").format(new Date());
			stat.execute("update timerec set endtime=\'"+time+"\'where name=\'"+name+"\'&&endtime is null order by starttime DESC limit 1");
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
	}
	
	public static String[] getMinister(){
		try{
			con = getConn();
			stat = con.createStatement();
			rs = stat.executeQuery("select name from member where minister=1 order by department");
			int i=0;
			while(rs.next()){
				minister[i] = rs.getString(1);
				i++;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return minister;
	}
	
	public static ArrayList<String[]> getLastNine(){
		try{
			lastNine.clear();
			con = getConn();
			stat = con.createStatement();
			rs = stat.executeQuery("select count(*) from timerec where endtime is not null");
			rs.next();
			int num = rs.getInt(1);
			num = num>=9?num-9:0;
			rs = stat.executeQuery("select * from timerec where endtime is not null order by endtime DESC limit 9");
			while(rs.next()){
				String[] rec = new String[3];
				rec[0] = rs.getString(2);
				rec[1] = rs.getString(3);
				rec[2] = rs.getString(4);
				lastNine.add(rec);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return lastNine;
	}
	
	public static String getDepartment(String name){
		try{
			con = getConn();
			stat = con.createStatement();
			rs = stat.executeQuery("select department from member where name=\'"+name+"\'");
			rs.next();
			int num = rs.getInt(1);
			if(num == 1){
				department = "一";
			}else if(num == 2){
				department = "二";
			}else{
				department = "三";
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return department;
		
	}
	
	public static boolean isOn(String name){
		try{
			con = getConn();
			stat = con.createStatement();
			rs = stat.executeQuery("select count(*) from timerec where name=\'"+name+"\'&& endtime is null");
			rs.next();
			int num = rs.getInt(1);
			if(num != 0){
				on = true;
			}else{
				on = false;
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return on;
	}
	
	public static void updatePro(String account,String tele,String time,
			String building,String room,String recorder,String other,
			int reason,int solved){
		on = false;
		try{
			con = getConn();
			stat = con.createStatement();
			String statement = "insert into prorec set ";
			if(account.length()>0){
				statement +="account=\'"+account+"\',"; 
			}
			if(tele.length()>0){
				statement +="tel=\'"+tele+"\',"; 
			}
			if(time.length()>0){
				statement +="time=\'"+time+"\',"; 
			}
			if(building.length()>0){
				statement +="building=\'"+building+"\',"; 
			}
			if(room.length()>0){
				statement +="room=\'"+room+"\',"; 
			}
			if(recorder.length()>0){
				statement +="recordby=\'"+recorder+"\',"; 
			}
			if(reason!=0){
				statement +="reason=\'"+reason+"\',"; 
			}
			if(other.length()>0){
				statement +="other=\'"+other+"\',"; 
			}
			statement +="solved=\'"+solved+"\',"; 
			statement = statement.substring(0, statement.length()-1);
			stat.execute(statement);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
	}
	
	public static ArrayList<HashMap<String,String>> getnotsolved(){
		notsolved.clear();
		try{
			con = getConn();
			stat = con.createStatement();
			rs = stat.executeQuery("select * from prorec where solved=0");
			while(rs.next()){
				HashMap<String,String> rec = new HashMap<String,String>();
				rec.put("id", rs.getString(1));
				if(rs.getString(2)!=null){
					rec.put("account", rs.getString(2));
				}
				if(rs.getString(3)!=null){
					rec.put("tel", rs.getString(3));
				}
				if(rs.getString(4)!=null){
					rec.put("time", rs.getString(4));
				}
				if(rs.getString(5)!=null){
					rec.put("building", rs.getString(5));
				}
				if(rs.getString(6)!=null){
					rec.put("room", rs.getString(6));
				}
				if(rs.getString(7)!=null){
					rec.put("recordby", rs.getString(7));
				}
				if(rs.getInt(8)==8){
					rec.put("reason", rs.getString(9));
				}else{
					switch(rs.getInt(8)){
						case 1 : rec.put("reason", "认证失败，无法连接认证服务器"); break;
						case 2 : rec.put("reason", "在线用户数量达到上限"); break;
						case 3 : rec.put("reason", "动态IP地址类型绑定错误"); break;
						case 4 : rec.put("reason", "IP地址仿冒"); break;
						case 5 : rec.put("reason", "获取IP信息失败"); break;
						case 6 : rec.put("reason", "找不到网卡"); break;
						case 7 : rec.put("reason", "与已有IP地址冲突"); break;
						case 9 : rec.put("reason", "寝室需要检查端口"); break;
						case 10 : rec.put("reason", "教师办公室维修"); break;
						case 11 : rec.put("reason", "楼层交换机需要重启"); break;
					}
				}
				notsolved.add(rec);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return notsolved;
	}
	
	public static ArrayList<HashMap<String,String>> getAllRec(int start,int end){
		prorec.clear();
		try{
			con = getConn();
			stat = con.createStatement();
			rs = stat.executeQuery("select * from prorec order by id DESC limit "+start+","+(end-start));
			while(rs.next()){
				HashMap<String,String> rec = new HashMap<String,String>();
				rec.put("solved", rs.getString(10));
				if(rs.getString(2)!=null){
					rec.put("account", rs.getString(2));
				}
				if(rs.getString(3)!=null){
					rec.put("tel", rs.getString(3));
				}
				if(rs.getString(4)!=null){
					rec.put("time", rs.getString(4));
				}
				if(rs.getString(5)!=null){
					rec.put("building", rs.getString(5));
				}
				if(rs.getString(6)!=null){
					rec.put("room", rs.getString(6));
				}
				if(rs.getString(7)!=null){
					rec.put("recordby", rs.getString(7));
				}
				if(rs.getInt(8)==8){
					rec.put("reason", rs.getString(9));
				}else{
					switch(rs.getInt(8)){
						case 1 : rec.put("reason", "认证失败，无法连接认证服务器"); break;
						case 2 : rec.put("reason", "在线用户数量达到上限"); break;
						case 3 : rec.put("reason", "动态IP地址类型绑定错误"); break;
						case 4 : rec.put("reason", "IP地址仿冒"); break;
						case 5 : rec.put("reason", "获取IP信息失败"); break;
						case 6 : rec.put("reason", "找不到网卡"); break;
						case 7 : rec.put("reason", "与已有IP地址冲突"); break;
						case 9 : rec.put("reason", "寝室需要检查端口"); break;
						case 10 : rec.put("reason", "教师办公室维修"); break;
						case 11 : rec.put("reason", "楼层交换机需要重启"); break;
					}
				}
				prorec.add(rec);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return prorec;
	}
	
	public static int getRecNum(){
		try{
			con = getConn();
			stat = con.createStatement();
			rs = stat.executeQuery("select count(*) from prorec");
			rs.next();
			recnum = rs.getInt(1);
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return recnum;
	}
	
	public static boolean changeState(int id){
		on = false;
		try{
			con = getConn();
			stat = con.createStatement();
			stat.execute("update prorec set solved=1 where id="+id);
			on = true;
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			closeRes();
		}
		return on;
	}
	
	
}