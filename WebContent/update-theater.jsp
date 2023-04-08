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
			String tn="",tadd="",ph="";
			int id=0;
			try{				
			/* DataBase Connection */
			int tid=Integer.parseInt(request.getParameter("t_id"));
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String query = "select * from theater_list where t_id="+tid+"";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			if (con != null) {
				PreparedStatement ps=con.prepareStatement(query);
				ResultSet rs=ps.executeQuery();
				while(rs.next()){
				id=rs.getInt(1);
				tn=rs.getString(2);
				tadd=rs.getString(3);
				ph=rs.getString(4);
				}
			}
			}catch (Exception e) {
					e.printStackTrace();
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

	<!-- Validation update-theater -->
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
			<h1>Update Theater</h1>
			 <% 
               String msg=request.getParameter("msg");
               if(msg!=null){
               %><h5 id="test"><% out.println(msg); %></h5><% 
                }
             %>
			<form action="updatetheaterser" method="post" name="addtheaterform" onSubmit="return validate();">
				<p>Theater Id</p>
				<input type="text" name="tid" value="<%=id%>" id="input-edit" readonly><br>
				<p>Theater Name</p>
				<input type="text" name="tname" value="<%=tn%>" placeholder="theater name" id="input-edit" required><br>
				<p>Theater Address</p>
				<textarea name="tadd" rows="6" placeholder="theater address" required></textarea><br>
				<p>Theater Phone Number</p>
				<input type="text" name="tph" value="<%=ph%>" placeholder="theater phone" id="input-edit" required><br>
				<input type="submit" value="UPDATE">
				<input type="reset" value="RESET">
			</form>
	</div><br><br>
</body>
</html>
