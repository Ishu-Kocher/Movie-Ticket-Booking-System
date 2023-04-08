package com.vk;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SelectDateServlet extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res){
		try {
		PrintWriter out=res.getWriter();
		String date=req.getParameter("date");
		if(date!=null){  
			Cookie c1=new Cookie("date",date+"");
			 c1.setMaxAge(60);
			 res.addCookie(c1);
			RequestDispatcher rd=req.getRequestDispatcher("Theater.jsp");  
			rd.forward(req, res);  
		}
		out.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
