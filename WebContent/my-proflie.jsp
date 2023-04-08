<%@page import="java.sql.*" %>
<%
	String f_name="",l_name="",id="",pass="",conf_pwd="",email="",phone="";  
	String username="";
	String pwd="";
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("username")==null){
		response.sendRedirect("sign-in.jsp");
	}else{
		username=(String)session.getAttribute("username");
		pwd=(String)session.getAttribute("pwd");
	}
%>
<%
	try{
	/* DataBase Connection */
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String query = "select * from customer_table where username='"+username+"'and pwd='"+pwd+"'";
	Class.forName("oracle.jdbc.OracleDriver");
	Connection con = DriverManager.getConnection(url, "database", "ishu");
	if (con != null) {
		Statement ps=con.createStatement();
		ps.executeUpdate(query);
		ResultSet rs=ps.executeQuery(query);
		while(rs.next()){
			f_name=rs.getString(1);
			l_name=rs.getString(2);
			id=rs.getString(3);
			pass=rs.getString(4);
			conf_pwd=rs.getString(5);
			phone=rs.getString(6);
			email=rs.getString(7);
			} 
		}else {
			out.println("Connection Error..!!");
			}
	
	}catch (Exception e) {
	e.printStackTrace();
}
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Proflie</title>
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
                    <li><a href="user-index.jsp">Home</a></li>
                    <li><a href="movie-list.jsp">Movie List</a></li>
                    <li><a href="book-list.jsp">Book List</a></li>
                    <li><a href="#">Hey,Name <i class="fas fa-chevron-down"></i></a>
                        <ul>
                            <li><a class="active" href="my-profile.jsp">My Proflie</a></li>
                            <li><a href="logout.jsp">LogOut</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
    </div>

                <div class="sign-up-mainContainer">

                    <div class="sign-up">
                        <h1>My Profile</h1>
                            <form action="#" name="signupform" onSubmit="return validate();">
                                <p>First Name<span id="sign-up-edit">Last Name</span></p>
                                <input type="text" name="firstname" value="<%out.println(f_name); %>" placeholder="first name" disabled>
                                <input type="text" name="lastname" value="<%out.println(l_name); %>" placeholder="last name" disabled><br>
                                <p>User Name</p>
                                <input type="text" name="username" value="<%out.println(id); %>" placeholder="username" id="input-edit" disabled>
                                <p>Password <span id="sign-up-edit">Confirm Password</span></p>
                                <input type="text" name="psd" value="<%out.println(pass); %>" placeholder="password" disabled>
                                <input type="text" name="conf_psd" value="<%out.println(conf_pwd); %>" placeholder="confirm password" disabled>
                                <p>Moblie</p>
                                <input type="phone" name="ph" value="<%out.println(phone); %>" id="input-edit" placeholder="moblie" disabled>
                                <p>Email</p>
                                <input type="text" name="email" value="<%out.println(email); %>"  id="input-edit" placeholder="email" disabled><br>
                                </form>
                                <a href="user-index.jsp"><button>BACK</button></a>
           						
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