<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="Error.jsp" %>

<% 
	/* This statement display a message on consle */
	System.out.print("\n\n Signup.jsp called");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Welcome To HireUp</title>

	<!-- Comment 
		Here, we are doing three basic thing
	    1. Displaying HireUpLogo image in browser tab
	    2. Linking particular CSS file Signup.css and Login&Signup.css
	    3. Linking JavaScript file for ShowPassword check-box feature
	 -->
	<link rel="icon" href="../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" href="../CSS/Signup.css">
	<link rel="stylesheet" href="../CSS/Login&Signup.css">
	<script src="../JS/Login&Signup.js"> </script>
</head>
<body>

	<!-- HireUpIcon Image in page center-->
	<a href="Index.jsp"><img class="hireupIcon" src="../Images/HireUpIcon.png"></a>

	<div class="Login-Signup-container">
		
		<div class="login"><a href="Login.jsp">Log In</a></div>
		<div class="signup">Sign Up</div>

		<div class="signup-form">

			<form action="SignupAction.jsp" method="post">
				
				<% 
				/* Comment
			  	 * Here, we are getting msg after executing SignupAction.jsp page
			  	 * The msg return the status of singup whether it is successful or not
			  	*/
					String msg = request.getParameter("msg");
				
	    			/* 
	    			 * msg is in parenthesis, since we are getting its value after signupAction.jsp page is called
	    			 * if we put msg as msg.equals("valid") it will give error as msg is NULL.
	    			*/
					if("valid".equals(msg))
					{%>
						<h3 class="msg-valid">Signup Successful! <a href="Login.jsp">Login</a> </h3><br>	
				  <%}%>
				
				 <% if("invalid".equals(msg))
					{%>
						<h3 class="msg-invalid">Email / Username Already Exists!</h3><br>
				  <%}%>
				
				<% if("exception".equals(msg))
				   {%>
						<h3 class="msg-invalid">Something Went Wrong! Try Again</h3><br>
				  <%}%>

				<!-- Comment
				     This are all input field for email, user-name, password, check-box, and button
				     * pattern attribute is used to set validation for user-name and password
				     * The showPassword check-box called JS->login_showPassword() method which toggle between password visibility i.e type from 'password' to 'text' and vice-versa
				 -->
				<input type="email" name="email" placeholder="Your Email Address*" class="login-signup-input" required>
				<br>
				<input type="text" name="username" pattern="[a-zA-Z][A-Za-z0-9_]{3,}" placeholder="Enter UserName*" title="The username must start with a letter, can contain nubmers and underscore and must be of miminum 4 character long" class="login-signup-input" required>
				<br>
				<input type="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Enter Password*" id="p1password" class="login-signup-input" required>
				<br>
				<input type="checkbox" name="showPassword" onclick="signup_showPassword()"> Show Password
				<br><br>
				<input type="submit" name="signup" value="Sign Up" class="login-signup-button">
			</form>
			
			<p style="color: red;"> NOTE: Email and Username can't be changed</p>
			
		</div>
		
	</div>
	

</body>
</html>

<% /* Adding Footer Page */ %>
<%@include file="Footer.jsp" %>
