<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="Error.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<%
		
	try{
		/* This statement display a message on consle */
		System.out.print("\n\n SignupAction.jsp called ");

		/* 
		 * helping variable to check if user is new or old
		 * 0 means user is new and can be registered
		 */
		int duplicate = 0;

		/* Get username and password parameter from Signup.jsp */
		String email = request.getParameter("email");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();

		/* 
		 * Check for duplicate entry of email or username 
		 * The query return the count greater than 0, is user with given email or username already exist
		 */
		String checkEmailQuery = "SELECT COUNT(*) FROM login WHERE Email = ? OR Username = ?";
		PreparedStatement pstCount = con.prepareStatement(checkEmailQuery);
		pstCount.setString(1, email);
		pstCount.setString(2, username);
		ResultSet rs = pstCount.executeQuery();
		rs.next();
		duplicate = Integer.parseInt(rs.getString(1));

		/* 
		 * condition, to check if user with given username or email already exist 
		 * TURE, means user with given username or email already exist
		 */
		if(duplicate != 0)
		{
			response.sendRedirect("Signup.jsp?msg=invalid");
		} //if(duplicate !=0) close

		/* If this condition is ture, it means that user is new and can be registered */
		if(duplicate == 0)
		{
			String sq = "INSERT INTO Login values (?, ?, ?)";
			PreparedStatement pstInsert = con.prepareStatement(sq);
			pstInsert.setString(1, email);
			pstInsert.setString(2, username);
			pstInsert.setString(3, password);
			pstInsert.executeUpdate();

			/* After, user data is inserted into the login table of hireupv1 database
			 * Redirect to Signup.jsp page with msg=valid
			 */
			response.sendRedirect("Signup.jsp?msg=valid");
			
		} //if(duplicate == 0) close

	}//try block close
	catch(Exception e)
	{
		/* If there's any excpetion then display message in console
		 * And redirect user to signup.jsp page with msg=exception
		 */
		System.out.println("\nSingupAction.jsp Exception: " + e);
		response.sendRedirect("Signup.jsp?msg=exception");
	}//catch block close

%>

