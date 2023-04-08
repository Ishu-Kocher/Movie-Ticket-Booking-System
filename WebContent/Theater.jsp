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
<!DOCTYPE html>
<html>
<head>
	<title>Theater</title>
	<!--main css-->
	<link rel="stylesheet" type="text/css" href="css/main.css">
	<!--google font-->
	<link href="https://fonts.googleapis.com/css?family=Roboto+Mono&display=swap" rel="stylesheet">
	<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.min.css">
    <!-- font awesome css -->
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.min.css">
   
   <!-- Validation Theater -->
    <script>
    function validate(){
      var tickets=document.theaterform.bookNo.value;
      if(tickets=="" || tickets=="select"){
    	  alert("Please Select Number of Tickets..!!");
    	  return false;
      }
    }
    </script>
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
					<li><a href="user-index.jsp">Home</a></li>
					<li><a href="movie-list.jsp">Movie List</a></li>
					<li><a href="#">Book List</a></li>
					<li><a href="#">Hey, <%out.println(username);%> <i class="fas fa-chevron-down"></i></a>
						<ul>
							<li><a href="my-proflie.jsp">My Proflie</a></li>
							<li><a href="logout.jsp">LogOut</a></li>
						</ul>
					</li>
				</ul>
			</div>
	</div>
	

			<div class="theater-list-mainContainer">
					
					<div class="sign-up">
						<h1>Theater</h1>
					</div>

				<div class="theater-tag">
						<!-- onchange='this.form.submit()' -->
					<form action="testservlet">
						<p>Select Date</p>
						<input type="date" name="date" onchange='this.form.submit()'><br>
					</form>
<%
int mid=0;
Cookie c[]=request.getCookies();
for(Cookie ck:c){
	if(ck.getName().equals("m_id")){
		mid=Integer.parseInt(ck.getValue());
	}
}
%>						
<%	try{	
	/* DataBase Connection */
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String date=request.getParameter("date");
	String query ="select t_name from theater_list where t_id in(select t_id from show_list where m_id="+mid+"and date_of_show='"+date+"')";
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(url, "database", "ishu");
	if (con != null){
	PreparedStatement ps=con.prepareStatement(query);
	ResultSet rs=ps.executeQuery();
	%>
		<form action="testservlet2">
		<p>Select theater</p>
		<select name="theaterlist" onchange='this.form.submit()'>
		<option value="select">Select</option>
		
	<% while(rs.next()){
		String t="";
		t=rs.getString(1);
		%>
		<option value="<%=t%>"><%=t%></option>
		<br><%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
		}
%>	
	</select><br>		
	</form>
<%	try{	
	/* DataBase Connection */
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String theaterlist=request.getParameter("theaterlist");
	String date="";
	Cookie c2[]=request.getCookies();
	for(Cookie ck:c2){
		if(ck.getName().equals("date")){
			date=ck.getValue();
		}
	}
	String query2="select start_time from show_list where t_id in(select t_id from theater_list where t_name='"+theaterlist+"') and m_id="+mid+" and date_of_show='"+date+"'";
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con=DriverManager.getConnection(url, "database", "ishu");
	if (con!= null){
	PreparedStatement ps2=con.prepareStatement(query2);
	ResultSet rs2=ps2.executeQuery();
	%>
		<form action="testservlet3">
		<p>Select Show Time</p>
		<select name="showtime" onchange='this.form.submit()'>
		<option value="select">Select</option>
	<% while(rs2.next()){
		String s="",e="";
		s=rs2.getString(1);
		%>
		<option value="<%=s%>"><%=s%></option>
		<br><%
			}
		}
	}catch(Exception e){
		e.printStackTrace();
		}
%>
	</select><br>	
	</form>
					<form action="testservlet4" name="theaterform" onSubmit="return validate();">
					<p>Select Number of Tickets</p>	
					<select name="bookNo">
					<option value="select">Select</option>
					<%
						for(int i=1;i<=10;i++){
					%>
					<option value="<%=i%>"><%=i %></option>
					<% } %>
				</select><br>		
					<input type="submit" value="BOOK">
					<input type="reset" value="CANCEL">
					</form>
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