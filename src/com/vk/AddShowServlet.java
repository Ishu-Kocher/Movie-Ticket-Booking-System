package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.jasper.tagplugins.jstl.core.Out;

public class AddShowServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res) {
		try {
			PrintWriter out=res.getWriter();
			//Form to access vales
			String m_name=req.getParameter("m_name");
			String t_name=req.getParameter("t_name");
			String start=req.getParameter("start");
			String date=req.getParameter("date");
			int seats=Integer.parseInt(req.getParameter("seats"));
			int mid=0,tid=0;
			/* DataBase Connection */	
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			String query="select m_id from movielist where m_name='"+m_name+"'";
			String query2="select t_id from theater_list where t_name='"+t_name+"'";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection(url,"database","ishu");
			if(con!=null){
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			while(rs.next()){
				mid=rs.getInt(1);
			}
			PreparedStatement ps2=con.prepareStatement(query2);
			ResultSet rs2=ps2.executeQuery();
			while(rs2.next()){
				tid=rs2.getInt(1);
			}
			String query3="select count(*) from show_list where m_id=? and t_id=? and start_time=? and date_of_show=?";
			PreparedStatement ps3=con.prepareStatement(query3);
			ps3.setInt(1, mid);
			ps3.setInt(2, tid);
			ps3.setString(3,start);
			ps3.setString(4,date);
			ResultSet rs3=ps3.executeQuery();
			rs3.next();
			int i=rs3.getInt(1);
				if(i==1){
					String msg="Show already exists";
					res.sendRedirect("add-show.jsp?msg="+msg);
				}else {
					String query4="select s_id from show_list";
					PreparedStatement ps4=con.prepareStatement(query4);
					ResultSet rs4=ps4.executeQuery();
					int sid=0;
					while(rs4.next()) {
						sid=rs4.getInt(1);
					}
					sid++;
					String query5="insert into show_list values(?,?,?,?,?,?)";
					PreparedStatement ps5=con.prepareStatement(query5);
					ps5.setInt(1, sid);
					ps5.setInt(2, mid);
					ps5.setInt(3, tid);
					ps5.setString(4, start);
					ps5.setString(5, date);
					ps5.setInt(6, seats);
					int chk=ps5.executeUpdate();
					if(chk==1) {
						String msg="Show added";
						res.sendRedirect("add-show.jsp?msg="+msg);
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
