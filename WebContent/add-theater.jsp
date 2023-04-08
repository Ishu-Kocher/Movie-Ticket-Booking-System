<% 
	String admin_username="";
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	if(session.getAttribute("admin-username")==null){
		response.sendRedirect("admin-login.jsp");
	}else{
		admin_username=(String)session.getAttribute("admin-username");
	}
%>
<!DOCTYPE html>
<html>
<head>
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

	<!-- Validation add-theater -->
    <script>
    function validate(){
      var tname=document.addtheaterform.tname.value;
      var tadd=document.addtheaterform.tadd.value;
      var tph=document.addtheaterform.tph.value;
      if(!isNaN(tname)){
    	  alert("Theater Name Can't Be Numeric..!!");
    	  return false;
      }
      if(tname.length>20){
    	  alert("Theater Name Can Not Be More Than 20 Digits..!!");
    	  return false;
      }
      if(!isNaN(tadd)){
    	  alert("Theater Address Can't Be Numeric..!!");
    	  return false;
      }
      if(tadd.length>20){
    	  alert("Theater Address Can Not Be More Than 20 Digits..!!");
    	  return false;
      }
      if(isNaN(tph)){
    	  alert("Phone Number Can't Be Characters..!!");
    	  return false;
      }
      if(tph.length>10 || tph.length<10){
      	alert("Phone Number Invalid..!!");
      	return false;
      }
      else{
    	  true;
      }
    }
    </script>
</head>
<body>
	<div class="sign-up">
			<h1>Add Theater</h1>
			 <% 
               String msg=request.getParameter("msg");
               if(msg!=null){
               %><h5 id="test"><% out.println(msg); %></h5><% 
                }
             %>
			<form action="addtheater" name="addtheaterform" method="post" onSubmit="return validate();">
				<p>Theater Name</p>
				<input type="text" name="tname" placeholder="theater name" id="input-edit" required><br>
				<p>Theater Address</p>
				<textarea name="tadd" rows="6" placeholder="theater address" required></textarea><br>
				<p>Theater Phone Number</p>
				<input type="text" name="tph" placeholder="theater phone" id="input-edit" required><br>
				<input type="submit" value="ADD">
				<input type="reset" value="RESET">
			</form>
	</div><br><br>
</body>
</html>