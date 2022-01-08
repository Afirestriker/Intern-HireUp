<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="AdminError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	Here, Admin is adding the detail of the company who has hired the specific student, 
	Details like
		1. Company Name
		2. Joining Date
		3. Package
		4. Offer Letter Recieved / Not
 -->


<%
	/* Print on console, indicating the navigation of pages */
	System.out.print("\n AdminAddHiredDetail.jsp called \n");
	
	/* session attribute "admin" is set only, in LoginAction.jsp page, only when admin login,
	   credentials are matched.
	   Its also helps, in preventing unauthorised access to admin pages
	*/
	String admin = session.getAttribute("admin").toString();

	/* 
	   Collecting paramete passed to this page, from AdminAddHiredDetail.jsp page,
	   onClick of 'Mark As Not-Selected' Button
	*/
	
	String stuEmail = request.getParameter("stuEmail");
	String hireUpStatus = request.getParameter("hireUpStatus");
	
	System.out.println("\n AddDetail HireUpStatus: " + hireUpStatus + "\n");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>Add User Hired Company Details</title>
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" href="../../CSS/Admin/AdminAddHiredDetail.css">
</head>
<body>

	<section id="add-hired-detail-container">

		<a href="../../Index.jsp"> <img src="../../Images/HireUpIcon.png" alt="HireUpLogo" class="logo"> </a>
		<h1 class="formheading"> Add User Hired Company Detail </h1>

		<div class="add-detail-form-container">

			<% 
				/* IF, this page is redirected from AdminUpdateHireUpStatus.jsp with msg=exception
				 * condtion is true and message in <p>...</p> is displayed
				*/
				String msg = request.getParameter("msg");
				if("exception".equals(msg))
				{
			%>		
				<p> Something went wrong, Try Again!</p>
			<%  } %>
			
			<% 
				if("insertError".equals(msg))
				{
			%>		
				<p> Error in Inserting Data, Try Again. </p>
			<%  } %>

			<form action="AdminUpdateHireUpStatus.jsp" method="post">

				<table>
				
				<!-- Row 1-2 Email -->
					<tr>
						<td>
							<label for="Student email">Student Email*</label>
						</td>
					</tr>
					<tr>
						<td>
							<input type="email" name="stuEmail" placeholder="Your email..Readonly" value="<%= stuEmail %>" required readonly>
						</td>
					</tr>
					
					<tr> <td> <input type="hidden" name="hireUpStatus" value="<%= hireUpStatus %>" required readonly > </td> </tr>
					
				<!-- Row 3-4 Company Name -->
					<tr>
						<td>
							<label for="Company Name*"> Company Name </label>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="companyName" placeholder="Enter Company Name" required>
						</td>
					</tr>

				<!-- Row 5-6 Joining Date -->
					<tr>
						<td>
							<label for="Joining Date*"> Joining Date* </label>
						</td>
					</tr>
					<tr>
						<td>
							<input type="date" name="joiningDate" title="Select Joining Date" min="2021-01-01" required>
						</td>
					</tr>

				<!-- Row 7-8 Package -->
					<tr>
						<td>
							<label for="Package*"> Package* </label>
						</td>
					</tr>
					<tr>
						<td>
							<input type="text" name="package" placeholder="Enter Package (in lakh) eg 1.0, 1.5, etc" pattern="[0-9]{1,2}.[0-9]{1,2}" required>
						</td>
					</tr>	

				<!-- Row 9-10 Offer Letter -->
					<tr>
						<td>
							<label for="Offer Letter Recieved*"> Offer Letter Recieved* </label>
						</td>
					</tr>
					<tr>
						<td>
							<select name="offerLetterStatus" required>
								<option value="YES"> YES </option>
							</select>
						</td>
					</tr>

					<tr>
						<td>
							<input type="submit" value="CONTINUE">
						</td>
					</tr>

				</table>

    		</form>
		
		</div>
		<!-- container-form close -->

	</section>
	

</body>
</html>