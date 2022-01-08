<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>


<%!
	String firstname = "";
	String lastname = "";
%>

<% 
try
{
	/* Steps
	 1. get session attribute and store in string type username
	 2. fetched needed value from database
	 3. Display appropriate values
	 */

	 /* Print message on console, indicating which page is visited */
	System.out.print("\n UserIndex.jsp called \n");
	
	String username = session.getAttribute("username").toString();
	
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

	/* Check if student record exist in student_personal_detail database table
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

	
	/* Check Skills table records exist for current user or not */
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
	/* Check Skills table records exist for current user or not  close */

	
	/* 
	 * console comes here, only if student recored exist in
		1. student_personal_detail table
		2. student_academic_detail table
		3. skills table
	 */
	 
	/* Query to fecth sutfirstname and lastname vlaues from hireupv1.student_personal_detail table */
	String stuFirstLastName = "SELECT stufirstname, stulastname FROM student_personal_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
	PreparedStatement pst = con.prepareStatement(stuFirstLastName);
	pst.setString(1, username);
	ResultSet rs = pst.executeQuery();

	while(rs.next())
	{
		firstname = rs.getString(1);
		lastname = rs.getString(2);
	}
}
catch(Exception e)
{
	System.out.println("\n UserIndex.jsp Exception: " + e);
}
%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Welcome <% out.print(firstname); %></title>

	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" href="../../CSS/User/UserIndex.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
</head>
<body>

<!-- Menu Section -->
	<%@include file="UserHeader.jsp" %>	
<!-- End of Menu  Section -->


<div class="hero-image">

	<div class="UserIndex-container">
  	
  		<div class="UserIndex-container-col-left">
    		
    		<p class="welcome-msg"> Welcome <%= firstname %></p>
    		<p class="quote"> "The only way to be truly satisfied is to do what you believe is great work" <br>- Steve Jobs</p>
    		
    		<a href="UserResume.jsp"> <button> Resume <span class="material-icons" style="font-size:16px; margin-left: 266px;"> arrow_forward_ios </span></button> </a>
    		<br>
    		<a href="ViewUserPersonalDetail.jsp"> <button> View Personal Details <span class="material-icons" style="font-size:16px; margin-left: 152px;"> arrow_forward_ios </span></button> </a>
    		<br>
    		<a href="ViewUserAcademicDetail.jsp"> <button> View Academic Details <span class="material-icons" style=" font-size: 16px; margin-left: 140px;"> arrow_forward_ios </span></button> </a>
  		</div>
  		<!-- UserIndex-container-col-left close -->

  		<br>
  		<div class="UserIndex-container-col-right">

  			<img src="../../Images/user/woman-meeting.jpg" alt="woman-characters-having-business-conversation-meeting.jpg">
  			
  		</div>
  		<!-- UserIndex-container-col-right close -->
	
	</div>
	<!-- UserIndex-container close -->
</div>

<!-- Footer Section -->
	<%@include file="../Footer.jsp" %>
<!-- Footer Section End -->

</body>
</html>
