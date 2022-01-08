<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="Error.jsp"%>

<% 
	/* This statement display a message on consle */
	System.out.print("\n\n ForgetPassword.jsp called ");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

	<!-- Comment 
		Here, we are doing two basic thing
	    1. Displaying HireUpLogo image in browser tab
	    2. Linking particular CSS file ForgetPassword.css and Login&Signup.css
	 -->
	<title>Reset Password</title>
	<link rel="icon" href="../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" href="../CSS/ForgetPassword.css">
	<link rel="stylesheet" href="../CSS/Login&Signup.css">
</head>
<body>

	<a href="Index.jsp"><img class="hireupIcon" src="../Images/HireUpIcon.png"></a>
	<div class="Login-Signup-container">

		<div class="Verify-User">Verify User</div>

		<div class="login-form">
			<form action="ForgetPasswordAction.jsp" method="post">
				
				
				<%
					/* Comment
				  	 * Here, we are getting msg after executing ForgetPasswordAction.jsp
				  	 * The msg is return only there is any problem in username verification
				  	 * The msg value specify what problem occurs
				  	 * if msg=exception -> run time exception has occur and msg is shown
				  	 * if msg=invalid -> user with given username does not exist
				  	 * if msg=invalidMatch -> email and username does not match in one account
				  	*/
					String msg = request.getParameter("msg");
					
					if("exception".equals(msg))
					{%>
						<h3 class="msg-invalid">Something Went Wrong, Try Again!</h3><br>
				  <%}%>
				
				<%
				if("invalid".equals(msg))
					{%>
						<h3 class="msg-invalid">User does not exit, Sing up first!</h3><br>
				  <%}%>
				  
				<%
				if("invalidMatch".equals(msg))
					{%>
						<h3 class="msg-invalid">Given Email is not registered with this Username!</h3><br>
				  <%}%>

				<!-- 
				   Forget Password form with same validation as given in login and signup page
				 -->				  
				<input type="text" name="username" pattern="[a-zA-Z][A-Za-z0-9_]{3,}" placeholder="Enter UserName*" title="The username must start with a letter, can contain nubmers and underscore and must be of miminum 4 character long" class="login-signup-input" required>
				<br>
				<input type="email" name="email" placeholder="Your Registered Email Address*" class="login-signup-input" required>
				<br><br>
				<input type="submit" name="resetpassword" Value="Reset Password" class="login-signup-button">

				<span><a href="Login.jsp"> Back to Login </a></span>

			</form>
		</div>	
	</div>

</body>
</html>

<% /* Adding Footer Page */ %>
<%@include file="Footer.jsp" %>
