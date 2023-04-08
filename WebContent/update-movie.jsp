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
			int id=0,price=0;
			String n="",c="",t="",d="",l="",dir="",cast="",img="",u="";
			try{				
			/* DataBase Connection */
			int mid=Integer.parseInt(request.getParameter("m_id"));
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String query = "select * from movielist where m_id="+mid+"";
			Class.forName("oracle.jdbc.OracleDriver");
			Connection con = DriverManager.getConnection(url, "database", "ishu");
			if (con != null) {
				PreparedStatement ps=con.prepareStatement(query);
				ResultSet rs=ps.executeQuery();
				while(rs.next()){
				id=rs.getInt(1);
				n=rs.getString(2);
				c=rs.getString(3);
				t=rs.getString(4);
				d=rs.getString(5);
				l=rs.getString(6);
				dir=rs.getString(7);
				cast=rs.getString(8);
				img=rs.getString(9);
				u=rs.getString(10);
				price=rs.getInt(11);
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
    <link rel="stylesheet" type="text/css" href="fontawesome-free-5.10.0-web/css/all.min.css">

		<!-- Validation update-movie -->
    <script>
    function validate(){
      var m_name=document.addmovieform.mname.value;
      var m_cer=document.addmovieform.cer.value;
      var m_type=document.addmovieform.type.value;
      var m_dur=document.addmovieform.dur.value;
      var m_lan=document.addmovieform.lan.value;
      var m_dir=document.addmovieform.dir.value;
      var m_cast=document.addmovieform.cast.value;
      var m_img=document.addmovieform.image.value;
      var m_price=document.addmovieform.price.value;
      if(!isNaN(m_name)){
    	  alert("Movie Name Can't Be Numeric..!!");
    	  return false;
      }
      if(m_name.length>20){
    	  alert("Movie Name Can Not Be More Than 20 Digits..!!");
    	  return false;
      }
      if(!isNaN(m_cer)){
    	  alert("Movie Certificate Can't Be Numeric..!!");
    	  return false;
      }
      if(m_cer.length>5){
    	  alert("Movie Certificate Can Not Be More Than 5 Digits..!!");
    	  return false;
      }
      if(!isNaN(m_type)){
    	  alert("Movie Type Can't Be Numeric..!!");
    	  return false;
      }
      if(m_type.length>10){
    	  alert("Movie Type Can Not Be More Than 10 Digits..!!");
    	  return false;
      }
      if(isNaN(m_dur)){
    	  alert("Movie Duration Can't Be Characters..!!");
    	  return false;
      }
      if(m_dur.length>5){
    	  alert("Movie Duration Can Not Be More Than 5 Digits..!!");
    	  return false;
      }
      if(!isNaN(m_lan)){
    	  alert("Movie Language Can't Be Numeric..!!");
    	  return false;
      }
      if(m_lan.length>10){
    	  alert("Movie Language Can Not Be More Than 10 Digits..!!");
    	  return false;
      }
      if(!isNaN(m_dir)){
    	  alert("Movie Director Name Can't Be Numeric..!!");
    	  return false;
      }
      if(m_dir.length>20){
    	  alert("Movie Director Name Can Not Be More Than 20 Digits..!!");
    	  return false;
      }
      if(!isNaN(m_cast)){
    	  alert("Movie Cast Name Can't Be Numeric..!!");
    	  return false;
      }
      if(m_cast.length>30){
    	  alert("Movie Cast Name Can Not Be More Than 30 Digits..!!");
    	  return false;
      }
      if(m_img.length>30){
    	  alert("Image Name Can Not Be More Than 30 Digits..!!");
    	  return false;
      }
      if(isNaN(m_price)){
    	  alert("Movie Price Can't Be Characters..!!");
    	  return false;
      }
      if(m_price.length>5){
    	  alert("Movie Price Can Not Be More Than 5 Digits..!!");
    	  return false;
      } 
      else{
    	  return true;
      }
    
    }
    </script>
</head>
<body>

				<div class="add-movie-mainContainer">

                    <div class="sign-up">
                        <h1>Edit Movie</h1> 
                         <% 
                        	String msg=request.getParameter("msg");
                        	if(msg!=null){
                        	%><h5 id="test"><% out.println(msg); %></h5><% 
                        	}
                        %>
                            <form action="updatemovieser" method="post" name="addmovieform" onSubmit="return validate();">
                            	<p>Movie Id</p>
                            	<input type="text" name="mid" value="<%=id%>" readonly><br>
                                <p>Movie Name<span id="sign-up-edit">Certificate</span></p>
                                <input type="text" name="mname" value="<%=n%>" placeholder="Movie Name" required>
                                <input type="text" name="cer" value="<%=c%>" placeholder="Certificate" required><br>
                                <p>Type<span id="add-movie-edit">Duration</span></p>
                                <input type="text" name="type" value="<%=t%>" placeholder="Type" required>
                                <input type="text" name="dur" value="<%=d%>" placeholder="Duration" required><br>
                                 <p>Language<span id="sign-up-edit">Director</span></p>
                                <input type="text" name="lan" value="<%=l%>" placeholder="Language" required>
                                <input type="text" name="dir" value="<%=dir%>" placeholder="Director" required><br>
                                
                                <p>Cast</p>
                                <textarea placeholder="cast" name="cast" rows="4" required></textarea><br>
                                <p>Youtube Link</p>
                                <input type="text" name="y-link" value="<%=u%>" id="input-edit" placeholder="Youtube link" required><br>
                                
                                <p>Image</p>
                                <input type="file" name="image" id="input-edit" required><br>
                                <p>Price</p>
                                <input type="text" name="price" value="<%=price%>" id="input-edit" placeholder="Price" required><br>
                                <input type="submit" value="UPDATE">
                                <input type="reset" value="RESET">
                            </form>  
                    </div>



                </div>    
            


</body>
</html>