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
String theater="",date="",showtime="",m_name="",m_img="";
int mid=0,m_price=0;
int bookno=Integer.parseInt(request.getParameter("bookNo"));
Cookie c[]=request.getCookies();
for(Cookie ck:c){
	if(ck.getName().equals("m_id")){
		mid=Integer.parseInt(ck.getValue());
	}
	if(ck.getName().equals("theater")){
		theater=ck.getValue();
	}
	if(ck.getName().equals("date")){
		date=ck.getValue();
	}
	if(ck.getName().equals("showtime")){
		showtime=ck.getValue();
	}
}
try{				
/* DataBase Connection */
String url = "jdbc:oracle:thin:@localhost:1521:xe";
String query = "select m_name,m_img,m_price from movielist where m_id="+mid+"";
Class.forName("oracle.jdbc.OracleDriver");
Connection con = DriverManager.getConnection(url, "database", "ishu");
if (con != null) {
	PreparedStatement ps=con.prepareStatement(query);
	ResultSet rs=ps.executeQuery();
		while(rs.next()){
		m_name=rs.getString(1);
		m_img=rs.getString(2);
		m_price=rs.getInt(3);
		}
	}
	Cookie c1=new Cookie("m_price",m_price+"");
	response.addCookie(c1);
	}catch (Exception e){
		e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
	<title>Payment</title>
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
	<div class="payment-mainContainer">

            <div class="sign-up">
            	<h1>Details</h1>
            	<table><tr>
            	<%if(mid!=0){%>
            	<td><p><img src="movie-image/<%=m_img%>" id="image-size-payment"></p><td>
            	<td><p>Movie Name:- <%=m_name%></p>
            	<p>Date Of Show:- <%=date%></p>
            	<p>Theater Name:- <%=theater%></p>
            	<p>Show Time:- <%=showtime%></p>
            	<p>UserName:- <%=username%></p>
            	<p>Number Of Seats To Be Booked:- <%=bookno%></p></td></tr>
            	<%}else{
            		String msg="Time Out";
            		response.sendRedirect("movie-list.jsp?msg="+msg);
            	}%>
            	</table>
                   	<form action="Payment.jsp">
                    <input type="submit" value="PROCESSED TO PAYMENT">
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
</body>
</html>