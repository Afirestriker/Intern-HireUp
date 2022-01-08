<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp"%>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>


<!-- This is resume file, its shows resume -->
<% 
	/* Print on console, Indicating the page navigation */
	System.out.print("\n UserResume.jsp Called \n");

	/* Fetching session attribute username, using which the records is fetch from hireupv1 database */
	String username = session.getAttribute("username").toString();
%>

<%!
	/* This is declaration JSP tag for declaring variables what will be access in whole page
	   i.e ouside service() method and are same as class variable
	*/
	
	/* Declared variable to store student_personal_detail */
	String stuemail = null;
	String firstname = null;
	String lastname = null;
	String birthdate = null;
	int age;
	String mobile = null;
	String gender = null;
	String address = null;
	String city = null;
	String country = null;
	String aboutme = null;
	
	/* Declared variable to store student_academic_detail */
	int rollno;
	String course = null;
	
	String university10th = null;
	String schoolName10th = null;
	String grade10th = null;
	String startPassYear10th = null;
	
	String university12th = null;
	String collegeName12th = null;
	String grade12th = null;
	String startPassYear12th = null;
	
	String collegeUniversity = null;
	String collegeName = null;
	String collegeAggregate = null;
	String collegeStartPassYear = null;
	
	/* Declare variable for storing skills detail */
	int html;
	int css;
	int javaScript;
	int c;
	int cpp;
	int java;
	int sports;
	int animation;
	int act;
	int photography;
	int socialMedia;
	int art;
	
/* close JSP Declaration tag */ %>


