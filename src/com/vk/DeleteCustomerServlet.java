package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteCustomerServlet extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		try {
		String username=req.getParameter("username");	
		/* DataBase Connection */
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con=DriverManager.getConnection(url,"database","ishu");
		if(con!=null) {
			//delete customer in booking details
			String query="delete booking_details where username='"+username+"'";
			PreparedStatement ps=con.prepareStatement(query);
			int chk1=ps.executeUpdate();
			//delete customer in customer table
			String query2="delete customer_table where username='"+username+"'";
			PreparedStatement ps2=con.prepareStatement(query2);
			int chk2=ps2.executeUpdate();
			if(chk2==1) {
				String msg="Customer Deleted";
				res.sendRedirect("admin-manage-customer.jsp?msg="+msg);
			}else{
				String msg="Error";
				res.sendRedirect("admin-manage-customer.jsp?msg="+msg);
			}
		}
		con.close();	
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
