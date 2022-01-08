<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="ForgetPassword.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<%
	/* Printing statement for console, which shows the navigation */
	System.out.print("\n\n ResetPasswordAction.jsp Called");
%>

<%

	try{
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		
		/* Helping, variable which store oldPassword and check its matched with new password */
		String oldPassword="";
		
		/* Here,
		 * Fetching ResetPassword.jsp form values
		 */
		String username = session.getAttribute("uname").toString();		
		String newpassword = request.getParameter("newpassword");
		
		String fetchOldPasswordQuery = "SELECT Password FROM login where Username = ?";
		PreparedStatement pst = con.prepareStatement(fetchOldPasswordQuery);
		pst.setString(1, username);
		
		ResultSet rs = pst.executeQuery();
		while(rs.next())
		{
			oldPassword = rs.getString(1);
		} // while loop close
		
		/*  
		 * Condition to check whether newpassword is same as old password
		 * if yes, redirect to ResetPassword.jsp and display invalid msg
		 * if false, continue Password Update process
		 */
		if(newpassword.equals(oldPassword))
		{
			response.sendRedirect("ResetPassword.jsp?msg=invalid");
		} //if close
		else
		{
			String updatePasswordQuery = "UPDATE login SET Password = ? WHERE Username = ?";
			PreparedStatement pst1 = con.prepareStatement(updatePasswordQuery);
			pst1.setString(1, newpassword);
			pst1.setString(2, username);
			pst1.executeUpdate();
			
			response.sendRedirect("ResetPassword.jsp?msg=valid");
			
		} //else block close
		
	}
	catch(Exception e)
	{
		System.out.print("\n Exception ResetPasswordAction.jsp: " + e);
		response.sendRedirect("ResetPassword.jsp?msg=exception");
	}

%>
