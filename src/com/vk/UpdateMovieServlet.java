package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateMovieServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		try {
		//Form to access vales for update
		String mid=req.getParameter("mid");
		String mname=req.getParameter("mname");
		String mcer=req.getParameter("cer");
		String mtype=req.getParameter("type");
		String mdur=req.getParameter("dur");
		String mlan=req.getParameter("lan");
		String mdir=req.getParameter("dir");
		String cast=req.getParameter("cast");
		String mimg=req.getParameter("image");
		String link=req.getParameter("y-link");
		int price=Integer.parseInt(req.getParameter("price"));
		/* DataBase Connection */
		PrintWriter out=res.getWriter();	
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con=DriverManager.getConnection(url,"database","ishu");
		if(con!=null){
		String query="update movielist set m_name=?,m_cer=?,m_type=?,m_dur=?,m_lan=?,m_dir=?,m_cast=?,m_img=?,m_link=?,m_price=? where m_id='"+mid+"'";
		PreparedStatement ps=con.prepareStatement(query);
		ps.setString(1, mname);
		ps.setString(2, mcer);
		ps.setString(3, mtype);
		ps.setString(4, mdur);
		ps.setString(5, mlan);
		ps.setString(6, mdir);
		ps.setString(7, cast);
		ps.setString(8, mimg);
		ps.setString(9, link);
		ps.setInt(10, price);
		int chk=ps.executeUpdate();
			if(chk==1){
				String msg="Updated Successfully";
				res.sendRedirect("update-movie.jsp?msg="+msg);
			}
		}
		con.close();
		out.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
