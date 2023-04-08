<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <!--main css-->
    <link rel="stylesheet" type="text/css" href="css/main.css">
    <!--google font-->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Mono&display=swap" rel="stylesheet">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/all.min.css">
    <!-- font awesome css -->
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.css">
    <!-- Validation sign-up -->
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
    <div>   
        <a class="gototop" href="#"><i class="fas fa-arrow-up"></i></a>
    </div>  
    <div class="header">
        <div class="logo">
            <img src="images/logo.jpg">
        </div>
            <div class="navigation">
                <ul>
                    <li><a href="index.html">Home</a></li>
                    <li><a class="active" href="sign-up.jsp">Sign Up</a></li>
                    <li><a href="sign-in.jsp">Sign In</a></li>
                    <li><a href="help&support.html">Help & Support</a></li>
                </ul>
            </div>
    </div>

                <div class="sign-up-mainContainer">

                    <div class="sign-up">
                        <h1>User Registration</h1>
                        <% 
                        	String msg=request.getParameter("msg");
                        	if(msg!=null){
                        	%><h5 id="test"><% out.println(msg); %></h5><% 
                        	}
                        %>
                            <form action="sign-up-action" method="post" name="signupform" onSubmit="return validate();">
                                <p>First Name<span id="sign-up-edit">Last Name</span></p>
                                <input type="text" name="firstname" placeholder="first name" required>
                                <input type="text" name="lastname" placeholder="last name" required><br>
                                <p>User Name</p>
                                <input type="text" name="username" placeholder="username" id="input-edit" required>
                                <p>Password <span id="sign-up-edit">Confirm Password</span></p>
                                <input type="password" name="psd" placeholder="password" required>
                                <input type="password" name="conf_psd" placeholder="confirm password" required>
                                <p>Moblie</p>
                                <input type="phone" name="ph" id="input-edit" placeholder="moblie" required>
                                <p>Email</p>
                                <input type="text" name="email" id="input-edit" placeholder="email" required><br>
                                <input type="submit" value="SIGN UP">
                                <input type="reset" value="RESET">
                            </form>  
                    </div>



                </div>    
            




            <div class="footer">
                <div class="copyRight">
                    <p>&copyCopyright 2020 Movie's Ticket Booking System</p>
                </div>
                <div class="bootom-navigation">
                    <ul>
                        <li><a href="index.html">Home</a></li>
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