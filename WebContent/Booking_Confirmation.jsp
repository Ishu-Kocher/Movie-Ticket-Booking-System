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
	<title>Booking Confirm</title>
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.min.css">
    <!-- font awesome css -->
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.css">
	<style>	
		h1{
		  color: black;
		  margin-top: 50px;
		  font-size: 50px;
		}
		h2{
		  color: black;
		  font-size: 30px;
		  margin-top: 20px;
		}
		button{
			margin-left: 47%;
			margin-top: 5%;
			width: 80px;
			height: 35px;
			background-color: #FE7900;
			border-radius: 20px;
			color: white;
			border: none;
		}
		button:hover{
			color: #FE7900;
			background-color: white;
			border: 2px solid #FE7900;
		}
		button:focus{
			outline: none;
		}
		i{
			font-size: 50px;
			color: #FE7900;
			margin-top: 5%;
			margin-left: 48%;
		}
	</style>
</head>
<body>

	<i class="far fa-check-circle"></i>
	<h1 align="center">Thank You!</h2>
	<h2 align="center">for using the Movie Ticket Booking System</h2>
	<a href="book-list.jsp"><button>Back</button></a>

</body>
</html>