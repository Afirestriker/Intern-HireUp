<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	This is user settings page, where user enter his/her updated details such as,
	* Update Personal Details
	* Update Academic Details
	* Update Skills Table
	* Update/Change Password
	* Delete Account
	
 -->

<% 
	/* Print message on console, indicating which page is visited */
	System.out.print("\n UserSettings.jsp page called \n"); 
	String username = session.getAttribute("username").toString();
%>

<%!
	/* Declare variables for storing student_personal_detail and student_academic_detail information */
	String email = null;
	
	/* student_personal_detail storage variables */
	String firstname = null;
	String lastname = null;
	String birthdate = null;
	String gender = null;
	String mobile = null;
	String address = null;
	String city = null;
	String country = null;
	String about = null;
	
	/* student_academic_detail storage variable */
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

	/* Student Skills storage variable */
		/* Professional skills */
		int html = 0;
		int css = 0;
		int javaScript = 0;
		int c = 0;
		int cpp = 0;
		int java = 0;
	
		/* Extra Curriculum Activity */
		int sports = 0;
		int animation = 0;
		int act = 0;
		int photography = 0;
		int socialMedia = 0;
		int art = 0;

%>


<%
	/* Before Showing page content
	 * Make JDBC conection and check if user details are added in student_personal_detail, student_academic_detail, and skills table or not
	   If not, then redirect to UserLoginAction.jsp page
	   If yes, then fetched details from the tables and show them in the form fields
	 */
