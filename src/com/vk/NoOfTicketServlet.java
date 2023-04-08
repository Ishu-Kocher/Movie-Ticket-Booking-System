package com.vk;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NoOfTicketServlet extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res){
		try {
			PrintWriter out=res.getWriter();
			int bookno=Integer.parseInt(req.getParameter("bookNo"));
			if(bookno!=0){
				Cookie c1=new Cookie("seats",bookno+"");
				 c1.setMaxAge(60);
				 res.addCookie(c1);
				RequestDispatcher rd=req.getRequestDispatcher("booking_details_show.jsp");  
				rd.forward(req, res);
			}
			out.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
