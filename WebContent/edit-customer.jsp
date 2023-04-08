<%@page import="java.sql.*" %>
<% 
	String admin_username="";
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("admin-username")==null){
		response.sendRedirect("admin-login.jsp");
	}else{
		admin_username=(String)session.getAttribute("admin-username");
	}
%>
<% 			
			String username=request.getParameter("username");
			String fname="",lname="",phone="",email="";
			try{				
				/* DataBase Connection */
				String url = "jdbc:oracle:thin:@localhost:1521:xe";
				Class.forName("oracle.jdbc.OracleDriver");
				Connection con = DriverManager.getConnection(url, "database", "ishu");
				if (con != null) {
					String query = "select f_name,l_name,username,phone,email from customer_table where username='"+username+"'";
					PreparedStatement ps=con.prepareStatement(query);
					ResultSet rs=ps.executeQuery();
					while(rs.next()){
						fname=rs.getString(1);
						lname=rs.getString(2);	
						username=rs.getString(3);
						phone=rs.getString(4);
						email=rs.getString(5);	
						}
				}
			}catch (Exception e) {
					e.printStackTrace();
			}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin</title>
	<!--main css-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <!--google font-->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Mono&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.min.css">
    <!-- font awesome css -->
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.css">

	<!-- Validation edit-customer -->
    <script>
        function validate(){
            var ftname=document.signupform.firstname.value;
            var ltname=document.signupform.lastname.value;
            var id=document.signupform.username.value;
            var pwd=document.signupform.psd.value;
            var conf_pwd=document.signupform.conf_psd.value;
            var phone=document.signupform.ph.value;
            var email=document.signupform.email.value;
            var e=email.indexOf('@');
            if(phone.length>10 || phone.length<10){
            	alert("Phone Number Invalid..!!");
            	return false;
            }if(phone.length==10){
            	return true;
            }if(isNaN(phone)){
            	alert("Phone Number Cannot Be Characters..!!");
            	return false;
            }if(pwd!=conf_pwd){
            	alert("Password Did Not Match..!!");
            	return false;
            }if(!isNaN(ftname)){
            	alert("First Name Can't Be Numeric..!!");
            	return false;
            }if(!isNaN(ltname)){
            	alert("Last Name Can't Be Numeric..!!");
            	return false;
            }if(e<0){
            	alert("Invalid Email Address..!!");
            	return false;
            }if(ftname.length>10){
            	alert("First Name Can Not Be More Than 10 Digits..!!");
            	return false;
            }if(ltname.length>10){
            	alert("Last Name Can Not Be More Than 10 Digits..!!");
            	return false;
            }if(id.length>10){
            	alert("Username Can Not Be More Than 10 Digits..!!");
            	return false;
            }if(pwd.length>10||conf_pwd.length>10){
            	alert("Password Can Not Be More Than 10 Digits..!!");
            	return false;
            }else{
                return true;
            }
        }
    </script>
</head>
<body>
<div class="sign-up">
			<h1>Update Customer</h1>
			 <% 
               String msg=request.getParameter("msg");
               if(msg!=null){
               %><h5 id="test"><% out.println(msg); %></h5><% 
                }
             %>
			 <form action="update-customer" method="post" name="signupform" onSubmit="return validate();">
                 <p>First Name<span id="sign-up-edit">Last Name</span></p>
                 <input type="text" name="firstname" value="<%=fname%>" placeholder="first name" required>
                 <input type="text" name="lastname" value="<%=lname%>" placeholder="last name" required><br>
                 <p>User Name</p>
                 <input type="text" name="username" value="<%=username%>" placeholder="username" id="input-edit" readonly>
                 <p>Moblie</p>
                 <input type="phone" name="ph" value="<%=phone%>" id="input-edit" placeholder="moblie" required>
                 <p>Email</p>
                 <input type="text" name="email" value="<%=email%>" id="input-edit" placeholder="email" required><br>
                 <input type="submit" value="UPDATE">
                 <input type="reset" value="RESET">
             </form>  
	</div><br><br>

</body>
</html>