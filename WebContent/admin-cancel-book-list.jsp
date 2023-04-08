<%@page import="java.sql.*" %>
<% 
	String admin_username="";
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("admin-username")==null){
		response.sendRedirect("admin-login.jsp");
	}else{
		admin_username=(String)session.getAttribute("admin-username");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
	<!--main css-->
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<!--google font-->
	<link href="https://fonts.googleapis.com/css?family=Roboto+Mono&display=swap" rel="stylesheet">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.min.css">
    <!-- font awesome css -->
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.min.css">
	<style>
		table{
			text-align: center;
		}
		table tr th{
			padding: 5px;
		}
		table tr td{
			padding: 5px;
		}
	</style>
</head>
<body>
<div class="sign-up">
<h1>Cancel List</h1><br><br>
<table border="1px" align="center">
<tr>
	<th>Booking Id</th><th>UserName</th><th>Movie</th><th>Theater</th><th>Show Time</th><th>Date Of Show</th><th>Number Of Seats To Be Booked</th><th>Payment Amount</th><th>Refund Amount</th>
</tr>
<%
try{
	/* DataBase Connection */
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(url, "database", "ishu");
	if (con != null) {
		String query = "select * from cancel_booking";
		PreparedStatement ps=con.prepareStatement(query);
		ResultSet rs=ps.executeQuery();
		int bid=0,mid=0,sid=0,NoOfSeats=0,payment_amt=0,refund_amt=0;
		String username="";
		while(rs.next()){
			bid=rs.getInt(1);
			username=rs.getString(2);
			mid=rs.getInt(3);
			sid=rs.getInt(4);
			NoOfSeats=rs.getInt(5);
			payment_amt=rs.getInt(6);
			refund_amt=rs.getInt(7);
			
		String query2="select m_name from movielist where m_id="+mid+"";
		PreparedStatement ps2=con.prepareStatement(query2);
		ResultSet rs2=ps2.executeQuery();
		String m_name="";
		while(rs2.next()){
			m_name=rs2.getString(1);
		}
		String query3="select t_id,start_time,date_of_show from show_list where s_id="+sid+"";
		PreparedStatement ps3=con.prepareStatement(query3);
		ResultSet rs3=ps3.executeQuery();
		String show_time="",date="";
		int tid=0;
		while(rs3.next()){
			tid=rs3.getInt(1);
			show_time=rs3.getString(2);
			date=rs3.getString(3);
		}
		String query4="select t_name from theater_list where t_id="+tid+"";
		PreparedStatement ps4=con.prepareStatement(query4);
		ResultSet rs4=ps4.executeQuery();
		String t_name="";
		while(rs4.next()){
			t_name=rs4.getString(1);
		}
	%>	

		<tr>
			<td><%=bid%></td><td><%=username%></td><td><%=m_name%></td><td><%=t_name%></td><td><%=show_time%></td><td><%=date%></td><td><%=NoOfSeats%></td><td><b><%=payment_amt%>rs</b></td><td><b><%=refund_amt%>rs</b></b></td>
		</tr>
<%}
}		
}catch(Exception e){
	e.printStackTrace();
}
%>		
	</table>
</div><br><br>
</body>
</html>