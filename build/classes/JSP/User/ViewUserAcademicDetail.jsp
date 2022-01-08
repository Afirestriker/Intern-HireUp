<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!--
	This page is used to show user his/her academic information,
	only some information is shown, not all.
-->

<%!

	/* This are variables, declared outside service() method, and available in the whole page
	 * This variables are used to store the column values fetched from database table
	*/
	
	String email = null;
	String firstname = null;
	String lastname = null;
	int rollno;
	String course = null;
	
	String university10th = null;
	String schoolName10th = null;
	String grade10th = null;
	
	String university12th = null;
	String collegeName12th = null;
	String grade12th = null;
	
	String collegeUniversity = null;
	String collegeName = null;
	String collegeAggregate = null;
%>

<% 
/* Under this scripplet tag 
 * We are connecting with database and fetching user academic detail to show on page
*/

try{
	/* Print message on console, indicating which page is visited */
	System.out.println("\n ViewUserAcademicDetail.jsp Called \n"); 

	/* collect username value, from session set in JSP/LoginAction.jsp page */
	String username = session.getAttribute("username").toString();

	/* 
	* Make DBMS connection,
	* class DbConnection belongs to hireupdb package 
	* getConnection() is a static method of DbConnection which return connection object 
	*/
	Connection con = DbConnection.getConnection();

	
	/* Validate user academic detail, if its exist or not */

		/* Here, we are checking student_academic_detail table if record exist or not */
		String checkDetailInAcademicDetailTable = "SELECT COUNT(stuemail) FROM student_academic_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstCheckAcademicDetail = con.prepareStatement(checkDetailInAcademicDetailTable);
		pstCheckAcademicDetail.setString(1, username);
		ResultSet rs2 = pstCheckAcademicDetail.executeQuery();
		int stuAcademicDetailExist = 0;
		while(rs2.next())
		{
			if(rs2.getInt(1) == 0)
			{
				response.sendRedirect("UserLoginAction.jsp");
			}
		}
	
	/* Validate user academic detail, if its exist or not */
	
	/* database query to fetch firstname and lastname from student_personal_detail table */
	String fetchNameQuery = "SELECT stufirstname, stulastname FROM student_personal_detail WHERE stuemail = (SELECT email FROM login WHERE username = '"+username+"' ) ";
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(fetchNameQuery);
	
	while(rs.next())
	{
		firstname = rs.getString(1);
		lastname = rs.getString(2);
	} //while loop close
	
	/* Database query to fetched whole academic detail from student_academic_detail table */
	String fetchAdQuery = "SELECT * FROM student_academic_detail WHERE stuemail = (SELECT email FROM login WHERE username = '"+username+"') ";
	Statement st1 = con.createStatement();
	ResultSet rs1 = st1.executeQuery(fetchAdQuery);
	
	while(rs1.next())
	{
		/* Stroing the collected value in variable declared above */
		email = rs1.getString("stuemail");
		rollno = rs1.getInt("sturollno");
		course = rs1.getString("stucourse");
		
		university10th = rs1.getString("10th_university_name");
		schoolName10th = rs1.getString("10th_school_name");
		grade10th = rs1.getString("10th_grade");

		university12th = rs1.getString("12th_university_name");
		collegeName12th = rs1.getString("12th_college_name");
		grade12th = rs1.getString("12th_grade");
		
		collegeUniversity = rs1.getString("college_university_name");
		collegeName = rs1.getString("college_name");
		collegeAggregate = rs1.getString("college_aggregate");
		
	} /* while loop close */
	
} /* try block close */
catch(Exception e)
{
	System.out.println("\n ViewUserAcademicDetail.jsp Exception: " + e);
} /* catch block close */
%>    


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>User Academic Details</title>
	
	<!-- display image in browser tab -->
    <link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
    
    <!-- Link CSS file to style this page -->
    <link rel="stylesheet" href="../../CSS/User/ViewUserDetails.css">
</head>
<body>

<!-- Menu Section -->
	<%@include file="UserHeader.jsp" %>	
<!-- End of Menu  Section -->


<div class="container">

    <div class="left">
    	<!-- Display image in left side container -->
        <img src="../../Images/user/man-laptop-pic.jpg" title="woman working on laptop" alt="user-profile">
    </div>

    <div class="right">

        <div class="info">
            <p class="info-title">Academic Information</p> <br>
            
            <div class="info-data">
                
                <label for="Name">Name</label> <br>
                <p> <%= firstname + " " + lastname %> </p>

				<label for="Roll no">Roll no</label> <br>
                <p> <%= rollno %> </p>
                
                <label for="Course">Course</label> <br>
                <p> <%= course %> </p>

                <label for="Grade">Grade</label> <br>
                <div class="info-data-grades">
	                <p>College Aggregate ('<%= collegeAggregate %>')</p>
	                <p>12th Aggregate ('<%= grade12th %>')</p>
	                <p>10th Aggregate ('<%= grade10th %>')</p>
	            </div>
				
				<br>
				<div class="button-edit">
      				<!-- Edit Button which redirect to setting page for editing user details -->
        			<a href="UserSettings.jsp"><button>Update Detail </button></a>    
      			</div>
		
            </div>
            <!-- class info-date close -->
        
        </div>
        <!-- class info close -->

    </div>
    <!-- class right close -->

</div>
<!-- class container close -->

</body>
</html>