<% /* Opne JSP scrriplet tag */

	/* Java Logic for making connection with JDBC - MySQL
	 * Fetching needed details from
	   1. Student Personal Detail Table
	   2. Student Academic Detail Table
	   3. Skills table
	   
	 * Store this values in global varialbe declared inside 'declaration JSP tag'
	 * And display details fetched from database for particualr user in Resume Page
	*/
	
	try{	
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		
		/* Validating User Details,
		 * Checking if current user record, exist in all three table of hireupv1 database
		   1. student_personal_detail
		   2. student_academic_detail
		   3. skills
		 
		 * Check if student data exist in student_personal_detail
		 * if yes, check next if student data exist in student_academic_detail
		 * if yes, check next if student records exist in skills table
		 * if yes in all three condition, then display UserSettings.jsp page content
		 
		 * If student data does not exist any of this table,
		   then redirect UserLoginAction.jsp page,
		   As, this mean that student has not completed his/her login process/data entry.
		 */
		 
		String checkDetailInPersonalDetailTable = "SELECT COUNT(stuemail) FROM student_personal_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstCheckPersonalDetail = con.prepareStatement(checkDetailInPersonalDetailTable);
		pstCheckPersonalDetail.setString(1, username);
		ResultSet rsSPD = pstCheckPersonalDetail.executeQuery();
		while(rsSPD.next())
		{
			if(rsSPD.getInt(1) == 0)
			{
				response.sendRedirect("UserLoginAction.jsp");
			}
		}
		/* checkDetailInPersonalDetailTable close */

		/* Check if student record exist in student_academic_detail database table
		 * If no, then redirect to UserLoginAction.jsp
		 * If Yes, then go to next
		*/
		String checkDetailInAcademicDetailTable = "SELECT COUNT(stuemail) FROM student_academic_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstCheckAcademicDetail = con.prepareStatement(checkDetailInAcademicDetailTable);
		pstCheckAcademicDetail.setString(1, username);
		ResultSet rsSAD = pstCheckAcademicDetail.executeQuery();
		while(rsSAD.next())
		{
			if(rsSAD.getInt(1) == 0)
			{
				response.sendRedirect("UserLoginAction.jsp");
			}
		}
		/* checkDetailInAcademicDetailTable close */
		
		
		/* Check Skills table if records exist for current user or not */
		String checkSkillsDetails = "SELECT COUNT(stuemail) FROM skills WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstCheckSkillsDetails = con.prepareStatement(checkSkillsDetails);
		pstCheckSkillsDetails.setString(1, username);
		ResultSet rsCheckSkills = pstCheckSkillsDetails.executeQuery();
		while(rsCheckSkills.next())
		{
			if(rsCheckSkills.getInt(1) == 0)
			{
				response.sendRedirect("UserLoginAction.jsp");
			}
		}
		/* closed, Check Skills table records exist for current user or not*/

		
		/* 
		 * console comes here, only if student recored exist in
			1. student_personal_detail table
			2. student_academic_detail table
			3. skills table
		 */
		/* fetching student recors from student_personal_detail table and display on the page */
		String fetchedSPD = "SELECT * FROM student_personal_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstfetchSPD = con.prepareStatement(fetchedSPD);
		pstfetchSPD.setString(1, username);
		ResultSet rsfetchSPD = pstfetchSPD.executeQuery();
		while(rsfetchSPD.next())
		{
			stuemail = rsfetchSPD.getString("stuemail");
			firstname = rsfetchSPD.getString("stufirstname");
			lastname = rsfetchSPD.getString("stulastname");
			birthdate = rsfetchSPD.getString("stubirthdate");
			age = rsfetchSPD.getInt("stuage");
			gender = rsfetchSPD.getString("stugender");
			mobile = rsfetchSPD.getString("stumobile");
			address = rsfetchSPD.getString("stuaddress");
			city = rsfetchSPD.getString("stucity");
			country = rsfetchSPD.getString("stucountry");
			aboutme = rsfetchSPD.getString("stuabout");
		
			/* System.out.print("\n" + email + "\n" + firstname + "\n" + lastname + "\n" + birthdate + "\n" + age + "\n" + gender + "\n" + address + "\n" + city + "\n" + country + "\n" + aboutme + "\n"); */
		
		}
		/* operation close for fetching details of user from studetn_personal_detail database table */
		
		   /* fetching student recors from student_academic_detail table and display on the page */
		String fetchedSAD = "SELECT * FROM student_academic_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstfetchSAD = con.prepareStatement(fetchedSAD);
		pstfetchSAD.setString(1, username);
		ResultSet rsfetchSAD = pstfetchSAD.executeQuery();
		while(rsfetchSAD.next())
		{
			rollno = rsfetchSAD.getInt("sturollno");
			course = rsfetchSAD.getString("stucourse");
			
			university10th = rsfetchSAD.getString("10th_university_name");
			schoolName10th = rsfetchSAD.getString("10th_school_name");
			grade10th = rsfetchSAD.getString("10th_grade");
			startPassYear10th = rsfetchSAD.getString("10th_start_pass_year");
			
			university12th = rsfetchSAD.getString("12th_university_name");
			collegeName12th = rsfetchSAD.getString("12th_college_name");
			grade12th = rsfetchSAD.getString("12th_grade");
			startPassYear12th = rsfetchSAD.getString("12th_start_pass_year");
			
			collegeUniversity = rsfetchSAD.getString("college_university_name");
			collegeName = rsfetchSAD.getString("college_name");
			collegeAggregate = rsfetchSAD.getString("college_aggregate");
			collegeStartPassYear = rsfetchSAD.getString("college_start_pass_year");
		
			/* 
			 System.out.print("\n" + username + "\n" + rollno + "\n" + course + "\n");
			 System.out.print("university10th" + "\n" + schoolName10th + "\n" + grade10th + "\n" + startPassYear10th +  "\n");
			 System.out.print("university12th + "\n" + collegeName12th + "\n" + grade12th + "\n" + startPassYear12th +  "\n"); 
			 System.out.print("collegeUniversity + "\n" + collegeName + "\n" + collegeaggregate + "\n" + collegeStartPassYear +  "\n");  
			*/
		
		}
		/* operation close for fetching details of user from student_academic_detail database table */
		
		
		/* fetching student recors from hireupv1.skills table and display on the page */
		String fetchSkills = "SELECT * FROM skills WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstSkills = con.prepareStatement(fetchSkills);
		pstSkills.setString(1, username);
		ResultSet rsSkills = pstSkills.executeQuery();
		while(rsSkills.next())
		{
			html = rsSkills.getInt("html");
			css = rsSkills.getInt("css");
			javaScript = rsSkills.getInt("javaScript");
			c = rsSkills.getInt("c");
			cpp = rsSkills.getInt("cpp");
			java = rsSkills.getInt("java");
			sports = rsSkills.getInt("sports");
			animation = rsSkills.getInt("animation");
			act = rsSkills.getInt("act");
			photography = rsSkills.getInt("photography");
			socialMedia = rsSkills.getInt("socialMedia");
			art = rsSkills.getInt("art");
			
		}
		/* operation close for fetching details of user from skills table */


		
	} /* try block close */
	catch(Exception e)
	{
		System.out.println("\n UserResume.jsp Exception: " + e);
	} /* catch block close */


/* Java Logic Ends Here */ %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title> <%= username %> Resume</title>
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" type="text/css" href="../../CSS/User/UserResume.css">
</head>

<body>

<!-- Menu Section -->
	<%@include file="UserHeader.jsp" %>	
