<%@page import="java.sql.*" %>
<%
	String username="";
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("username")==null){
		response.sendRedirect("sign-in.jsp");
	}else{
		username=(String)session.getAttribute("username");
	}
%>
<%
String bid=request.getParameter("id");
int mid=0,pamt=0,ramt=0;
String mname="";
try{
	/* DataBase Connection */
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(url, "database", "ishu");
	if (con != null) {
		String query = "select  M_ID,AMOUNT_PAY,REFUND_AMOUNT from cancel_booking where b_id="+bid+"";
		PreparedStatement ps=con.prepareStatement(query);
		ResultSet rs=ps.executeQuery();
		
		while(rs.next()){
			mid=rs.getInt(1);
			pamt=rs.getInt(2);
			ramt=rs.getInt(3);
		}
		String query2= "select  m_name from movielist where m_id="+mid+"";
		PreparedStatement ps2=con.prepareStatement(query2);
		ResultSet rs2=ps2.executeQuery();
		
		while(rs2.next()){
			mname=rs2.getString(1);
		}
	}		
}catch(Exception e){
	e.printStackTrace();
}

%>
<!DOCTYPE html>
<html>
<head>
	<title>Booking Cancelled</title>
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
		table{
			text-align: center;
			margin-top: 20px;
		}
		table tr th,table tr td{
			padding: 10px;
		}
		p{
			color: black;
		  	margin-top: 20px;
		  	font-size: 25px;
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

	<i class="far fa-frown"></i>
	<h1 align="center">Booking Cancelled!</h2>
	<table border="1px" align="center">
	<tr>
		<th>Movie Name</th><th>Paid Amount</th><th>Refund Amount</th>
	</tr>
	<tr>
		<td><%=mname%></td><td><%=pamt%></td><td><%=ramt%></td>
	</tr>
	</table>
	<p align="center">Your amount will be credited to your account within 24 hours.</p>
	<a href="book-list.jsp"><button>Back</button></a>

</body>
</html>