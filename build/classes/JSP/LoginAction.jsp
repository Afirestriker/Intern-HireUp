<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="Error.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<%
	
	try{
		/* This statement display a message on consle */
		System.out.print("\n\n LoginAction.jsp called ");
		
		/* Get username and password parameter from Login.jsp */
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		
		
		/* NOTE: In where clause BINARY keyword is used to match for case-sentive, 
		   as MySql by default match result as non-case-sensitive 
		*/
		String checkUserType = "SELECT COUNT(*) FROM admin WHERE BINARY username = ?";
		PreparedStatement pstCheckUserType = con.prepareStatement(checkUserType);
		pstCheckUserType.setString(1, username);
		
		ResultSet rsCheckUserType = pstCheckUserType.executeQuery();
		
		int userTypeCheck = 0;
		while(rsCheckUserType.next())
		{
			userTypeCheck = rsCheckUserType.getInt(1);
		}
		
		if(userTypeCheck != 0)
		{
			System.out.print("\n Admin Login \n");
			
			/* Admin Login Validation */
			/* Sql query to get password that is link with given Admin username */
			String checkAccount = "SELECT Password FROM admin WHERE Username = ?";
			
			/* Using PreparedStatement interface for executing sql query */
			PreparedStatement pst = con.prepareStatement(checkAccount);
			/* passing run-time parameter to sql query */
			pst.setString(1, username);
			
			ResultSet rs = pst.executeQuery();
			
			/* while loop to fetch password and check if entered password matched with database password for that admin username */
			while(rs.next())
			{
				
				/* 
				 * Here, we collect the password registered with given username in the database
				 */
				String realPassword = rs.getString(1);
				
				/* 
				 * Here, we check if the entered password matched with the password in database 
				 * If yes, then redirect to user home screen,
				 * else, redirect to login page and display message
				*/
				if(realPassword.equals(password))
				{
					/* Here, creating session attribute with value = "admin"
					 * "admin" because so that, user will not have access to admin pages
					 * since, at each admin page, we are collecting session attribute "admin"
					   which is set only when admin username and password is enter and console
					   comes here
					 */
					session.setAttribute("admin", username);
					response.sendRedirect("Admin/AdminIndex.jsp");
				}
				else
				{
					response.sendRedirect("Login.jsp?msg=invalid");
				} /* while loop nested if else close */
			
			} /* while close */
			
		} /* if condition for admin login and admin validation close */
		else
		{
			/* if console, does not enter inside if, 
			 * its comes in else, which means user is trying to login, 
			 * here we check for user login and validation
			*/
			
			System.out.print("\n User Login \n");
					 
			/* 
			 * helping variable to check if account with entered username exist or not
			 * 0 means no account with specified username
			 */
			int validateAccount = 0;

			/* User Login check */
			/* Sql query to get password that is link with given username */
			String checkAccount = "SELECT Password FROM login WHERE Username = ?";
			
			/* Using PreparedStatement interface for executing sql query */
			PreparedStatement pst = con.prepareStatement(checkAccount);
			/* passing run-time parameter to sql query */
			pst.setString(1, username);
			
			ResultSet rs = pst.executeQuery();
			
			/* 
			 * while loop to check if username exist
			 * change validateAccount variable value to 1 indicating that username exits
			*/
			while(rs.next())
			{
				validateAccount = 1;
				
				/* 
				 * Here, we collect the password registered with given username in the database
				 */
				String realPassword = rs.getString(1);
				
				/* 
				 * Here, we check if the entered password matched with the password in database 
				 * If yes, then redirect to user home screen,
				 * else, redirect to login page and display message
				*/
				if(realPassword.equals(password))
				{
					session.setAttribute("username", username);
					response.sendRedirect("User/UserLoginAction.jsp");
				}
				else
				{
					response.sendRedirect("Login.jsp?msg=invalid");
				} //while loop nested if else close
			
			} /* while close */
	
			/* validateAccount with value 0, means that account with given username does not exist */
			if(validateAccount==0)
			{
				response.sendRedirect("Login.jsp?msg=notexist");
			}
			
		} /* else close (whcih is link to if(admin validation)) */ 
	
	} /* try block close */
	catch(Exception e)
	{
		/* 
		 * If there is any run time exception then, the excpetion is display in console
		 * And user is redirected back to Login.jsp page
		*/
		System.out.print("\nLoginAction/jsp Exception: " + e);
		response.sendRedirect("Login.jsp?msg=exception");
	
	} /* catch block close */
%>
