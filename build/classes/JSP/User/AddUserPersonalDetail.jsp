<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp"%>

<!--
	This page is used for Inserting/Adding values to add in hireupv1.student_personal_detail database table
	The backend process of this page is done by AddUserAcademicDetailAction.jsp page
	
	This page is only used to take values from user.
	This page is called when user is new and login first time, in sequence
	1. AddUserPersonalDetail.jsp
	2. AddUserAcademicDetail.jsp
	3. AddUserSkillsDetail.jsp
	
	Or, directly from UserLoginAction.jsp page, where we check user profile status,
	by checking user records in three table (PersonalDetail, AcademicDetail, and Skills)
	and if records does not exist is student_personal_detail table.
	
	NOTE: Here session attribute email is used which is set in User/UserLoginAction.jsp page 
		 Also, session email prevent wrong access to this page, since session attribute email is set
		 only in UserLoginAction.jsp page that's too only if user is making login, or user profile is 
		 incomplete
 -->

<% 
	/* Print statement, to print on console, when visit to this page */
	System.out.println("\n AddUserPersonalDetail.jsp Called \n");
	
	/* Statement, get the session attribute set in UserLoginAction.jsp */
	String email = session.getAttribute("email").toString();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Add Details</title>
	
	<!-- Display image in tab -->
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	
	<!-- Link CSS File for styling this page -->
	<link rel="stylesheet" href="../../CSS/User/AddUserDetails.css">
</head>
<body>

	<section id="container">

		<a href="../Index.jsp"> <img src="../../Images/HireUpIcon.png" alt="HireUpLogo" class="logo"> </a>
		
		<h1 class="container-formheading"> Personal Details </h1>

		<div class="container-form">

			<% 
				/* IF, this page is redirected from AddUserPersonalDetailAction.jsp with msg=exception
				 * condtion is true and message in <p>...</p> is displayed
				*/
				String msg = request.getParameter("msg");
				if("exception".equals(msg))
				{
			%>
				<p> Something went wrong, Try Again!</p>
			<% }%>

			<% /* NOTE: Session (attribute="email") is already set in UserLoginAction.jsp page */ %>
			
			<form action="AddUserPersonalDetailAction.jsp" method="post">
			
				<!-- Adding Profile Image upload type=file (future work) -->
				
			    <label for="email">Email*</label> <br>
    			<input type="email" name="email" value=<%= email %> placeholder="Your email.." required readonly>
    			<br>

    			<label for="First Name">First Name*</label> <br>
    			<input type="text" name="firstname" placeholder="Your first name.." pattern="[a-zA-Z]{4,}" title="Only letters and min 4 char long" autofocus required>
    			<br>

				<label for="Last Name">Last Name*</label> <br>
    			<input type="text" name="lastname" placeholder="Your last name.." pattern="[a-zA-Z]{4,}" title="Only letters and min 4 char long" required> 
    			<br><br>
				
				<label for="Birth Date*">Birth Date*</label>
				<input type="date" name="birthdate" title="Birth Years (2000 - 1990)" min="1990-01-01" max="2000-12-31" required> 
				<br><br>

				<label for="Mobile*">Mobile*</label> <BR>
				<input type="tel" name="mobile" placeholder="+91-123-457-7890" title="Enter Indian Mobile Number (+91-123-456-7890)" pattern="[+]91-[0-9]{3}-[0-9]{3}-[0-9]{4}" required>
				<br><br>
				
				<label for="Gender">Gender*</label> <br>
    			<input type="radio" name="gender" value="M" required> <label for="male">Male</label>
    			<input type="radio" name="gender" value="F"> <label for="Female">Female</label>
    			<input type="radio" name="gender" value="O"> <label for="Other">Other</label>
    			<br><br>

				<label for="Address*">Address*</label>
    			<input type="text" name="address" placeholder="Your Address..." title="Enter Address" maxlength="300" required>
    			<br>

    			<label for="City">City*</label> <br>
    			<input type="text" name="city" placeholder="Your City..." pattern="[a-zA-Z\s]{4,}" title="Only letters and min 4 char long" required>
    			<br>

    			<label for="City">Country*</label> <br>
    			<input type="text" name="country" placeholder="Your Country..." pattern="[a-zA-Z\s]{4,}" title="Only letters and min 4 char long" required>
    			<br>

    			<label for="More About Me*">More About Me*</label> <br>
    			<textarea name="aboutme" rows="4" cols="50" placeholder="More About Me..." maxlength="500" required></textarea>

				<% /* Form Submit button, on submit its redirect to AddUserPersonalDetailAction.jsp page */ %>
    			<input type="submit" value="CONTINUE">


    		</form>
		</div>

	</section>


</body>
</html>