<!-- End of Menu  Section -->


	<div class="UserResume-container">

		<div class="resume-design">
			
			<div class="resume-header">
				
				<img height="200px" src="../../Images/HireUpIcon.png">

				<div class="text-content">
					<p class="user-name"> <%= firstname + " " + lastname %> </p>
					<p class="user-profession"> <%= course %> </p>

					<a href="#"><button onclick="window.print()">Download CV</button></a>
				</div>
				<!-- text-content -->

			</div>
			<!-- resume-header close -->

			<!-- Resume About section -->
			<div class="resume-about">
				
				<h3 class="resume-sec-title">About Me</h3>

				<div class="personal-info">
					<p>
						<%= aboutme %>
					</p>				
					
					<table>
						<tr>
							<th>Age</th>
							<td> <%= age %> </td>
						</tr>

						<tr>
							<th>Email</th>
							<td> <%= stuemail %> </td>
						</tr>

						<tr>
							<th>Phone</th>
							<td> <%= mobile %> </td>
						</tr>

						<tr>
							<th>Address</th>
							<td> <%= address + ", " + city + ", " + country %> </td>
						</tr>
					</table>

				</div>
				<!-- personal-info close -->
			</div>
			<!-- resume-about close -->
	
			<!-- Resume Education Details -->
			<div class="resume-education">
				
				<h3 class="resume-sec-title">Education</h3>

				<div class="edu-details">
					
					<p class="edu-university"> <%= collegeUniversity %> </p>

					<div class="edu-degree-details">
						<p class="edu-degree-name"> <%= collegeName %> </p>
						<p class="edu-degree-grade"> Grade: '<%= collegeAggregate %>'</p>
						<p class="edu-start-pass-year"> <%= collegeStartPassYear %> </p>
					</div>

					<p class="edu-university"> <%= university12th %> </p>

					<div class="edu-degree-details">
						<p class="edu-degree-name"> <%= collegeName12th %> </p>
						<p class="edu-degree-grade"> Grade: '<%= grade12th %>'</p>
						<p class="edu-start-pass-year"> <%= startPassYear12th %> </p>
					</div>

					<p class="edu-university"> <%= university10th %> </p>

					<div class="edu-degree-details">
						<p class="edu-degree-name"> <%= schoolName10th %> </p>
						<p class="edu-degree-grade"> Grade: '<%= grade10th %>'</p>
						<p class="edu-start-pass-year"> <%= startPassYear10th %> </p>
					</div>

				</div>
				<!-- edu-details close -->

			</div>
			<!-- resume-education close -->

			<!-- Resume Profession Skills -->
			<div class="resume-professional-skills">
				<h3 class="resume-sec-title">Professional Skills</h3>

				<table>
					<tr>
						<td>HTML</td>
						<td>C</td>
					</tr>

					<tr>
						<td> <div class="bar"> <div class="green" style="background-color: #6c9dd4; width: <%= html %>%;"></div> </div> </td>
						<td> <div class="bar"> <div class="green" style="width: <%= c %>%;"></div> </div> </td>
					</tr>

					<tr>
						<td>CSS</td>
						<td>C++</td>
					</tr>

					<tr>
						<td> <div class="bar"> <div class="green" style="background-color: #6c9dd4; width: <%= css %>%;"></div> </div> </td>
						<td> <div class="bar"> <div class="green" style="width: <%= cpp %>%;"></div> </div> </td>
					</tr>

					<tr>
						<td>JavaScript</td>
						<td>Java</td>
					</tr>

					<tr>
						<td> <div class="bar"> <div class="green" style="background-color: #6c9dd4; width: <%= javaScript %>%;"></div> </div> </td>
						<td> <div class="bar"> <div class="green" style="width: <%= java %>%;"></div> </div> </td>
					</tr>
				</table>

			</div>
			<!-- resume-professional-skills close -->

			<!-- Resume Extra Curriculum Activity -->
			<div class="resume-extra-activity">
				<h3 class="resume-sec-title">Extra Curriculum Activity</h3>

				<table>
					<tr>
						<td>Sports</td>
						<td>Animation</td>
					</tr>

					<tr>
						<td> <div class="bar"> <div class="green" style="background-color: #eba236; width: <%= sports %>%;"></div> </div> </td>
						<td> <div class="bar"> <div class="green" style="background-color: #2dbfc4; width: <%= animation %>%;"></div> </div> </td>
					</tr>

					<tr>
						<td>Photography</td>
						<td>Social Media</td>
					</tr>

					<tr>
						<td> <div class="bar"> <div class="green" style="background-color: #eba236; width: <%= photography %>%;"></div> </div> </td>
						<td> <div class="bar"> <div class="green" style="background-color: #2dbfc4; width: <%= socialMedia %>%;"></div> </div> </td>
					</tr>

					<tr>
						<td>Act (Drama, Dance, Music)</td>
						<td>Art (Drawing, Painting, Cartooning)</td>
					</tr>

					<tr>
						<td> <div class="bar"> <div class="green" style="background-color: #eba236; width: <%= act %>%;"></div> </div> </td>
						<td> <div class="bar"> <div class="green" style="background-color: #2dbfc4; width: <%= art %>%;"></div> </div> </td>
					</tr>
				</table>

			</div>
			<!-- resume-extra-activity close -->

		</div>
		<!-- resume-design close -->


	</div>
	<!-- UserResume-container close -->

<!-- Footer Section -->
	<%@include file="../Footer.jsp" %>
<!-- Footer Section End -->


</body>
</html>