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
</head>
<frameset rows="15%,*" border="3">
	<frame name="frame1" src="admin-header.jsp" noresize="0"></frame>
	<frameset cols="16%,*" border="3">
		<frame name="frame2" src="admin-navigation.jsp" noresize="0"></frame>
		<frame name="frame3" src="admin-welcome.jsp"></frame>
	</frameset>
</frameset>
</html>