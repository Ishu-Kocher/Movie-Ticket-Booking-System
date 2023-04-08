package com.vk;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AdminLoginServlet extends HttpServlet{
	public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException{
		try {	
			/* Sign-in data from access */
			String admin_username = req.getParameter("admin-username");
			String admin_pwd = req.getParameter("admin-pass");
			/* DataBase Connection */
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String query = "select count(*) from admin_table where username=? and pwd=?";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			PrintWriter out = res.getWriter();
			if (con != null) {
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, admin_username);
				ps.setString(2, admin_pwd);
				ResultSet rs=ps.executeQuery();
				rs.next();
				int i=rs.getInt(1);
				if(i==1) {  
				  HttpSession session=req.getSession();
				  session.setAttribute("admin-username", admin_username);
				  session.setAttribute("admin-pwd", admin_pwd);
				  res.sendRedirect("admin-index.jsp");
				  }else { 
					  String msg="Login Failed";
					  res.sendRedirect("admin-login.jsp?msg="+msg);
				  	} 
				}else {
				out.println("Connection Error..!!");
			}
			con.close();
			out.close();
			}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
