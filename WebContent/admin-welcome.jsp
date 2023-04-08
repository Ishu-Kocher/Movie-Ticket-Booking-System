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
			margin-top: 20%;
			margin-left: 38%;
		}
	</style>
</head>
<body>
	<h1>Welcome <%=admin_username%></h1>
</body>
</html>