package control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.*;

public class handler extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override 
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("text/html");
		resp.setCharacterEncoding("UTF-8");
		String event = req.getParameter("event");
		if(event.equals("start")){
			String user = new String(req.getParameter("onwork").getBytes("ISO-8859-1"),"utf-8");
			if(user!=null&&user.length()>0&&!connDB.isOn(user)){
				connDB.updateTi(user);
			}
		}else if(event.equals("end1")){
			String[] name = req.getParameterValues("mem1");
			for(int i = 0;i<name.length;i++){
				name[i]=new String(name[i].getBytes("ISO-8859-1"),"utf-8");
				connDB.updateTiEn(name[i]);
			}
		}else if(event.equals("end2")){
			String[] name = req.getParameterValues("mem2");
			for(int i = 0;i<name.length;i++){
				name[i]=new String(name[i].getBytes("ISO-8859-1"),"utf-8");
				connDB.updateTiEn(name[i]);
			}
		}else if(event.equals("prorec")){
			String account = new String(req.getParameter("account").getBytes("ISO-8859-1"),"utf-8");
			String tele = new String(req.getParameter("tele").getBytes("ISO-8859-1"),"utf-8");
			String time = new String(req.getParameter("time").getBytes("ISO-8859-1"),"utf-8");
			String building = new String(req.getParameter("building").getBytes("ISO-8859-1"),"utf-8");
			String room = new String(req.getParameter("room").getBytes("ISO-8859-1"),"utf-8");
			String recorder = new String(req.getParameter("recorder").getBytes("ISO-8859-1"),"utf-8");
			String other = "";
			int solved = Integer.parseInt(req.getParameter("solved"));
			int reason = 0;
			try{
				reason = Integer.parseInt(req.getParameter("reason"));
			}catch(Exception e){
				reason = 0;
			}
			if(reason==0){
				req.setAttribute("tip", "ÇëÑ¡Ôñ´íÎóÌáÊ¾.");
				req.getRequestDispatcher("index.jsp").forward(req, resp);
				return ;
			}else if(reason==8){
				other = new String(req.getParameter("other").getBytes("ISO-8859-1"),"utf-8");
			}
			connDB.updatePro(account, tele, time, building, room, recorder, other, reason, solved);
		}else if(event.equals("changestate")){
			int id = Integer.parseInt(req.getParameter("id"));
			connDB.changeState(id);
		}else if(event.equals("jump")){
			int page = Integer.parseInt(req.getParameter("page"));
			int recNum = connDB.getRecNum();
			ArrayList<HashMap<String,String>> allRec = connDB.getAllRec((recNum-page*10<0)?0:(recNum-page*10),recNum-(page-1)*10);
			req.setAttribute("all", allRec);
			req.setAttribute("pageNow", page);
			req.getRequestDispatcher("index.jsp").forward(req, resp);
			return ;
		}
		
		
		resp.sendRedirect("http://localhost:8888/NMC/");
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doGet(req, resp);
	}
	
}