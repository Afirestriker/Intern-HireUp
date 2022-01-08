<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- 
	This is header file, its contain header used in /JSP/page.jsp
	NOTE: This header is not used in /JSP/User/page.jsp and /JSP/Admin/page.jsp
 -->

<!-- Header menus for /JSP/page.jsp -->
<!-- This file specify header which is used on multiple pages using <%-- <%@include page="" %> --%> tag of jsp -->

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<!-- <title>HireUp Header</title> -->
	<link rel="stylesheet" type="text/css" href="../CSS/Header.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>

	<!-- Menu Section -->
	<section id="menu">
		<nav class="menu container">
			
			<!-- HireUp icon image fetched from web -->
			<a href="#index"><img class="logo" src="../Images/HireUpIcon.png" alt="HireUpLogo-img" title="HireUp"></a>

			<ul>
				<!-- This are header, menu item -->
				<li><a href="./Index.jsp#index">Home <span class="material-icons" style="font-size: 18px;"> home </span> </a></li>
				<li><a href="./Index.jsp#about">About <span class="material-icons" style="font-size: 18px;"> info </span> </a></li>
				<li><a href="./Index.jsp#contact">Contact <span class="material-icons" style="font-size: 18px;"> add_ic_call </span> </a></li>

			<%
				if(session.getAttribute("username") == null || session.getAttribute("admin") == null)
				{
			%>
					<li><a href="Login.jsp">LogIn/SignUp <span class="material-icons" style="font-size: 18px;"> login </span> </a></li>
			<%	} %>
				
			<%	if(session.getAttribute("username") != null)
				{
			%>
					<li><a href="./User/UserIndex.jsp" title="Go To Profile" > Welcome <%= session.getAttribute("username") %> <span class="material-icons" style="font-size: 18px;" > account_circle </span></a> </li>
					
					<li><a href="./Logout.jsp" title="Logout" > Logout <span class="material-icons" style="font-size: 18px;" > logout </span></a> </li>
			<%	} %>
			
			<%	if(session.getAttribute("admin") != null)
				{
			%>
					<li><a href="./Admin/AdminIndex.jsp" title="Go To Profile" > Welcome <%= session.getAttribute("admin") %> <span class="material-icons" style="font-size: 18px;" > account_circle </span></a> </li>
					
					<li><a href="./Logout.jsp" title="Logout" > Logout <span class="material-icons" style="font-size: 18px;" > logout </span></a> </li>
			<%	} %>
				
			</ul>
		</nav>
	</section>
<!-- End of Menu  Section -->


</body>
</html>