package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateTheaterServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res){
		try {
		//Form to access vales for update
		String tid=req.getParameter("tid");
		String tname=req.getParameter("tname");	
		String taddr=req.getParameter("tadd");
		String tph=req.getParameter("tph");
		/* DataBase Connection */
		PrintWriter out=res.getWriter();	
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con=DriverManager.getConnection(url,"database","ishu");
		if(con!=null){
		String query="update theater_list set t_name=?,t_add=?,t_ph=? where t_id='"+tid+"'";
		PreparedStatement ps=con.prepareStatement(query);
		ps.setString(1, tname);
		ps.setString(2, taddr);
		ps.setString(3, tph);
		int chk=ps.executeUpdate();
			if(chk==1){
				String msg="Updated Successfully";
				res.sendRedirect("update-theater.jsp?msg="+msg);
			}
		}
		con.close();
		out.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
