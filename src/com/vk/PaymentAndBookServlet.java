package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class PaymentAndBookServlet extends HttpServlet {
	public void doPost(HttpServletRequest req,HttpServletResponse res){
		try{
		PrintWriter out=res.getWriter();
		
		int total_amt=Integer.parseInt(req.getParameter("total_amount"));
		//Access Cookies data
		int mid=0,number_of_seats=0;
		String theater="",date="",showtime="";
		Cookie c[]=req.getCookies();
		for(Cookie ck:c){
			if(ck.getName().equals("m_id")){
				mid=Integer.parseInt(ck.getValue());
			}
			if(ck.getName().equals("theater")){
				theater=ck.getValue();
			}
			if(ck.getName().equals("date")){
				date=ck.getValue();
			}
			if(ck.getName().equals("showtime")){
				showtime=ck.getValue();
			}
			if(ck.getName().equals("seats")){
				number_of_seats=Integer.parseInt(ck.getValue());
			}
		}
		//Session get values
		String username="";
		HttpSession session=req.getSession();
		username=(String)session.getAttribute("username");
		if(mid==0){
			String msg="Time Out";
    		res.sendRedirect("movie-list.jsp?msg="+msg);
		}else{
			String url="jdbc:oracle:thin:@localhost:1521:xe";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con=DriverManager.getConnection(url,"database","ishu");
			if(con!=null){
			//access theater id from theater list
			String query1="select t_id from theater_list where t_name='"+theater+"'";
			PreparedStatement ps=con.prepareStatement(query1);
			ResultSet rs=ps.executeQuery();
			int tid=0;
			while(rs.next()){
				tid=rs.getInt(1);
			}
			//access show id and seats from show list
			String query2="select s_id,seats from show_list where m_id="+mid+" and t_id="+tid+" and start_time='"+showtime+"' and date_of_show='"+date+"'";
			PreparedStatement ps2=con.prepareStatement(query2);
			ResultSet rs2=ps2.executeQuery();
			int sid=0,seats=0;
			while(rs2.next()){
				sid=rs2.getInt(1);
				seats=rs2.getInt(2);
			}
			int update_seats=seats-number_of_seats;
			if(update_seats<0){
				String msg="No Seat Available";
				res.sendRedirect("Payment.jsp?msg="+msg);
			}else {
			//access booking id from booking details
			String query3="select b_id from booking_details";
			PreparedStatement ps3=con.prepareStatement(query3);
			ResultSet rs3=ps3.executeQuery();
			int bid=0;
			while(rs3.next()) {
				bid=rs3.getInt(1);
			}
			bid++;
			//insert values in booking details
			String query4="insert into booking_details values(?,?,?,?,?,?)";
			PreparedStatement ps4=con.prepareStatement(query4);
			ps4.setInt(1, bid);
			ps4.setString(2, username);
			ps4.setInt(3, mid);
			ps4.setInt(4, sid);
			ps4.setInt(5, number_of_seats);
			ps4.setInt(6, total_amt);
			int chk=ps4.executeUpdate();
			if(chk==1) {
				//access transaction id from payment details
				String query5="select TRANSACTION_ID from payment_details";
				PreparedStatement ps5=con.prepareStatement(query5);
				ResultSet rs5=ps5.executeQuery();
				int trans_id=0;
				while(rs5.next()){
					trans_id=rs5.getInt(1);
				}
				trans_id++;
				///insert value in payment details
				String query6="insert into payment_details values(?,?,?)";
				PreparedStatement ps6=con.prepareStatement(query6);
				ps6.setInt(1, trans_id);
				ps6.setInt(2, bid);
				ps6.setInt(3, total_amt);
				int f=ps6.executeUpdate();
				if(f==1){
					//update show list seats
						String query7="update show_list set seats=? where s_id=?";
						PreparedStatement ps7=con.prepareStatement(query7);
						ps7.setInt(1, update_seats);
						ps7.setInt(2, sid);
						int up=ps7.executeUpdate();
						if(up==1) {
						res.sendRedirect("Booking_Confirmation.jsp");
						}
				}
				
			}
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
