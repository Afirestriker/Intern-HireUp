<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- Importing calcualtion package classes and interface for calculating user age -->
<%@ page import = "calculation.*" %>

<!--
	This file is called from AddUserPersonalDetailAction.jsp page,
	
	This File represent the backend process of AddUserPersonalDetailAction.jsp page
	Here, the value parameter is collected from AddUserPersonalDetail.jsp page
	and this values are enter with current user email id into the hireupv1.student_personal_detail
	database table
	
	NOTE: At here, the session attribute email, which is set in UserLoginAction.jsp page is collected
		  to add current user detail in student_personal_detail table and make it connect with other 
		  database tables using stuemail (stuemail is an foreign key in stuent_personal_detail database table)
	
	NOTE: After the insertion of detail in hireupv1.student_personal_detail table,
		  Navigate to AddUserAcademicDetail.jsp page, to take further user detail
		  
	Also session attribute email, prevent wrong access to this page by using url addressing
	as, session attribute email is set only through UserLoginAction.jsp page, only if user profile
	status is incomplete i.e user records are not entered in all three tables
	1. student_persona_detail
	2. student_academic_detail
	3. student_skills_detail
 -->



<%

try{

	/* This statement display a message on consle, indicating current page execution */
	System.out.print("\n AddUserPersonalDetailAction.jsp called \n");

	/* Get session from UserPersonalDetail.jsp and store in User_Personal_Detail database table */
	/* email session, also helps in avoiding user to directly naviage to this page, since
	   email is set in UserLongAction.jsp which check, if user has completed its profile details or not   
	*/
	String email = session.getAttribute("email").toString();
	
	/* Get, all parameter from AddUserPersonalDetail.jsp to store in hireupv1.User_Pesonal_Detail table */
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String birthdate = request.getParameter("birthdate");
	
	/* Now Calculate age, using birthdate value in java 
	 * AgeCalculate is a class of calculation package
	 * age(String birthdate) is a method of AgeCalculate class which takes one string parameter,
	   and calcualte age in years and return age as int
	*/
	int age = AgeCalculate.age(birthdate);
	
	String mobile = request.getParameter("mobile");
	String gender = request.getParameter("gender");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String country = request.getParameter("country");
	String about = request.getParameter("aboutme");

	/* System.out.print("\n" + username + "\n" + firstname + "\n" + lastname + "\n" + birthdate + "\n" + age + "\n" + gender + "\n" + address + "\n" + city + "\n" + country + "\n" + about + "\n"); */
	
	/**************************************************************************** 
	* Make DBMS connection,
	* class DbConnection belongs to hireupdb package 
	* getConnection() is a static method of DbConnection which return connection object 
	*/
	Connection con = DbConnection.getConnection();

	/* Check If user data already exist
	 * if yes, then redirect to UserLoginAction.jsp
	 * if No, then insert details
	*/
	String checkDuplicateEntry = "SELECT COUNT(stuemail) FROM student_personal_detail WHERE stuemail = '"+email+"'";
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(checkDuplicateEntry);
	while(rs.next())
	{
		if(rs.getInt(1) != 0)
		{
			response.sendRedirect("UserLoginAction.jsp");
		}
	}
	/* close while loop checking student records in hireupv1.student_personal_detail table */
	
	
	/* Write MySql query to insert values in student_personal_detail table */
	String updateSPD = "INSERT INTO student_personal_detail VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	/* Using PreparedStatement interface to update database table,
	 * since we are accepting value at run time
	*/
	PreparedStatement pst = con.prepareStatement(updateSPD);
	pst.setString(1, email);
	pst.setString(2, firstname);
	pst.setString(3, lastname);
	pst.setString(4, birthdate);
	pst.setInt(5, age);
	pst.setString(6, mobile);
	pst.setString(7, gender);
	pst.setString(8, address);
	pst.setString(9, city);
	pst.setString(10, country);
	pst.setString(11, about);
	
	pst.executeUpdate();

	/* One database is successfully updated,
	 * set session and redirect to UserAcademicDetail.jsp page
	*/
	
	/* NOTE: Session (attribute="email") is already set in UserLoginAction.jsp page */
	response.sendRedirect("AddUserAcademicDetail.jsp");
	
}
catch(Exception e)
{
	/* In Case if run-time exception is thrown 
	 * Then, counter comes inside catch block and display error on console
	 * And, redirect to AddUserPersonalDetail.jsp with messsage  = exception
	 * Then, at AddUserPersonalDetail.jsp there's an condition which check if msg = exception 
	   and accordingly message is display on that page
	*/
	System.out.println("AddUserPersonalDetailAction Exception: " + e);
	response.sendRedirect("AddUserPersonalDetail.jsp?msg=exception");
}

%>