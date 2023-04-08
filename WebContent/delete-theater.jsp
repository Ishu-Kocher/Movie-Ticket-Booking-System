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
						<h1>View/Delete/Edit Theaters</h1>
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
			String query = "select * from theater_list";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			if (con != null) {
				PreparedStatement ps=con.prepareStatement(query);
				ResultSet rs=ps.executeQuery();
				int cnt=0;
				while(rs.next()){
				int tid;
				String tname,tadd,tph;
				tid=rs.getInt(1);
				tname=rs.getString(2);
				tadd=rs.getString(3);
				tph=rs.getString(4);
				if(cnt==3){
					out.println("<\tr><tr>");
					cnt=0;
				}else{
					cnt++;
				}
				%>
				<td>
				<h3><%=tname%></h3><br>
				<p><%=tadd%><br></p>
				<p><%=tph%><br></p>
				<a href="deletetheater?t_id=<%=tid%>"><input type="submit" value="Delete"></a>
				<a href="update-theater.jsp?t_id=<%=tid%>"><button>EDIT</button></a>
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