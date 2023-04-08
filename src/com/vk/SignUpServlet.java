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

public class SignUpServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException{
		try {
		/* Sign-up data from access */
		String f_name=req.getParameter("firstname");
		String l_name=req.getParameter("lastname");
		String user=req.getParameter("username");
		String pwd=req.getParameter("psd");
		String conf_pwd=req.getParameter("conf_psd");
		String phone=req.getParameter("ph");
		String email=req.getParameter("email");
		/* DataBase Connection */
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String query2="insert into customer_table values(?,?,?,?,?,?,?)";
		String query1="select count(*) from customer_table where username='"+user+"'";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con=DriverManager.getConnection(url,"database","ishu");
		PrintWriter out=res.getWriter();
		if(con!=null) {
			PreparedStatement ps1=con.prepareStatement(query1);
			ResultSet rs1=ps1.executeQuery();
			rs1.next();
			int i=rs1.getInt(1);
				if(i==1){
					String msg="Already Registered";
					res.sendRedirect("sign-up.jsp?msg="+msg);
				}else {
					PreparedStatement ps2=con.prepareStatement(query2);
					ps2.setString(1, f_name);
					ps2.setString(2, l_name);
					ps2.setString(3, user);
					ps2.setString(4, pwd);
					ps2.setString(5, conf_pwd);
					ps2.setString(6, phone);
					ps2.setString(7, email);
					int r=ps2.executeUpdate();
					if(r>0){
						String msg="Successfully Register";
						res.sendRedirect("sign-up.jsp?msg="+msg);
					}
				}	
		}
		con.close();
		out.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
