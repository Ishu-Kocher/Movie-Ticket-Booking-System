package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SignInServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res){
		try {
			/* Sign-in data from access */
			String username = req.getParameter("username");
			String pwd = req.getParameter("pass");
			/* DataBase Connection */
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String query = "select count(*) from customer_table where username=? and pwd=?";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			PrintWriter out = res.getWriter();
			if (con != null) {
				PreparedStatement ps = con.prepareStatement(query);
				ps.setString(1, username);
				ps.setString(2, pwd);
				ResultSet rs=ps.executeQuery();
				rs.next();
				int i=rs.getInt(1);
				if(i==1) {  
				  HttpSession session=req.getSession();
				  session.setAttribute("username", username);
				  session.setAttribute("pwd", pwd);
				  res.sendRedirect("user-index.jsp");
				  }else { 
					  String msg="username and password incorret";
					  res.sendRedirect("sign-in.jsp?msg="+msg); 
				  	} 
				}else {
				out.println("Connection Error..!!");
			}
			con.close();
			out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
