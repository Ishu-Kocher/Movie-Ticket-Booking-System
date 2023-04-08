package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DeleteMovieServlet extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		try{
		int mid=Integer.parseInt(req.getParameter("m_id"));	
		/* DataBase Connection */
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		String query="delete movielist where m_id='"+mid+"'";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con=DriverManager.getConnection(url,"database","ishu");
		PrintWriter out=res.getWriter();
		if(con!=null) {
			PreparedStatement ps=con.prepareStatement(query);
			int i=ps.executeUpdate();
			if(i==1) {
				String msg="Movie Deleted";
				res.sendRedirect("delete-movie.jsp?msg="+msg);
			}
		}
		con.close();
		out.close();	
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
