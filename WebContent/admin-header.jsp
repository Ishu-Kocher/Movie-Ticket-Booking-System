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
	<style>
		h1{
			color: #FE7900;
			text-align: center;
			position: absolute;
			margin-left: 40px;
		}
		a{
			float: right;
			text-decoration: none;
			list-style: none;
			color: black;
			font-size: 20px;
			position: relative;
		}
	</style>
</head>
<body>
	<h1>Online Movie Ticket Booking System</h1>
	<br><br><br>
	<a href="admin-logout.jsp" target="blank">LogOut</a>
</body>
</html>