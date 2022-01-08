<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	This page is used for Updating user password in login database table
	This page is called from UserSettins.jsp page -> Change Password Form Action
-->

<%

	/* Print message on console, indicating which page is visited */
	System.out.print("\n UpdateUserChangePasswordAction.jsp page called \n");
	String username = session.getAttribute("username").toString();

	/* Collecting and storing parameter from Change Password form action */
	String oldPassword = request.getParameter("old-password");
	String newPassword = request.getParameter("new-password");

	/* System.out.println("\n" + username + "\n" + oldPassword + "\n" + newPassword + "\n"); */

	/* Inside try block, connection with JDBC, and executing update query */
	try{
		
		/* 
		 * Make DBMS connection,
		 * class DbConnection belongs to hireupdb package 
		 * getConnection() is a static method of DbConnection which return connection object 
		 */
		Connection con = DbConnection.getConnection();
		
		/* Query to update user password with new password */
		String updatePasswordQuery = "UPDATE login "
									+"SET password = ? "
									+"WHERE BINARY password = ? AND username = ? ";
		
		PreparedStatement pst = con.prepareStatement(updatePasswordQuery);
		pst.setString(1, newPassword);
		pst.setString(2, oldPassword);
		pst.setString(3, username);

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
			response.sendRedirect("UserSettings.jsp?update=passIncorrect");
		}
		
	}/* try block close */
	catch(Exception e)
	{
		System.out.println("\n UpdateUserChangePasswordActoin.jsp Exception: " + e);
		response.sendRedirect("UserSettings.jsp?update=exception");		
	} /* catch block close */
	
%>
