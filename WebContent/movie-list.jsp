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
					<li><a class="active" href="movie-list.jsp">Movie List</a></li>
					<li><a href="book-list.jsp">Book List</a></li>
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
						<h1>Movie's</h1>
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
			String query = "select * from movielist";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			if (con != null) {
				PreparedStatement ps=con.prepareStatement(query);
				ResultSet rs=ps.executeQuery();
				int cnt=0;
				while(rs.next()){
				int id;
				String n,c,d,t,l,dir,cast,img,u;
				int price;
				id=rs.getInt(1);
				n=rs.getString(2);
				c=rs.getString(3);
				t=rs.getString(4);
				d=rs.getString(5);
				l=rs.getString(6);
				dir=rs.getString(7);
				cast=rs.getString(8);
				img=rs.getString(9);
				u=rs.getString(10);
				price=rs.getInt(11);
				if(cnt==3){
					out.println("<\tr><tr>");
					cnt=0;
				}else{
					cnt++;
				}
				%>
				<td><img src="movie-image/<%=img%>"><br>
				<h3><%=n%></h3>
				<p><%=c%> <%=l%> <%=t%></p>
				<p>Duration :<%=d%><br></p>
				<p>Director :<%=dir%><br></p>
				<p>Cast :<%=cast%><br></p>
				<p><b><%=price%>rs</b><br></p>
				<a href="cookies?m_id=<%=id%>" target="black"><input type="submit" value="Book"></a>
				<a href="<%=u%>" target="blank"><button>Watch Trailer</button></a></td>
				
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