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
						<h1>View/Delete Show</h1>
						<% 
                        	String msg=request.getParameter("msg");
                        	if(msg!=null){
                        	%><h5 id="test"><% out.println(msg); %></h5><% 
                        	}
                        %>
					</div>
					
		<div class="movies-database">

		<table border="0px" id="theater_table">
		<% 					
			try{				
			/* DataBase Connection */
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String query = "select * from show_list";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			if (con != null) {
				PreparedStatement ps=con.prepareStatement(query);
				ResultSet rs=ps.executeQuery();
				int cnt=0;
				int sid=0,mid=0,tid=0,seats=0;
				String show_time="",date="",m_name="",t_name="";
				while(rs.next()){
				sid=rs.getInt(1);
				mid=rs.getInt(2);
				tid=rs.getInt(3);
				show_time=rs.getString(4);
				date=rs.getString(5);
				seats=rs.getInt(6);
				if(cnt==3){
					out.println("<\tr><tr>");
					cnt=0;
				}else{
					cnt++;
				}
				String query2="select m_name from movielist where m_id="+mid+"";
				PreparedStatement ps2=con.prepareStatement(query2);
				ResultSet rs2=ps2.executeQuery();
				while(rs2.next()){
					m_name=rs2.getString(1);
				}
				String query3="select t_name from theater_list where t_id="+tid+"";
				PreparedStatement ps3=con.prepareStatement(query3);
				ResultSet rs3=ps3.executeQuery();
				while(rs3.next()){
					t_name=rs3.getString(1);
				}
				%>
				<td>
				<h3>Movie Name: <%=m_name%></h3><br>
				<h5>Theater Name: <%=t_name%><br></h5>
				<p>Show Time: <%=show_time%><br></p>
				<p>Date Of Show: <%=date%><br></p>
				<p><b>Seats: <%=seats%></b><br></p>
				<a href="deleteshow?s_id=<%=sid%>"><input type="submit" value="Delete"></a>
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