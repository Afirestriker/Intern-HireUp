<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isErrorPage="true"%>
    
<% 
	System.out.print("\n UserError.jsp called \n"); 
	
	/* This is erro page, whenever any error occurs after user login,
	 * user is redirected to this page
	*/

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>User Error!</title>
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" type="text/css" href="../../CSS/User/UserError.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body bgcolor="">
	
	<div class="error-container">
		
		<img src="../../Images/Error/rocket-crash-error.jpg">

		<!-- If session equals NULL -->
		<!-- 401 Unauthorized Error -->
		<div class="error-text">
		
		  <%
		 	if(session.getAttribute("username") == null)
		 	{
		  %>
				<p>
					401 Unauthorized: User login is required to access this page
				</p>
				<br>
				<a href="../Login.jsp"><button>Login To Continue</button></a>
			<%}%>		 

			<!-- If Session is not NULL, exception is thrown -->
			<!-- 400 Bad Request -->
		   
		  <%
		 	if(session.getAttribute("username") != null)
		 	{
		  %>
				<p style="margin-bottom: 16px;">
					400 Bad Request: Something has gone wrong with your web browser in relation to your request. Plase clear cookies and cache and try again. 
				</p>
	
				<a href="UserIndex.jsp"><button>Back to Home Page</button></a> 
			
				<p class="error-message"> 
					<span class="material-icons"> error_outline </span> 
					Actual Error:
					<%
						try
						{
					%>
				 			<%= exception.getMessage() %>
					<%
						} /* try block close */
						catch(Exception e)
						{
							System.out.print("\n Admin/AdminError.jsp Exception: " + e);
						}
					%>
				
				</p>
		 <% } %>
		
		</div>
		<!-- error-text close -->

	</div>
	<!-- error-container -->	
	
</body>
</html>