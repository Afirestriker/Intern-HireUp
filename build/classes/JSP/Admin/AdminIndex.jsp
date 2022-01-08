
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="AdminError.jsp" %>

<%
	/* Print on console, indicating the navigation of pages */
	System.out.print("\n AdminIndex.jsp called \n");

String admin = session.getAttribute("admin").toString();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Welcome Admin</title>
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" type="text/css" href="../../CSS/Admin/AdminIndex.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>

<!-- Menu Section -->
	<%@include file="AdminHeader.jsp" %>	
<!-- End of Menu  Section -->


	<div class="AdminIndex-container">
  	
  		<div class="AdminIndex-container-col-left">
    		
    		<p> Welcome Admin <br> Not, "Just An Admin"</p>
    		
    		<a href="AdminViewUserRecords.jsp"> <button>View Student Records <span class="material-icons" style="font-size:16px; margin-left: 148px;"> arrow_forward_ios </span></button> </a>
    		<br>
    		<a href="AdminViewContacts.jsp"> <button>View Messages<span class="material-icons" style="font-size:16px; margin-left: 212px;"> arrow_forward_ios </span></button> </a>
    		<br>
    		<a href="../Logout.jsp"> <button>Logout <span class="material-icons" style=" font-size: 16px; margin-left: 276px;"> arrow_forward_ios </span></button> </a>
  		</div>

  		<br>
  		<div class="AdminIndex-container-col-right">

  			<img src="../../Images/Admin/coach-speaking.jpg">
  			
  		</div>
	
	</div>

<!-- Footer Section -->
	<%@include file="../Footer.jsp" %>
<!-- Footer Section End -->

</body>
</html>