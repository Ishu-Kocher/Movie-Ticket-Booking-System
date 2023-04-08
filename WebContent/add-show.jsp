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
      var seats=document.addshowform.seats.value;
      var m_name=document.addshowform.m_name.value;
      var t_name=document.addshowform.t_name.value;
      if(m_name=="" || m_name=="select"){
    	  alert("Please Select Movie..!!");
    	  return false;
      }
      if(t_name=="" || t_name=="select"){
    	  alert("Please Select Theater..!!");
    	  return false;
      }
      if(isNaN(seats)){
    	  alert("Number of Seats Can't Be Characters..!!");
    	  return false;
      }
      if(seats.length>3){
    	  alert("Number of Seats Can Not Be More Than 3 Digits..!!");
    	  return false;
      }else{
    	  true;
      }
    }
    </script>
</head>
<body>
	 <div class="sign-up">
                  
              <h1>Add Show</h1>
            <% 
                String msg=request.getParameter("msg");
                 if(msg!=null){
                 %><h5 id="test"><% out.println(msg); %></h5><% 
                 }
             %>  
                             
        				<form action="add-show" method="post" name="addshowform" onSubmit="return validate();">
        				<% 					
							try{	
							/* DataBase Connection */
							String url = "jdbc:oracle:thin:@localhost:1521:xe";
							String query = "select m_name from movielist";
							Class.forName("oracle.jdbc.OracleDriver");
							Connection con = DriverManager.getConnection(url, "database", "ishu");
							if (con != null){
							PreparedStatement ps=con.prepareStatement(query);
							ResultSet rs=ps.executeQuery();
							%><p>Movie<span id="sign-up-edit">Theater</span></p>
								<select name="m_name">
								<option value="select">Select</option>
							<%
								while(rs.next()){
									String m_name=rs.getString(1);
							%>
								<option value="<%=m_name%>"><%=m_name%></option>
							<%}
								}
							}catch(Exception e){
								e.printStackTrace();
								}	
						%>	       
     				</select>
     
						<% 					
							try{	
							/* DataBase Connection */
							String url = "jdbc:oracle:thin:@localhost:1521:xe";
							String query= "select t_name from theater_list";
							Class.forName("oracle.jdbc.OracleDriver");
							Connection con = DriverManager.getConnection(url, "database", "ishu");
							if (con!= null){
							PreparedStatement ps=con.prepareStatement(query);
							ResultSet rs=ps.executeQuery();
							%>
								<select name="t_name">
								<option value="select">Select</option>
							<%
								while(rs.next()){
									String t_name=rs.getString(1);
							%>
								<option value="<%=t_name%>"><%=t_name%></option>
							<%}
								}
							}catch(Exception e){
								e.printStackTrace();
								}	
						%>	       
     				</select>
			
     

            <p>Show Timing</span></p>
            <input type="time" name="start" placeholder="start time" id="input-edit" required>
            <p>Date Of Show</p>
            <input type="date" name="date" placeholder="date of show" id="input-edit" required><br>
            <p>Number Of Seats</p>
            <input type="text" name="seats" placeholder="Number of seats" id="input-edit" required><br>
            <input type="submit" value="ADD">
            <input type="reset" value="RESET">
        </form>  
        <br><br>
    </div>
</body>
</html>