package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class AddTheaterServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		try {
			//Form to access value
			String tname=req.getParameter("tname");
			String tadd=req.getParameter("tadd");
			String tph=req.getParameter("tph");
			/* DataBase Connection */
			PrintWriter out=res.getWriter();	
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			String query="select count(*) from theater_list where t_name='"+tname+"'";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection(url,"database","ishu");
			if(con!=null) {
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			rs.next();
			int i=rs.getInt(1);
				if(i==1){
					String msg="Theater already exists";
					res.sendRedirect("add-theater.jsp?msg="+msg);
				}else{
					String query2="select t_id from theater_list";
					PreparedStatement ps2=con.prepareStatement(query2);
					ResultSet rs2=ps2.executeQuery();
					int tid=0;
					while(rs2.next()){
						tid=rs2.getInt(1);
					}
					tid++;
					String query3="insert into theater_list values(?,?,?,?)";
					PreparedStatement ps3=con.prepareStatement(query3);
					ps3.setInt(1, tid);
					ps3.setString(2, tname);
					ps3.setString(3, tadd);
					ps3.setString(4, tph);
					int chk=ps3.executeUpdate();
					if(chk==1) {
						String msg="Theater added";
						res.sendRedirect("add-theater.jsp?msg="+msg);
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
