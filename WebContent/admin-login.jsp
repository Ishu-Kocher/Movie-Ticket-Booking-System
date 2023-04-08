<!DOCTYPE html>
<html>
<head>
	<title>Admin</title>
	<link rel="stylesheet" type="text/css" href="css/main.css">
</head>
<body class="login-body">
	<div class="admin-login">
			<h2>Admin Login</h2>
			<form action="adminlog" method="get">
				<input type="text" name="admin-username" placeholder="Username">
				<input type="password" name="admin-pass" placeholder="Password">
				<input type="Submit" value="Login">			
			</form>
			<% 
               String msg=request.getParameter("msg");
                if(msg!=null){
                 %><h3 id="admin-msg"><% out.println(msg); %></h3><% 
                }
             %>	
	</div>
</body>
</html>