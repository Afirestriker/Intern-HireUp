<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="Error.jsp" %>

<% 
	/* This statement display a message on consle */
	System.out.print("\n\n Login.jsp called ");

	if(session.getAttribute("admin") != null)
	{
		response.sendRedirect("Admin/AdminIndex.jsp");
	}
	
	if(session.getAttribute("username") != null)
	{
		response.sendRedirect("User/UserIndex.jsp");
	}

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Welcome To HireUp</title>
	
	<!-- Comment 
		Here, we are doing three basic thing
	    1. Displaying HireUpLogo image in browser tab
	    2. Linking particular CSS file Login.css and Login&Signup.css
	    3. Linking JavaScript file for ShowPassword check-box feature
	 -->
	<link rel="icon" href="../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" href="../CSS/Login.css">
	<link rel="stylesheet" href="../CSS/Login&Signup.css">
	<script src="../JS/Login&Signup.js"> </script>
</head>
<body>

	<!-- HireUpIcon Image in page center-->
	<a href="Index.jsp"><img class="hireupIcon" src="../Images/HireUpIcon.png"></a>
	
	<div class="Login-Signup-container">
		<div class="login">Log In</div>
		<div class="signup"><a href="Signup.jsp">Singup</a></div>

		<div class="login-form">
			<form action="LoginAction.jsp" method="post">

			
			  <%
			  	/* Comment
			  	 * Here, we are getting msg after executing LoginAction.jsp
			  	 * The msg is return only there is any problem in login-in the user/admin
			  	 * The msg value specify what problem occurs
			  	 * if msg=invalid -> wrong username or password msg is shown
			  	 * if msg=exception -> run time exception has occur and msg is shown
			  	*/
			  	String msg = request.getParameter("msg");
				if("invalid".equals(msg))
				{%>
					<h3 class="msg-invalid">Wrong Username or Password!</h3><br>	
			  <%}%>
			  	
			  	<%
			  	if("notexist".equals(msg))
			  	{%>
			  		<h3 class="msg-invalid">User Does Not Exist! <a href="Signup.jsp">SignUp</a></h3><br>
			  	<%}%>
			  	
			  	<%
			  	if("exception".equals(msg))
			  	{%>
			  		<h3 class="msg-invalid">Something went Wrong, Try Again!</h3><br>
			  <%}%>

				<!-- Comment
				     This are all input field for user-name, password, check-box, and button
				     * pattern attribute is used to set validation for user-name and password
				     * The showPassword check-box called JS->login_showPassword() method which toggle between password visibility i.e type from 'password' to 'text' and vice-versa
				 -->
				<input type="text" name="username" pattern="[a-zA-Z][A-Za-z0-9_]{3,}" placeholder="Enter UserName*" title="The username must start with a letter, can contain nubmers and underscore and must be of miminum 4 character long" class="login-signup-input" required>
				<br>
				<input type="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Enter Password*" id="password" class="login-signup-input" required>
				<br>
				<input type="checkbox" name="password-visibility" onclick="login_showPassword()"> Show Password
				<br><br>
				<input type="submit" name="login" Value="Log In" class="login-signup-button">

				<!-- Link, which redirect to ForgetPassword.jsp page -->
				<span><a href="ForgetPassword.jsp"> Forget Password? </a></span>

			</form>
		</div>	
	</div>

</body>
</html>

<% /* Adding Footer Page */ %>
<%@include file="Footer.jsp" %>
