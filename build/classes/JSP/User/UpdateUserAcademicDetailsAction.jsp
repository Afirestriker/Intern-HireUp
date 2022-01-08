<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	This page is used for Updating student_academic_detail database table 
	This page is called from UserSettins.jsp page -> Update Academic Details Form Action
-->

<%

	/* Print message on console, indicating which page is visited */
	System.out.print("\n UpdateUserAcademicDetailsAction.jsp page called \n");
	String username = session.getAttribute("username").toString();

	/* Collecting and storing parameter from Student_Personal_Detail form action */
	int rollno = Integer.parseInt(request.getParameter("rollno"));
	String course = request.getParameter("course");
	
	String university10th = request.getParameter("university10th");
	String schoolName10th = request.getParameter("schoolName10th");
	String grade10th = request.getParameter("grade10th");
	String startPassYear10th = request.getParameter("startPassYear10th");
	
	String university12th = request.getParameter("university12th");
	String collegeName12th = request.getParameter("collegeName12th");
	String grade12th = request.getParameter("grade12th");
	String startPassYear12th = request.getParameter("startPassYear12th");

	String collegeUniversity = request.getParameter("collegeUniversity");
	String collegeName = request.getParameter("collegeName");
	String collegeAggregate = request.getParameter("collegeAggregate");
	String collegeStartPassYear = request.getParameter("collegeStartPassYear");
	
	/* System.out.print("\n" + username + "\n" + rollno + "\n" + course + "\n"); */
	/* System.out.print("university10th" + "\n" + schoolName10th + "\n" + grade10th + "\n" + startPassYear10th +  "\n"); */
	/* System.out.print("university12th + "\n" + collegeName12th + "\n" + grade12th + "\n" + startPassYear12th +  "\n");  */
	/* System.out.print("collegeUniversity + "\n" + collegeName + "\n" + collegeaggregate + "\n" + collegeStartPassYear +  "\n");  */
	
	/* Inside try block, connection with JDBC, and executing update query */
	try{
		
		/* 
		 * Make DBMS connection,
		 * class DbConnection belongs to hireupdb package 
		 * getConnection() is a static method of DbConnection which return connection object 
		 */
		Connection con = DbConnection.getConnection();
		
		String updateSACQuery =  "UPDATE student_academic_detail "
								+"SET sturollno = ?, stucourse = ?," 
								+"    10th_university_name = ?, 10th_school_name = ?, 10th_grade = ?, 10th_start_pass_year = ?, "
								+"    12th_university_name = ?, 12th_college_name = ?, 12th_grade = ?,  12th_start_pass_year = ?, "
								+"    college_university_name = ?, college_name = ?, college_aggregate = ?, college_start_pass_year = ? "
								+"WHERE stuemail = (SELECT email FROM login WHERE username = ?) ";
		
		PreparedStatement pst = con.prepareStatement(updateSACQuery);
		pst.setInt(1, rollno);
		pst.setString(2, course);
		
		pst.setString(3, university10th);
		pst.setString(4, schoolName10th);
		pst.setString(5, grade10th);
		pst.setString(6, startPassYear10th);
		
		pst.setString(7, university12th);
		pst.setString(8, collegeName12th);
		pst.setString(9, grade12th);
		pst.setString(10, startPassYear12th);
		
		pst.setString(11, collegeUniversity);
		pst.setString(12, collegeName);
		pst.setString(13, collegeAggregate);
		pst.setString(14, collegeStartPassYear);
		
		pst.setString(15, username);

		/* status is used, to hold the return value of pst.executeUpdate()
		 * if status != 0, its mean , that at a row is affected i.e record updated
		 * if status == 0, its mena, that no row is affected i.e no record updated
		*/
		int status = pst.executeUpdate();
		
		if(status != 0)
		{
			response.sendRedirect("UserSettings.jsp?update=updated");
		}
		
		if(status == 0)
		{
			response.sendRedirect("UserSettings.jsp?update=notupdated");
		}
				
	} /* try block close */
	catch(Exception e)
	{
		System.out.print("\n UpdateUserAcademicDetailsAction.jsp Exception: " + e);
		response.sendRedirect("UserSettings.jsp?update=exception");
	} /* catch block close */
%>