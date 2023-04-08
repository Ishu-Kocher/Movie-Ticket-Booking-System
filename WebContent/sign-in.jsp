<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
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
                    <li><a href="index.html">Home</a></li>
                    <li><a href="sign-up.jsp">Sign Up</a></li>
                    <li><a class="active" href="sign-in.jsp">Sign In</a></li>
                    <li><a href="help&support.html">Help & Support</a></li>
                </ul>
            </div>
    </div>

                <div class="sign-in-mainContainer">


                        <div class="login">
                                <h1>Login</h1>
                        <% 
                        	String msg=request.getParameter("msg");
                        	if(msg!=null){
                        	%><h5 id="test2"><% out.println(msg); %></h5><% 
                        	}
                        %>
                                <form action="sign-in-action" onSubmit="return validate()">
                                    <p>User Name <span id="sign-in-edit">Password</span></p>
                                    <input type="text" name="username" placeholder="Username" id="id" required="">
                                    <input type="password" name="pass" placeholder="Password" id="pwd" required=""><br>
                                    <input type="submit" value="LOG IN">
                                    <a href="sign-up.jsp"><input type="button" value="SIGN UP"></a>
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