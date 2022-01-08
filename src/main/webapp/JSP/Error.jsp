<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" isErrorPage="true"%>
    
<%
	System.out.print("\n JSP/Error.jsp called \n"); 
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Error!</title>
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" type="text/css" href="../CSS/Error.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
</head>
<body>

	<div class="error-container">
		
		<img src="../Images/Error/rocket-crash-error.jpg">

		<div class="error-text">
		  
			<!-- 400 Bad Request -->
		  
			<p style="margin-bottom: 16px;">
				400 Bad Request: Something has gone wrong with your web browser in relation to your request. Please clear cookies and cache and try again. 
			</p>

			<a href="Index.jsp"><button>Back to Home Page</button></a> 
		
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
						System.out.print("\n JSP/Error.jsp Exception: " + e);
					}
				%>
			</p>
			
		</div>
		<!-- error-text close -->

	</div>
	<!-- error-container -->
	
</body>
</html>