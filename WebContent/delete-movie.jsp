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
</head>
<body>

				<div class="movie-list-mainContainer">
					
					<div class="movie-list">
						<h1>View/Delete/Edit Movies</h1>
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
				String n,c,t,d,l,dir,cast,img,u;
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
				<p><%=c%> <%=l%> <%=t%><br></p>
				<p>Duration :<%=d%><br></p>
				<p>Director :<%=dir%><br></p>
				<p>Cast :<%=cast%><br></p>
				<p><b><%=price%>rs</b><br></p>
				<a href="deletemovie?m_id=<%=id%>"><input type="submit" value="Delete"></a>
				<a href="update-movie.jsp?m_id=<%=id%>"><button>EDIT</button></a>
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

</body>
</html>