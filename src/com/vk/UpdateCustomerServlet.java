package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateCustomerServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		try {
		String fname=req.getParameter("firstname");	
		String lname=req.getParameter("lastname");
		String username=req.getParameter("username");
		String phone=req.getParameter("ph");
		String email=req.getParameter("email");
		/* DataBase Connection */	
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con=DriverManager.getConnection(url,"database","ishu");
		if(con!=null){
		String query="update customer_table set f_name=?,l_name=?,phone=?,email=? where username='"+username+"'";
		PreparedStatement ps=con.prepareStatement(query);
		ps.setString(1, fname);
		ps.setString(2, lname);
		ps.setString(3, phone);
		ps.setString(4, email);
		int result=ps.executeUpdate();
			if(result==1) {
				String msg="Updated Successfully";
				res.sendRedirect("edit-customer.jsp?msg="+msg);
			}
		}	
		con.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