try{
	
	/* 
	 * Make DBMS connection,
	 * class DbConnection belongs to hireupdb package 
	 * getConnection() is a static method of DbConnection which return connection object 
	 */
	Connection con = DbConnection.getConnection();

	/* First, check if student data exist in student_personal_detail
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
	ResultSet rs1 = pstCheckPersonalDetail.executeQuery();
	while(rs1.next())
	{
		if(rs1.getInt(1) == 0)
		{
			response.sendRedirect("UserLoginAction.jsp");
		}
	}
	/* checkDetailInPersonalDetailTable close */

	/* Check if student record exist in student_acadmic_detail database table
	 * If no, then redirect to UserLoginAction.jsp
	 * If Yes, then go to next
	*/
	String checkDetailInAcademicDetailTable = "SELECT COUNT(stuemail) FROM student_academic_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
	PreparedStatement pstCheckAcademicDetail = con.prepareStatement(checkDetailInAcademicDetailTable);
	pstCheckAcademicDetail.setString(1, username);
	ResultSet rs2 = pstCheckAcademicDetail.executeQuery();
	while(rs2.next())
	{
		if(rs2.getInt(1) == 0)
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
	PreparedStatement pst3 = con.prepareStatement(fetchedSPD);
	pst3.setString(1, username);
	ResultSet rs3 = pst3.executeQuery();
	while(rs3.next())
	{
		email = rs3.getString("stuemail");
		firstname = rs3.getString("stufirstname");
		lastname = rs3.getString("stulastname");
		birthdate = rs3.getString("stubirthdate");
		gender = rs3.getString("stugender");
		mobile = rs3.getString("stumobile");
		address = rs3.getString("stuaddress");
		city = rs3.getString("stucity");
		country = rs3.getString("stucountry");
		about = rs3.getString("stuabout");
	}
	/* operation close for fetching details of user from studetn_personal_detail database table */
	
	/* System.out.print("\n" + username + "\n" + firstname + "\n" + lastname + "\n" + birthdate + "\n" + age + "\n" + gender + "\n" + address + "\n" + city + "\n" + country + "\n" + about + "\n"); */
	

   /* fetching student recors from student_academic_detail table and display on the page */
	String fetchedSAD = "SELECT * FROM student_academic_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
	PreparedStatement pst4 = con.prepareStatement(fetchedSAD);
	pst4.setString(1, username);
	ResultSet rs4 = pst4.executeQuery();
	while(rs4.next())
	{
		rollno = rs4.getInt("sturollno");
		course = rs4.getString("stucourse");
		
		university10th = rs4.getString("10th_university_name");
		schoolName10th = rs4.getString("10th_school_name");
		grade10th = rs4.getString("10th_grade");
		startPassYear10th = rs4.getString("10th_start_pass_year");
		
		university12th = rs4.getString("12th_university_name");
		collegeName12th = rs4.getString("12th_college_name");
		grade12th = rs4.getString("12th_grade");
		startPassYear12th = rs4.getString("12th_start_pass_year");
		
		collegeUniversity = rs4.getString("college_university_name");
		collegeName = rs4.getString("college_name");
		collegeAggregate = rs4.getString("college_aggregate");
		collegeStartPassYear = rs4.getString("college_start_pass_year");
	}
	/* operation close for fetching details of user from student_academic_detail database table */
	
	/* 
	 System.out.print("\n" + username + "\n" + rollno + "\n" + course + "\n");
	 System.out.print("university10th" + "\n" + schoolName10th + "\n" + grade10th + "\n" + startPassYear10th +  "\n");
	 System.out.print("university12th + "\n" + collegeName12th + "\n" + grade12th + "\n" + startPassYear12th +  "\n"); 
	 System.out.print("collegeUniversity + "\n" + collegeName + "\n" + collegeaggregate + "\n" + collegeStartPassYear +  "\n");  
	*/

	
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
	System.out.println("\n UserSettings.jsp page Exception: " + e);
} /* catch block close */
	 
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>User Settings</title>
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" type="text/css" href="../../CSS/User/UserSettings.css">
</head>
<body class="user-settings-body">

<!-- Menu Section -->
	<%@include file="UserHeader.jsp" %>	
<!-- End of Menu  Section -->

	<div class="user-settings-container">

		<div class="row">
			
			<div class="col-left">

			<%
				String update = request.getParameter("update");
				if("updated".equals(update))
				{
			%>
				<p class="status-on">Details Updated Successfully</p>
			<%	} %>
			
			<% if("notupdated".equals(update))
				{
			%>
				<p class="status-off">Error Updating! Try Again</p>
			<%	} %>
			
			<% if("passIncorrect".equals(update))
				{
			%>
				<p class="status-off">Password Incorrect! Try Again</p>
			<%	} %>
			
			<% if("exception".equals(update))
				{
			%>
				<p class="status-off">Something Went Wrong! Try Again</p>
			<%	} %>
			
			
				<img width="350px" height="400px" alt="graphic-artist-freelancer.jpg" src="../../Images/user/graphic-artist-freelancer.jpg">
				<br>
				<p class="firstname"> <%= firstname %> </p>
				<p class="email"> <%= email %> </p>

			</div> <!-- col-left close -->

			<div class="col-middle">
				
				<h3>Update Personal Details</h3>
				<br>

				<!-- Update Personal Details form -->
				<form action="UpdateUserPersonalDetailsAction.jsp" method="post">
					<table>
						<tr>
							<td>Firstname*</td>
							<td>Lastname*</td>
						</tr>
						
						<tr>
							<!-- Firstname Input field -->
							<td> <input type="text" name="firstname" value="<%= firstname %>" placeholder="Your first name.." pattern="[a-zA-Z]{4,}" title="Only letters and min 4 char long" required> </td>

							<!-- Lastname Input Field -->
							<td> <input type="text" name="lastname" value="<%= lastname %>" placeholder="Your last name.." pattern="[a-zA-Z]{4,}" title="Only letters and min 4 char long" required> </td>
						</tr>

						<tr>
							<td>Birth-Date*</td>
							<td>Gender*</td>
						</tr>

						<tr>
							<!-- Age Select -->
							<td>  
								<input type="date" name="birthdate" title="Birth Years (2000 - 1990)" value="<%= birthdate %>" min="1990-01-01" max="2000-12-31" required>
							</td>

							<td>
								<!-- Gender Radio buttons -->
								<% if("M".equals(gender))
									{
								%>
								<input type="radio" name="gender" value="M" required checked> <label for="male" >Male</label>
				    			<%	} 
									else
				    				{
				    			%>
				    					<input type="radio" name="gender" value="M" required > <label for="male" >Male</label>
				    			<%	} %>
				    				
				    			<% if("F".equals(gender))
				    				{
				    			%>
				    					<input type="radio" name="gender" value="F" checked> <label for="Female">Female</label>
				    			<%	}
				    				else
				    				{
				    			%>
				    					<input type="radio" name="gender" value="F" > <label for="Female">Female</label>
				    			<%	} %>
				    			
				    			<% if("O".equals(gender))
				    				{
				    			%>
				    					<input type="radio" name="gender" value="O" checked> <label for="Other">Other</label>
								<% 	} 
				    				else
				    				{
								%>
										<input type="radio" name="gender" value="O" > <label for="Other">Other</label>
								<%	} %>
								
							</td>
						</tr>

						<tr>
							<td>Mobile*</td>
							<td>Address*</td>
						</tr>
						<tr>
							<td>
								<input type="tel" style="width:92%;" name="mobile" value="<%= mobile %>" placeholder="+91-123-457-7890" title="Format: Indian Mobile Number (+91-123-456-7890)" pattern="[+]91-[0-9]{3}-[0-9]{3}-[0-9]{4}" required>
							</td>
							<td>
								<input type="text" name="address" placeholder="Your Address..." value="<%= address %>" title="Enter Address" maxlength="300" required> <br>
							</td>
						</tr>

						<tr>
							<td>City*</td>
							<td>Country*</td>
						</tr>

						<tr>
							<td>
								<!-- City Input Field -->
	    						<input type="text" name="city" value="<%= city %>" placeholder="Your City..." pattern="[a-zA-Z]{4,}" title="Only letters and min 4 char long" required> <br>
							</td>

							<td>
								<!-- Country Input Field -->
				    			<input type="text" name="country" value="<%= country %>" placeholder="Your Country..." pattern="[a-zA-Z]{4,}" title="Only letters and min 4 char long" required> <br>
							</td>
						</tr>
						
						<tr>
							<td colspan="2">About Me*</td>
						</tr>

						<tr>
							<td colspan="2">
								<!-- using text field instead, as textarea did not support value field -->
								<input style="width: 92%;" type="text" name="aboutme" placeholder="More About Me..." value="<%= about %>" maxlength="500" required>
							</td>
						</tr>

						<tr>
							<td colspan="2"> <input type="submit" value="UPDATE PERSONAL DETAILS"> </td>
						</tr>

					</table>
				</form> 
				<!-- Update Personal Details form close -->


				<!-- Update Academic Details -->
				<hr>
				<br><br>
				<h3>Update Academic Details</h3>
				<br>
				<form action="UpdateUserAcademicDetailsAction.jsp" method="post">
	
					<table>
					
					<!-- Enter rollno and course details -->
						<tr>
							<td>Roll no*</td>
							<td>Course*</td>
						</tr>

						<tr>
							<!-- Rollno Input field -->
							<td> <input type="text" name="rollno" value="<%= rollno %>" placeholder="Your Roll no..(01-99)" pattern="[0-9]{2,2}" title="Two Digit Numbers Range (01-99)" maxlength="2" required> </td>

							<!-- Course Select Field -->
							<td> 
								<select name="course" required>
				    				<option value="<%= course %>"> <%= course %> </option>
				    				<option value="BBA">BBA</option>
				    				<option value="BBA(CA)">BBA(CA)</option>
				    				<option value="BBA(GeB)">BBA(GeB)</option>
				    				<option value="BBA(IB)">BBA(IB)</option>
				    			</select>
    			 			</td>
						</tr>
					<!-- rollno and course details close -->

				<!-- Enter 10th Details -->
						<!-- 10th University name rows -->
						<tr>
							<td colspan="2">10th Board*</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" name="university10th" value="<%= university10th %>" maxlength="300" placeholder="Enter SSC Board Name, Place" required>
							</td>
						</tr>

						<!-- 10th school name rows -->
						<tr>
							<td colspan="2">10th school Name*</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" name="schoolName10th" value="<%= schoolName10th %>" maxlength="300" placeholder="Enter SSC School Name" required>
							</td>
						</tr>

						<!-- 10th Grade (%)  and start-pass year rows -->
						<tr>
							<td>10th Grade (%)*</td>
							<td>10th Start - Pass Year</td>
						</tr>
						<tr>
							<!-- 10th Grade Select -->
							<td>  
								<select name="grade10th" required>
				    				<option value="<%= grade10th %>"><%= grade10th %></option>
				    				<option value="A">A (81 - 100)</option>
				    				<option value="B">B (70 - 79)</option>
				    				<option value="C">C (60 - 69)</option>
				    				<option value="D">D (50 - 59)</option>
				    			</select>
							</td>

							<td>
								<input type="text" name="startPassYear10th" value="<%= startPassYear10th %>" placeholder="1234 - 1234" pattern="[0-9]{4,4} - [0-9]{4,4}" required>
							</td>
						</tr>
				<!-- 10th details close -->


				<!-- Enter 12th Details -->

						<!-- 12th University name rows -->
						<tr>
							<td colspan="2">12th University*</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" name="university12th" value="<%= university12th %>" maxlength="300" placeholder="Enter 12th University Name, Place" required>
							</td>
						</tr>

						<!-- 12th school name rows -->
						<tr>
							<td colspan="2">12th College Name*</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" name="collegeName12th" value="<%= collegeName12th %>" maxlength="300" placeholder="Enter 12th School Name" required>
							</td>
						</tr>

						<!-- 12th Grade (%)  and start-pass year rows -->
						<tr>
							<td>12th Grade (%)*</td>
							<td>12th Start-Pass Year*</td>
						</tr>

						<tr>
							<td>
								<!-- 12th Grade Select -->
								<select name="grade12th" required>
				    				<option value="<%= grade12th %>"><%= grade12th %></option>
				    				<option value="A">A (81 - 100)</option>
				    				<option value="B">B (70 - 79)</option>
				    				<option value="C">C (60 - 69)</option>
				    				<option value="D">D (50 - 59)</option>
				    			</select>
							</td>
							
							<td>
							<input type="text" name="startPassYear12th" value="<%= startPassYear12th %>" placeholder="1234 - 1234" pattern="[0-9]{4,4} - [0-9]{4,4}" required>
							</td>

						</tr>

				<!-- 12th Details close -->


				<!-- Enter College Details -->

						<!-- 12th University name rows -->
						<tr>
							<td colspan="2">College University*</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" name="collegeUniversity" value="<%= collegeUniversity %>" maxlength="300" placeholder="Enter College University Name, Place" required>
							</td>
						</tr>

						<!-- 12th school name rows -->
						<tr>
							<td colspan="2">College Name*</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="text" name="collegeName" value="<%= collegeName %>" maxlength="300" placeholder="Enter College Name" required>
							</td>
						</tr>

						<!-- College Aggregate and Start-Pass year -->
						<tr>
							<td>College Aggregate (%)*</td>
							<td>College Start-Pass Year*</td>
						</tr>

						<tr>
							<td>
								<!-- College Aggregate Select -->
				    			<select name="collegeAggregate" required>
				    				<option value="<%= collegeAggregate %>"><%= collegeAggregate %></option>
				    				<option value="A">A (81 - 100)</option>
				    				<option value="B">B (70 - 79)</option>
				    				<option value="C">C (60 - 69)</option>
				    				<option value="D">D (50 - 59)</option>
				    			</select>
							</td>

							<td>
								<input type="text" name="collegeStartPassYear" value="<%= collegeStartPassYear %>" placeholder="1234 - 1234" pattern="[0-9]{4,4} - [0-9]{4,4}" required>
							</td>
						</tr>

						<tr>
							<td colspan="2"> <input type="submit" value="UPDATE ACADEMIC DETAILS"> </td>
						</tr>

				<!-- College Details Close -->

					</table>
				</form>	
				<!-- Update Academic Detail form close -->

	
			</div>
			<!-- col-middle close -->
						
			<div class="col-right">
				
				<!-- col-right update skills form -->
				<h3>Update Skills </h3>
				<form action="UpdateUserSkillsAction.jsp" method="post">
					
					<table>
						
						<tr> 
							<td colspan="2"> 
								<p style="font-size: 18px; margin-bottom: 8px;">Professional Skills</p> 
							</td> 
						</tr>
						<!-- HTML and C skills -->
						<tr>
							<td>HTML*</td>
							<td>C*</td>
						</tr>
						<tr>
							<td> <input type="number" name="html" value="<%= html %>" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="c" value="<%= c %>" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- CSS and C++ skills -->
						<tr>
							<td>CSS*</td>
							<td>C++*</td>
						</tr>
						<tr>
							<td> <input type="number" name="css" value="<%= css %>" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="cpp" value="<%= cpp %>" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- JavaScript and Java skills -->
						<tr>
							<td>JavaScript*</td>
							<td>Java*</td>
						</tr>
						<tr>
							<td> <input type="number" name="javaScript" value="<%= javaScript %>" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="java" value="<%= java %>" placeholder="(%)" min="1" max="100" required> </td>
						</tr>


						<tr> 
							<td colspan="2"> 
							<p style="font-size: 18px; margin: 6px 0px 8px;"> Extra Curriculum Activity</p> 
							</td>
						</tr>
						<!-- Sports and Photography skills -->
						<tr>
							<td>Sports*</td>
							<td>Photography*</td>
						</tr>
						<tr>
							<td> <input type="number" name="sports" value="<%= sports %>" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="photography" value="<%= photography %>" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- Animation and Social Media skills -->
						<tr>
							<td>Animation*</td>
							<td>Social Media*</td>
						</tr>
						<tr>
							<td> <input type="number" name="animation" value="<%= animation %>" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="socialMedia" value="<%= socialMedia %>" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<!-- Act and Art skills -->
						<tr>
							<td>Act (Drama, Dance, Music)*</td>
							<td>Art (Drawing, Painting, Cartooning)*</td>
						</tr>
						<tr>
							<td> <input type="number" name="act" value="<%= act %>" placeholder="(%)" min="1" max="100" required> </td>
							<td> <input type="number" name="art" value="<%= art %>" placeholder="(%)" min="1" max="100" required> </td>
						</tr>

						<tr>
							<td colspan="2"> <input type="submit" value="Update Skills"> </td>
						</tr>

					</table>
				</form>
				<!-- col-right update skills form close-->
				
				<!-- col-right HireUp Image -->
				<img src="../../Images/HireUpIcon.png" alt="HireUpCion.png" title="HireUp">
				
				
				<br><br>
				<!-- col-right change password form -->
				<h3>Change Password </h3>
				<form action="UpdateUserChangePasswordAction.jsp" method="post">
					
					<table>
						<tr>
							<td>Current Password*</td>
						</tr>

						<tr>
							<td><input type="password" name="old-password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Enter Current Password*" id="password" required></td>
						</tr>

						<tr>
							<td>New Password*</td>
						</tr>

						<tr>
							<td><input type="password" name="new-password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Enter New Password*" id="p1password" required></td>
						</tr>

						<tr>
							<td> <input type="checkbox" name="password-visibility"  style="margin: 0px;" onclick="login_showPassword(); signup_showPassword()"> Show Password</td>
						</tr>

						<tr>
							<td> <input type="submit" value="CHANGE PASSWORD"> </td>
						</tr>

					</table>
				</form>
				<!-- col-right change password form close -->

				<hr>
				
				<div class="col-right-del-account">
				
					<form action="DeleteUserAccountAction.jsp" method="post">

						<table>

							<tr>
								<td>
									<input type="password" name="password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" placeholder="Enter Password*" required></td>
							</tr>

							<tr>
								<td>
									<input type="submit" value="Delete Account">
								</td>
							</tr>

						</table>
					</form>
				</div>
				<!-- col-right-del-account close -->

			</div> <!-- col-right close -->

		</div>
		<!-- row close -->

	</div>
	<!-- user settings container close -->

<!-- Footer Section -->
	<%@include file="../Footer.jsp" %>
<!-- Footer Section End -->


</body>
<script src="../../JS/Login&Signup.js"> </script>
</html>