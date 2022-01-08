<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!--
	This page is used for Inserting/Adding values to add in hireupv1.student_academic_detail database table
	The backend process of this page is done by AddUserAcademicDetailAction.jsp page
	
	This page is only used to take values from user.
	This page is called when user is new and login first time, in seqeunce
	1. AddUserPersonalDetail.jsp
	2. AddUserAcademicDetail.jsp
	3. AddUserSkillsDetail.jsp
	
	Or, directly from UserLoginAction.jsp page, where we check user profile status,
	by checking user records in three table (PersonalDetail, AcademicDetail, and Skills)
	and if records does not exist is student_academic_detail table.
	
	NOTE: Here session attribute email is used which is set in User/UserLoginAction.jsp page 
		 Also, session email prevent wrong access to this page, since session attribute email is set
		 only in UserLoginAction.jsp page that's too only if user is making login, or user profile is 
		 incomplete
 -->


<% 
	/* Print statement, to print on console, when visit to this page */
	System.out.println("\n AddUserAcademicDetail.jsp Called \n"); 

	/* Statement, get the session attribute set in UserLoginAction.jsp */
	/* email session, also helps in avoiding user to directly naviage to this page, since
	   email is set in UserLongAction.jsp which check, if user has completed its profile details or not   
	*/
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
		
		<h1 class="container-formheading"> Academic Details </h1>

		<div class="container-form">

			<% 
				/* IF, this page is redirected from AddUserAcademicDetailAction.jsp with msg=exception
				 * condtion is true and message in <p>...</p> is displayed
				*/
				String msg = request.getParameter("msg");
				if("exception".equals(msg))
				{
			%>		
				<p> Something went wrong, Try Again!</p>
			<%  } %>
			
			<% /* NOTE: Session (attribute="email") is already set in UserLoginAction.jsp page */ %>
			<form action="AddUserAcademicDetailAction.jsp" method="post">

			    <label for="email">Email*</label> <br>
    			<input type="email" name="email" value="<%= email %>" placeholder="Your email.." required readonly> <br>

    			<label for="course">Course*</label> <br>
    			<select name="course" required>
    				<option value="">Select Course</option>
    				<option value="BBA">BBA</option>
    				<option value="BBA(CA)">BBA(CA)</option>
    				<option value="BBA(GeB)">BBA(GeB)</option>
    				<option value="BBA(IB)">BBA(IB)</option>
    			</select>

    			<br>

    			<label for="Roll. no">Roll. no*</label> <br>
    			<input type="text" name="rollno" placeholder="Your Roll no (01-99).." pattern="[0-9]{2,2}" maxlength="2" required> 
    			<br><br>

				<label for="10th University*">10th Board*</label> <br>
    			<input type="text" name="10thUniversityName" maxlength="300" placeholder="Enter SSC Board Name, Place" required>
    			<br>

    			<label for="10th School Name*">10th School Name*</label> <br>
    			<input type="text" name="10thSchoolName" maxlength="300" placeholder="Enter SSC School Name" required>
    			<br>

				<label for="10th Grade">10th Grade (%)*</label> <br>
    			<select name="10thGrade" required>
    				<option value="">Select 10th Grade</option>
    				<option value="A">A (81 - 100)</option>
    				<option value="B">B (70 - 79)</option>
    				<option value="C">C (60 - 69)</option>
    				<option value="D">D (50 - 59)</option>
    			</select>
    			<br>

    			<label for="10th Start-Pass Year*">10th Start-Pass Year*</label> <br>
    			<input type="text" name="10thStartPassYear" placeholder="1234 - 1234" pattern="[0-9]{4,4} - [0-9]{4,4}" required>
    			<br>
    			
    			<br>

    			<label for="12th University*">12th University*</label> <br>
    			<input type="text" name="12thUniversityName" maxlength="300" placeholder="Enter 12th University Name, Place" required>
    			<br>

    			<label for="12th College Name*">12th College Name*</label> <br>
    			<input type="text" name="12thCollegeName" maxlength="300" placeholder="Enter 12th School Name" required>
    			<br>

    			<label for="12th Grade">12th Grade (%)*</label> <br>
    			<select name="12thGrade" required>
    				<option value="">Select 12th Grade</option>
    				<option value="A">A (81 - 100)</option>
    				<option value="B">B (70 - 79)</option>
    				<option value="C">C (60 - 69)</option>
    				<option value="D">D (50 - 59)</option>
    			</select>
    			<br>
				
    			<label for="12th Start-Pass Year*">12th Start-Pass Year*</label> <br>
    			<input type="text" name="12thStartPassYear" placeholder="1234 - 1234" pattern="[0-9]{4,4} - [0-9]{4,4}" required>
    			<br>

    			<br>

    			<label for="College University*">College University*</label> <br>
    			<input type="text" name="collegeUniversityName" maxlength="300" placeholder="Enter College University Name, Place" required>
    			<br>

    			<label for="College Name*">College Name*</label> <br>
    			<input type="text" name="collegeName" maxlength="300" placeholder="Enter College Name" required>
    			<br>

				<label for="College Aggregate (%)">College Aggregate (%)*</label> <br>
    			<select name="collegeAggregate" required>
    				<option value="">Select College Aggregate</option>
    				<option value="A">A (81 - 100)</option>
    				<option value="B">B (70 - 79)</option>
    				<option value="C">C (60 - 69)</option>
    				<option value="D">D (50 - 59)</option>
    			</select>
				<br>
    			
    			<label for="College Start-Pass Year*">College Start-Pass Year*</label> <br>
    			<input type="text" name="collegeStartPassYear" placeholder="1234 - 1234" pattern="[0-9]{4,4} - [0-9]{4,4}" required>
    			<br><br>

				<% /* Form Submit button, on submit its redirect to AddUserAcademicDetailAction.jsp page */ %>
    			<input type="submit" value="CONTINUE">

    		</form>
		</div>

	</section>


</body>
</html>