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
			padding: 10px;
		}
		table tr td{
			padding: 10px;
		}
	</style>
</head>
<body>
<div class="sign-up">
<h1>Manage Customer</h1>
<% 
	String msg=request.getParameter("msg");
    if(msg!=null){
  	%><h5 id="test"><% out.println(msg); %></h5><% 
    }
%>
<br><br>
<table border="1px" align="center">
<tr>
	<th>First Name</th><th>Last Name</th><th>Username</th><th>Phone</th><th>Email</th><th>Edit</th><th>Delete</th>
</tr>
<%
try{
	/* DataBase Connection */
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(url, "database", "ishu");
	if (con != null) {
		String query = "select f_name,l_name,username,phone,email from customer_table";
		PreparedStatement ps=con.prepareStatement(query);
		ResultSet rs=ps.executeQuery();
		String fname="",lname="",username="",phone="",email="";
		while(rs.next()){
			fname=rs.getString(1);
			lname=rs.getString(2);	
			username=rs.getString(3);
			phone=rs.getString(4);
			email=rs.getString(5);
	%>	

		<tr>
			<td><%=fname%></td>
			<td><%=lname%></td>
			<td><%=username%></td>
			<td><%=phone%></td>
			<td><%=email%></td>
			<td><a href="edit-customer.jsp?username=<%=username%>">Edit</a></td>
			<td><a href="delete-customer?username=<%=username%>">Delete</a></td>
		</tr>
	<%}
	}		
}catch(Exception e){
	e.printStackTrace();
}
%>		
	</table>
</div>	
</body>
</html>