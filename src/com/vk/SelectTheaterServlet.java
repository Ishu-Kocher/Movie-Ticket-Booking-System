package com.vk;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SelectTheaterServlet extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res){
		try {
			PrintWriter out=res.getWriter();
			String theater=req.getParameter("theaterlist");
			if(theater!=null && !theater.equals("select")) {
				Cookie c1=new Cookie("theater",theater+"");
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
