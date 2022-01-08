<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="ForgetPassword.jsp" %>

<%
	/* Printing statement for console, which shows the navigation */
	System.out.print("\n\n ResetPassword.jsp Called");
%>

<!-- ResetPassword.jsp page to Update password -->

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Reset Password</title>
	
	<!-- Adding image to browser window tab -->
	<link rel="icon" href="../Images/HireUpIcon.png" type="image/png">
	
	<!-- Linking CSS and JavaScript file with ResetPassword.jsp -->
	<link rel="stylesheet" href="../CSS/ResetPassword.css">
	<link rel="stylesheet" href="../CSS/Login&Signup.css">
	<script src="../JS/Login&Signup.js"> </script>
</head>
<body>

	<!-- Display, HireUpIcon in top-middle of the page -->
	<a href="Index.jsp"><img class="hireupIcon" src="../Images/HireUpIcon.png"></a>
	<div class="Login-Signup-container">

		<div class="update-password">Update Password</div>

		<!-- Update password form, which redirect to ResetPasswordAction.jsp on Submit -->
		<div class="login-form">
			<form action="ResetPasswordAction.jsp" method="post">
				
				<%
				 /*
				  * Comment,
				  * Requesting Username Parameter from ForgetPasswordAction.jsp page
				  */
				  String username = session.getAttribute("uname").toString();
				%>
				
				<% 
				/* Comment
			  	 * Here, we are getting msg after executing ResetPasswordAction.jsp
			  	 * The msg is return only there is any problem in resettig password for the user
			  	 * The msg value specify what problem occurs and displays the msg accordingly
			  	 * if msg=exception -> run time exception has occur and msg is shown
			  	 * if msg=invalid -> old and new password are same
			  	*/
			  	
				  String msg = request.getParameter("msg");
				  if("exception".equals(msg))
				  {%>
					<h3 class="msg-invalid">Something went wrong, Try Again!</h3><br>
				<%} %>
				
				<%if("invalid".equals(msg))
				  {%>
					<h3 class="msg-invalid">New and Old Password cannot be same!</h3><br>
				<%} %>
				
				<%if("valid".equals(msg))
				  {%>
					<h3 class="msg-valid">Password Changed Successfully! <a href="Login.jsp">Login</a> </h3><br>
				<%} %>

				<input type="text" name="username" value=<%= username %> class="login-signup-input" readonly disabled>
				<br>
				<input type="password" name="newpassword" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Enter New Password*" id="password" class="login-signup-input" required autofocus>
				<br>
				<input type="checkbox" name="password-visibility" onclick="login_showPassword()"> Show Password

				<br><br>
				<input type="submit" name="submit" Value="Update Password" class="login-signup-button">

				<span><a href="Login.jsp"> Cancel </a></span>

			</form>
		</div>
	</div>

</body>
</html>

<% /* Adding Footer Page */ %>
<%@include file="Footer.jsp" %>
