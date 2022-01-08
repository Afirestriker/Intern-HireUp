<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!--
	This page is used for Inserting/Adding values to add on Skills Details in hireupv1.Skills database table
	The backend process of this page is done by AddUserSkillsAction.jsp page
	
	This page is only used to take values from user.
	This page is called when user is new and login first time, in seqeunce
	1. AddUserPersonalDetail.jsp
	2. AddUserAcademicDetail.jsp
	3. AddUserSkillsDetail.jsp
	
	Or, directly from UserLoginAction.jsp page, where we check user profile status,
	by checking user records in three table (PersonalDetail, AcademicDetail, and Skills)
	and if records exist is above 2 table but not in Skills table for current user.
	
	NOTE: Here session attribute email is used which is set in User/UserLoginAction.jsp page
 -->

<% 
	/* Print statement, to print on console, when visit to this page */
	System.out.println("\n AddUserSkillsDetail.jsp Called \n");
	
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
		<h1 class="container-formheading"> Profession and Extra Curriculum Skills </h1>

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
			
			<form action="AddUserSkillsDetailAction.jsp" method="post">

			    <table class="skills-table">
						
						<tr> <td colspan="2"> <p class="skills-sub-heading">Professional Skills</p> </td> </tr>
						<!-- HTML and C skills -->
						<tr>
							<td>HTML*</td>
							<td>C*</td>
						</tr>
						<tr>
							<td> <input type="number" name="html" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="c" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- CSS and C++ skills -->
						<tr>
							<td>CSS*</td>
							<td>C++*</td>
						</tr>
						<tr>
							<td> <input type="number" name="css" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="cpp" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- JavaScript and Java skills -->
						<tr>
							<td>JavaScript*</td>
							<td>Java*</td>
						</tr>
						<tr>
							<td> <input type="number" name="javaScript" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="java" placeholder="(%)" min="1" max="100" required> </td>
						</tr>


						<tr> <td colspan="2"> <p class="skills-sub-heading">Extra Curriculum Skills</p> </td> </tr>
						<!-- Sports and Photography skills -->
						<tr>
							<td>Sports*</td>
							<td>Photography*</td>
						</tr>
						<tr>
							<td> <input type="number" name="sports" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="photography" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- Animation and Social Media skills -->
						<tr>
							<td>Animation*</td>
							<td>Social Media*</td>
						</tr>
						<tr>
							<td> <input type="number" name="animation" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="socialMedia" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- Act and Art skills -->
						<tr>
							<td>Act (Drama, Dance, Music)*</td>
							<td>Art (Drawing, Painting, Cartooning)*</td>
						</tr>
						<tr>
							<td> <input type="number" name="act" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="art" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<tr>
							<td colspan="2"> <input type="submit" value="Submit"> </td>
						</tr>

					</table>

    		</form>
		
		</div>
		<!-- container-form close -->

	</section>


</body>
</html>