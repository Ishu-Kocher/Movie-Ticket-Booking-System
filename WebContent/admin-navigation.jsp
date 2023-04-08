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
	.navi{
		margin-top: 50px;
	}	
	.navi a{
		text-decoration: none;
		list-style: none;
		background-color: #FE7900;
		color: white;
		padding: 10px 10px;
	}
	.navi a:hover{
		border-radius: 20px;
	}
	</style>
</head>
<body>
	<div class="navi">
		<a href="admin-welcome.jsp" target="frame3">Home</a><br><br><br>
		<a href="add-movie.jsp" target="frame3">Add Movie</a><br><br><br>
		<a href="add-theater.jsp" target="frame3">Add Theater</a><br><br><br>
		<a href="add-show.jsp" target="frame3">Add Show</a><br><br><br>
		<a href="delete-movie.jsp" target="frame3">View/Delete/Edit Movie</a><br><br><br>	
		<a href="delete-theater.jsp" target="frame3">View/Delete/Edit Theater</a><br><br><br>
		<a href="delete-show.jsp" target="frame3">View/Delete Show</a><br><br><br>
		<a href="admin-show-book-list.jsp" target="frame3">Book list</a><br><br><br>
		<a href="admin-cancel-book-list.jsp" target="frame3">Cancel list</a><br><br><br>
		<a href="admin-manage-customer.jsp" target="frame3">Manage Customer</a><br><br><br>
	</div>
</body>
</html>