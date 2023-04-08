package com.vk;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BookingCancelServlet extends HttpServlet {
	public void doGet(HttpServletRequest req,HttpServletResponse res) {
		try {
		int bid=Integer.parseInt(req.getParameter("b_id"));
		int sid=Integer.parseInt(req.getParameter("s_id"));
		/* DataBase Connection */
		String url="jdbc:oracle:thin:@localhost:1521:xe";
		Class.forName("oracle.jdbc.OracleDriver");
		Connection con=DriverManager.getConnection(url,"database","ishu");
		if(con!=null){
			con.setAutoCommit(false);
			//access seats in show list
			String query="select seats from show_list where s_id="+sid+"";
			PreparedStatement ps=con.prepareStatement(query);
			ResultSet rs=ps.executeQuery();
			int seats=0;
			while(rs.next()){
				seats=rs.getInt(1);
			}
			//access booking_details record
			String query6="select * from booking_details where b_id="+bid+"";
			PreparedStatement ps6=con.prepareStatement(query6);
			ResultSet rs6=ps6.executeQuery();
			int abid=0,amid=0,asid=0,numseats=0,amtpay=0;
			String username="";
			while(rs6.next()){
				abid=rs6.getInt(1);
				username=rs6.getString(2);
				amid=rs6.getInt(3);
				asid=rs6.getInt(4);
				numseats=rs6.getInt(5);
				amtpay=rs6.getInt(6);
			}
			int refund_amt=0,detect_amt=0;
			detect_amt=numseats*50;
			refund_amt=amtpay-detect_amt;
			//insert into cancellation details values
			String query7="insert into cancel_booking values(?,?,?,?,?,?,?)";
			PreparedStatement ps7=con.prepareStatement(query7);
			ps7.setInt(1, abid);
			ps7.setString(2, username);
			ps7.setInt(3, amid);
			ps7.setInt(4, asid);
			ps7.setInt(5, numseats);
			ps7.setInt(6, amtpay);
			ps7.setInt(7, refund_amt);
			int can=ps7.executeUpdate();
			if(can>0){
			int updateseats=seats+numseats;
			//update seats in show list
			String query3="update show_list set seats=? where s_id="+sid+"";
			PreparedStatement ps3=con.prepareStatement(query3);
			ps3.setInt(1, updateseats);
			int chk=ps3.executeUpdate();
			//delete payment details record
			String query4="delete payment_details where b_id="+bid+"";
			PreparedStatement ps4=con.prepareStatement(query4);
			int chk1=ps4.executeUpdate();
			//delete booking details record
			String query5="delete booking_details where b_id="+bid+"";
			PreparedStatement ps5=con.prepareStatement(query5);
			int chk2=ps5.executeUpdate();
			if((chk1+chk2)==2){
				con.setAutoCommit(true);
				res.sendRedirect("booking_cancelled.jsp?id="+abid);
			}else {
				String msg="Error";
				res.sendRedirect("book-list.jsp?msg="+msg);
				con.rollback();
			}
		}
		}
		con.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
