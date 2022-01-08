<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	This page is used for Updating student_personal_detail database table 
	This page is called from UserSettins.jsp page -> Update Personal Details Form Action
-->

<%

	/* Print message on console, indicating which page is visited */
	System.out.print("\n DeleteUserAccount.jsp page called \n");
	String username = session.getAttribute("username").toString();
	
	/* Collecting and storing parameter from Delte user Account form action */
	String password = request.getParameter("password");
	
	/* Inside try block, connection with JDBC, and executing update query */
	try{
		
		/* 
		 * Make DBMS connection,
		 * class DbConnection belongs to hireupdb package 
		 * getConnection() is a static method of DbConnection which return connection object 
		 */
		Connection con = DbConnection.getConnection();
		
		/* String to fetched actual password, used to compare password enter, and validate user */
		String fetchRealPasswordQuery = "SELECT password FROM login WHERE username = ?";
		PreparedStatement pst = con.prepareStatement(fetchRealPasswordQuery);
		pst.setString(1, username);
		
		ResultSet rs = pst.executeQuery();
		while(rs.next())
		{
			String realPassword = rs.getString(1);
			
			if(!realPassword.equals(password))
			{
				response.sendRedirect("UserSettings.jsp?update=passIncorrect");
			}
			if(realPassword.equals(password))
			{
				String deleteUserAD = "DELETE FROM student_academic_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
				String deleteUserPD = "DELETE FROM student_personal_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
				String deleteUserSkills = "DELETE FROM skills WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
				String deleteUserCompany = "DELETE FROM company WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
				String deleteUserLogin = "DELETE FROM login WHERE username = ?";
				
				PreparedStatement pst1 = con.prepareStatement(deleteUserAD);
				pst1.setString(1, username);
				pst1.executeUpdate();
			
				pst1 = con.prepareStatement(deleteUserPD);
				pst1.setString(1, username);
				pst1.executeUpdate();
				
				pst1 = con.prepareStatement(deleteUserSkills);
				pst1.setString(1, username);
				pst1.executeUpdate();
				
				pst1 = con.prepareStatement(deleteUserCompany);
				pst1.setString(1, username);
				pst1.executeUpdate();
				
				pst1 = con.prepareStatement(deleteUserLogin);
				pst1.setString(1, username);
				pst1.executeUpdate();
								
				session.invalidate();
				
				response.sendRedirect("../Index.jsp");

			}
		}
		
		
	
	} /* Try block close */
	catch(Exception e)
	{
		System.out.print("\n DeleteUserAccount.jsp Exception: " + e);
		response.sendRedirect("UserSettings.jsp?update=exception");
	}/* Catch block close */
%>
