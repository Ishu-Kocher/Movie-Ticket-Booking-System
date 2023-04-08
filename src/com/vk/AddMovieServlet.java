package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddMovieServlet extends HttpServlet{
	public void doPost(HttpServletRequest req, HttpServletResponse res	) {
		try {
			//Form to access vales
			String mname=req.getParameter("mname");
			String cer=req.getParameter("cer");
			String type=req.getParameter("type");
			String dur=req.getParameter("dur");
			String lan=req.getParameter("lan");
			String dir=req.getParameter("dir");
			String cast=req.getParameter("cast");
			String image=req.getParameter("image");
			String y_link=req.getParameter("y-link");
			int price=Integer.parseInt(req.getParameter("price"));
			/* DataBase Connection */
			PrintWriter out=res.getWriter();	
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			String query="select count(*) from movielist where m_name='"+mname+"'";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection(url,"database","ishu");
			if(con!=null){
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int i=rs.getInt(1);
				if(i==1){
					String msg="Movie already exists";
					res.sendRedirect("add-movie.jsp?msg="+msg);
				}else{
					String query2="select m_id from movielist";
					PreparedStatement ps2=con.prepareStatement(query2);
					ResultSet rs2=ps2.executeQuery();
					int mid=0;
					while(rs2.next()) {
						mid=rs2.getInt(1);
					}
					mid++;
					String query3="insert into movielist values(?,?,?,?,?,?,?,?,?,?,?)";
					PreparedStatement ps3=con.prepareStatement(query3);
					ps3.setInt(1, mid);
					ps3.setString(2, mname);
					ps3.setString(3, cer);
					ps3.setString(4, type);
					ps3.setString(5, dur);
					ps3.setString(6, lan);
					ps3.setString(7, dir);
					ps3.setString(8, cast);
					ps3.setString(9, image);
					ps3.setString(10, y_link);
					ps3.setInt(11, price);
					int chk=ps3.executeUpdate();
					if(chk==1){
						String msg="Movie added";
						res.sendRedirect("add-movie.jsp?msg="+msg);
					}
				}			
			con.close();
			out.close();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
}
