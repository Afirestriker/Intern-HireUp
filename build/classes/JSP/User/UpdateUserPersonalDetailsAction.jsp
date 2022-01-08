<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- Importing calculation package classes and interface for calculating user age -->
<%@ page import = "calculation.*" %>


<!-- 
	This page is used for Updating student_personal_detail database table 
	This page is called from UserSettins.jsp page -> Update Personal Details Form Action
-->

<%

	/* Print message on console, indicating which page is visited */
	System.out.print("\n UpdateUserPersonalDetailAction.jsp page called \n");
	String username = session.getAttribute("username").toString();
	
	/* Collecting and storing parameter from Student_Personal_Detail form action */
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String birthdate = request.getParameter("birthdate");
	
	int age = AgeCalculate.age(birthdate); 

	String mobile = request.getParameter("mobile");
	String gender = request.getParameter("gender");
	
	String address = request.getParameter("address");
	
	String city = request.getParameter("city");
	String country = request.getParameter("country");
	
	String about = request.getParameter("aboutme");
	
	/* System.out.print("\n" + username + "\n" + firstname + "\n" + lastname + "\n" + birthdate + "\n" + age + "\n" + gender + "\n" + address + "\n" + city + "\n" + country + "\n" + about + "\n"); */

	/* Inside try block, connection with JDBC, and executing update query */
	try{
		
		/* 
		 * Make DBMS connection,
		 * class DbConnection belongs to hireupdb package 
		 * getConnection() is a static method of DbConnection which return connection object 
		 */
		Connection con = DbConnection.getConnection();
		
		String updateSPDQuery =  "UPDATE student_personal_detail "
								+"SET stufirstname = ?, stulastname = ?, stubirthdate= ?, stuage = ?, stumobile=?, stugender = ?, stuaddress = ?, stucity = ?, stucountry = ?, stuabout = ? "
								+"WHERE stuemail = (SELECT email FROM login WHERE username = ?)";

		PreparedStatement pst = con.prepareStatement(updateSPDQuery);
		pst.setString(1, firstname);
		pst.setString(2, lastname);
		pst.setString(3, birthdate);
		pst.setInt(4, age);
		pst.setString(5, mobile);
		pst.setString(6, gender);
		pst.setString(7, address);
		pst.setString(8, city);
		pst.setString(9, country);
		pst.setString(10, about);

		pst.setString(11, username);
		
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
		System.out.print("\n UpdateUserPersonalDetailsAction.jsp Exception: " + e);
		response.sendRedirect("UserSettings.jsp?update=exception");
	} /* catch block close */
	
%>