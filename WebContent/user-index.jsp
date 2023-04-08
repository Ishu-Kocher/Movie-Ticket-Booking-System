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
	<title>User Home</title>
	<!--main css-->
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<!--google font-->
	<link href="https://fonts.googleapis.com/css?family=Roboto+Mono&display=swap" rel="stylesheet">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.min.css">
    <!-- font awesome css -->
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.css">
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
					<li><a class="active" href="user-index.jsp">Home</a></li>
					<li><a href="movie-list.jsp">Movie List</a></li>
					<li><a href="book-list.jsp">Book List</a></li>
					<li><a href="#">Hey,<%out.println(username);%> <i class="fas fa-chevron-down"></i></a>
						<ul>
							<li><a href="my-proflie.jsp">My Proflie</a></li>
							<li><a href="logout.jsp">LogOut</a></li>
						</ul>
					</li>
				</ul>
			</div>
	</div>

				<div class="user-mainContainer">
					
					<div class="user-cover-page">
						<img src="images/admin-cover-page.jpg">
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