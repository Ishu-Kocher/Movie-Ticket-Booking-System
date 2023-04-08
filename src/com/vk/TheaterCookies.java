package com.vk;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TheaterCookies extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) {
		try {
			int mid=Integer.parseInt(req.getParameter("m_id"));
			//create cookie object to store name and bookNo.
			 Cookie c1=new Cookie("m_id",mid+"");
			 //add cookie into response object
			 c1.setMaxAge(60);
			 res.addCookie(c1);
			 res.sendRedirect("Theater.jsp");
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
