<%@page import="java.sql.*" %>
<%
	String username="";
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("username")==null){
		response.sendRedirect("sign-in.jsp");
	}else{
		username=(String)session.getAttribute("username");
	}
%>

<!DOCTYPE html>
<html>
<head>
	<title>Movie List</title>
	<!--main css-->
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<!--google font-->
	<link href="https://fonts.googleapis.com/css?family=Roboto+Mono&display=swap" rel="stylesheet">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.min.css">
    <!-- font awesome css -->
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.min.css">
</head>
<body>
	<div>	
		<a class="gototop" href="#"><i class="fas fa-arrow-up"></i></a>
	</div>	
	<div class="header">
		<div class="logo">
			<img src="images/logo.jpg">
		</div>
			<div class="navigation">
				<ul>
					<li><a href="user-index.jsp">Home</a></li>
					<li><a href="movie-list.jsp">Movie List</a></li>
					<li><a class="active" href="book-list.jsp">Book List</a></li>
					<li><a href="#">Hey, <%out.println(username);%> <i class="fas fa-chevron-down"></i></a>
						<ul>
							<li><a href="my-proflie.jsp">My Proflie</a></li>
							<li><a href="logout.jsp">LogOut</a></li>
						</ul>
					</li>
				</ul>
			</div>
	</div>

				<div class="movie-list-mainContainer">
					
					<div class="sign-up">
						<h1>Book List</h1>
						<% 
                        	String msg=request.getParameter("msg");
                        	if(msg!=null){
                        	%><h5 id="test"><% out.println(msg); %></h5><% 
                        	}
                        %>
					</div>
					
		<div class="movies-database">

		<table border="0px">
		<% 					
			try{				
			/* DataBase Connection */
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String query = "select * from booking_details where username='"+username+"'";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			if (con != null) {
				PreparedStatement ps=con.prepareStatement(query);
				ResultSet rs=ps.executeQuery();
				int cnt=0;
				int bid=0,mid=0,sid=0,number_of_seats=0,amt_pay=0;
				String userid="";
				while(rs.next()){
				bid=rs.getInt(1);
				userid=rs.getString(2);
				mid=rs.getInt(3);
				sid=rs.getInt(4);
				number_of_seats=rs.getInt(5);
				amt_pay=rs.getInt(6);
				if(cnt==3){
					out.println("<\tr><tr>");
					cnt=0;
				}else{
					cnt++;
				}
				String query2="select m_name,m_img from movielist where m_id="+mid+"";
				PreparedStatement ps2=con.prepareStatement(query2);
				ResultSet rs2=ps2.executeQuery();
				String m_name="",img="";
				while(rs2.next()){
					m_name=rs2.getString(1);
					img=rs2.getString(2);
				}
				String query3="select t_id,date_of_show,START_TIME from show_list where s_id="+sid+"";
				PreparedStatement ps3=con.prepareStatement(query3);
				ResultSet rs3=ps3.executeQuery();
				int tid=0;
				String date="",showtime="";
				while(rs3.next()){
					tid=rs3.getInt(1);
					date=rs3.getString(2);
					showtime=rs3.getString(3);
				}
				String query4="select t_name from theater_list where t_id="+tid+"";
				PreparedStatement ps4=con.prepareStatement(query4);
				ResultSet rs4=ps4.executeQuery();
				String t_name="";
				while(rs4.next()){
					t_name=rs4.getString(1);
				}
				%>
				<td><img src="movie-image/<%=img%>"><br>
				<h3><b><%=m_name%></b><br></h3>
				<p><b>Theater Name: <%=t_name%></b><br></p>
				<p>Date Of Show: <%=date%><br></p>
				<p>Show Time: <%=showtime%><br></p>
				<p>Number Of Seats: <%=number_of_seats%><br></p>
				<p>Amount Pay: <b><%=amt_pay%></b></p>
				<p><b></b><br></p>
				<a href="bookcancel?b_id=<%=bid%>&s_id=<%=sid%>"><input type="submit" value="Cancel"></a>
				</td>
				
				<%}
				 }else {
					out.println("Connection Error..!!");
					}
			
				}catch (Exception e) {
					e.printStackTrace();
			}
		%>
			
				</table>
			
			</div>
				
		
		</div>





			<div class="footer">
				<div class="copyRight">
					<p>&copyCopyright 2020 Movie's Ticket Booking System</p>
				</div>
				<div class="bootom-navigation">
					<ul>
						<li><a href="user-index.jsp">Home</a></li>
						<li><a href="help&support.html">Help & Support</a></li>
					</ul>
				</div>
			</div>



<!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="js/jquery-3.3.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>