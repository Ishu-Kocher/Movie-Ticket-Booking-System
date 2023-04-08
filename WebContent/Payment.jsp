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
int bookno=0,m_price=0;
Cookie c[]=request.getCookies();
for(Cookie ck:c){
	if(ck.getName().equals("seats")){
		bookno=Integer.parseInt(ck.getValue());
	}
	if(ck.getName().equals("m_price")){
		m_price=Integer.parseInt(ck.getValue());
	}
}	
int total_amt=(m_price*bookno);
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

	<!-- Validation payment -->
    <script>
    function validate(){
      var cdno=document.paymentform.card_number.value;
      var cdname=document.paymentform.card_name.value;
      var cdtype=document.paymentform.card_type.value;
      var cdmonth=document.paymentform.month.value;
      var cdyear=document.paymentform.year.value;
      var cvv=document.paymentform.cvv.value;
      if(cdno.length>12 || cdno.length<12){
    	  alert("Enter 12 Digits Valid Card Number..!!");
    	  return false;
      }
      if(isNaN(cdno)){
    	  alert("Card Number Can't Be Characters..!!");
    	  return false;
      }
      if(!isNaN(cdname)){
    	  alert("Card Name Can't Be Numeric..!!");
    	  return false;
      }
      if(cdtype=="" || cdtype=="select"){
    	  alert("Please Select Card Type..!!");
    	  return false;
      }
      if(cdmonth=="" || cdmonth=="select"){
    	  alert("Please Select Month..!!");
    	  return false;
      }
      if(cdyear=="" || cdyear=="select"){
    	  alert("Please Select Year..!!");
    	  return false;
      }
      if(cvv.length>3 || cvv.length<3){
    	  alert("Enter 3 Digits Valid CVV Number..!!");
    	  return false;
      }
      if(isNaN(cvv)){
    	  alert("CVV Number Can't Be Characters..!!");
    	  return false;
      }
      else{
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
           
               	<h1>Payment</h1>
               	<% 
              		 String msg=request.getParameter("msg");
              		 if(msg!=null){
              		 %><h5 id="test"><% out.println(msg); %></h5><% 
                	}
             	%>
              
                   	<form action="payment" method="post" name="paymentform" onSubmit="return validate();">
                    <p>Card Number<span id="sign-in-edit3">Name of card holder</span></p>
                    <input type="text" name="card_number" placeholder="credit card number" required>
                    <input type="text" name="card_name" placeholder="name of card holder" required><br>
                    <p>Card Type</p>
                    <select name="card_type" id="input-edit">
                    	<option value="select">Select</option>
                    	<option value="Visa">Visa</option>
                    	<option value="Master_card">Master Card</option>
                    	<option value="RuPay">RuPay</option>
                    	<option value="Maestro">Maestro</option>
                    </select>
                    <p>Month <span id="sign-in-edit2">Year</span></p>
                    <select name="month">
                    	<option value="select">Select</option>
                    	<option value="January">January</option>
                    	<option value="February">February</option>
                    	<option value="March">March</option>
                    	<option value="April">April</option>
                    	<option value="May">May</option>
                    	<option value="June">June</option>
                    	<option value="July">July</option>
                    	<option value="August">August</option>
                    	<option value="September">September</option>
                    	<option value="October">October</option>
                    	<option value="November">November</option>
                    	<option value="December">December</option>
                    </select>
                    <select name="year">
                    	<option value="select">Select</option>
                    	<option value="2020">2020</option>
                    	<option value="2021">2021</option>
                    	<option value="2022">2022</option>
                    	<option value="2023">2023</option>
                    	<option value="2024">2024</option>
                    	<option value="2025">2025</option>
                    </select>
                    <p>CVV No.</p>
                    <input type="password" name="cvv" placeholder="cvv no." id="input-edit" required><br>
					<p>Total Amount</p>
					<input type="text" name="total_amount" value="<%=total_amt%>" id="input-edit" readonly><br>
                    <input type="submit" value="PAYMENT AND BOOK">
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