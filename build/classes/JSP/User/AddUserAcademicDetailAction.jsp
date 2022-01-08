<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>


<!--
	<!--
	This file is called from AddUserAcademicDetail.jsp page,
	
	This File represent the backend process of AddUserAcademicDetailAction.jsp page
	Here, the value parameter is collected from AddUserAcademicDetail.jsp page
	and this values are enter with current user email id into the hireupv1.student_academic_detail
	database table
	
	NOTE: At here, the session attribute email, which is set in UserLoginAction.jsp page is collected
		  to add current user detail in student_academic_detail table and make it connect with other 
		  database tables using stuemail (stuemail is an foreign key in stuent_academic_detail database table)
	
	NOTE: After the insertion of detail in hireupv1.student_academic_detail table,
		  Navigate to AddUserSkillsDetail.jsp page, to take further user detail
		  
	Also session attribute email, prevent wrong access to this page by using url addressing
	as, session attribute email is set only through UserLoginAction.jsp page, only if user profile
	status is incomplete i.e user records are not entered in all three tables
	1. student_persona_detail
	2. student_academic_detail
	3. student_skills_detail
 -->
	

<%

	try
	{
		/* This statement display a message on consle, indicating current page execution */
		System.out.println("\n AddUserAcademicDetailAction.jsp Called \n"); 
		
		/* Get session attribute, set in UserLoginAction.jsp page */
		String email = session.getAttribute("email").toString();
		
		/* Get all form parameter from UserAcademicDetail.jsp to store in hireupv1.student_academic_detail table */
		int rollno = Integer.parseInt(request.getParameter("rollno"));
		String course = request.getParameter("course");
		
		String university10th = request.getParameter("10thUniversityName");
		String schoolName10th = request.getParameter("10thSchoolName");
		String grade10th = request.getParameter("10thGrade");
		String startPassYear10th = request.getParameter("10thStartPassYear");
		
		String university12th = request.getParameter("12thUniversityName");
		String CollegeName12th = request.getParameter("12thCollegeName");
		String grade12th = request.getParameter("12thGrade");
		String startPassYear12th = request.getParameter("12thStartPassYear");
		
		String collegeUniversity = request.getParameter("collegeUniversityName");
		String collegeName = request.getParameter("collegeName");
		String collegeAggregate = request.getParameter("collegeAggregate");
		String collegeStartPassYear = request.getParameter("collegeStartPassYear");
		
		/* System.out.print("\n" + username + "\n" + rollno + "\n" + course + "\n"); */
		/* System.out.print("university10th" + "\n" + schoolName10th + "\n" + grade10th + "\n" + startPassYear10th +  "\n"); */
		/* System.out.print("university12th + "\n" + collegeName12th + "\n" + grade12th + "\n" + startPassYear12th +  "\n");  */
		/* System.out.print("collegeUniversity + "\n" + collegeName + "\n" + collegeaggregate + "\n" + collegeStartPassYear +  "\n");  */

		
		/*********************************************************************************** 
		 * Make DBMS connection,
		 * class DbConnection belongs to hireupdb package 
		 * getConnection() is a static method of DbConnection which return connection object 
		 */
		Connection con = DbConnection.getConnection();

		
		/* Check If user data already exist
		 * if yes, then redirect to UserLoginAction.jsp
		 * if No, then insert details
		*/
		String checkDuplicateEntry = "SELECT COUNT(stuemail) FROM student_academic_detail WHERE stuemail = '"+email+"'";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(checkDuplicateEntry);
		while(rs.next())
		{
			if(rs.getInt(1) != 0)
			{
				response.sendRedirect("UserLoginAction.jsp");
			}
		}
		/* close while loop checking student records in hireupv1.student_academic_detail table */
		
		
		/* Write MySql query to insert values in student_academic_detail table */
		String updateSAD = "INSERT INTO student_academic_detail VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

		/* Using PreparedStatement interface to update database table,
		 * since we are accepting value at run time
		*/
		PreparedStatement pst = con.prepareStatement(updateSAD);
		pst.setString(1, email);
		pst.setInt(2, rollno);
		pst.setString(3, course);
		
		pst.setString(4, university10th);
		pst.setString(5, schoolName10th);
		pst.setString(6, grade10th);
		pst.setString(7, startPassYear10th);
		
		pst.setString(8, university12th);
		pst.setString(9, CollegeName12th);
		pst.setString(10, grade12th);
		pst.setString(11, startPassYear12th);
		
		pst.setString(8, university12th);
		pst.setString(9, CollegeName12th);
		pst.setString(10, grade12th);
		pst.setString(11, startPassYear12th);
		
		pst.setString(12, collegeUniversity);
		pst.setString(13, collegeName);
		pst.setString(14, collegeAggregate);
		pst.setString(15, collegeStartPassYear);
		
		pst.setString(16, "Not-Selected");
		
		pst.executeUpdate();
		
		/* One database is successfully updated,
		 * set session and redirect to UserIndex.jsp page
		*/
		
		/* Now, Navigate to AddUserSkillsDetail.jsp page to get skills detail */
		/* response.sendRedirect("AddUserSkillsDetail.jsp"); */
		response.sendRedirect("UserIndex.jsp");
	}
	catch(Exception e)
	{
		/* In Case if run-time exception is thrown 
		 * Then, counter comes inside catch block and display error on console
		 * And, redirect to AddUserAcademicDetail.jsp with messsage=exception
		 * Then, at AddUserAcademicDetail.jsp there's an condition which check if msg=exception 
		   and accordingly message is display on that page
		*/
		System.out.println("\n AddUserAcademicDetailAction.jsp Exception: " + e);
		response.sendRedirect("AddUserAcademicDetail.jsp?msg=exception");
	}
	
%>