package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteShowServlet extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		try {
			int sid=Integer.parseInt(req.getParameter("s_id"));	
			/* DataBase Connection */
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			String query="delete show_list where s_id='"+sid+"'";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection(url,"database","ishu");
			PrintWriter out=res.getWriter();
			if(con!=null) {
				PreparedStatement ps=con.prepareStatement(query);
				int i=ps.executeUpdate();
				if(i==1) {
					String msg="Show Deleted";
					res.sendRedirect("delete-show.jsp?msg="+msg);
				}
			}
			con.close();
			out.close();
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
