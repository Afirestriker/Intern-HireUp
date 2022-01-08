<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="Error.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<% 
try{
	/* This statement display a message on consle */
	System.out.print("\n\n ForgetPasswordAction.jsp called ");
	
	/* 
	* Make DBMS connection,
	* class DbConnection belongs to hireupdb package 
	* getConnection() is a static method of DbConnection which return connection object 
	*/
	Connection con = DbConnection.getConnection();
	
	/* Helping variable
	 * To check it given Username OR Email exist in databae or not
	*/
	int userExistance = 0;
	
	/* Here,
	 * Fetching ForgetPassworm.jsp form values
	 */
	String username = request.getParameter("username");
	String email = request.getParameter("email");
	
	/* 
	 * Check if user with given username exist or not
	 */
	String userExistanceQuery = "SELECT COUNT(*) FROM login where username = ?";
	PreparedStatement pst1 = con.prepareStatement(userExistanceQuery);
	pst1.setString(1, username);
	
	ResultSet rs1 = pst1.executeQuery();
	while(rs1.next())
	{
		/* store count value in  int userExistance variable */
		userExistance = Integer.parseInt(rs1.getString(1));
	}
	
	
	/* 
	 * if userExistance is above 0 means, user exist
	 */
	if(userExistance != 0)  //true means User Exist
	{
		
		/*  
		 * Now fecth the email which is link with the given username
		 */
		String verifyCredentialsQuery = "SELECT Email FROM login WHERE username = ?";
		PreparedStatement pst = con.prepareStatement(verifyCredentialsQuery);
		pst.setString(1, username);
		
		ResultSet rs = pst.executeQuery();
		
		while(rs.next())
		{
			/*  
			 * check whether the given email is matching with the username account
			 * i.e whether given email is link with the given username
			 */
			String email_Link_With_Username= rs.getString(1);
			if(email.equals(email_Link_With_Username))
			{
				/*  
				 * Redirecting to ResetPassword.jsp page to complete password update process
				 */
				session.setAttribute("uname", username);
				response.sendRedirect("ResetPassword.jsp");
			}
			else
			{
				/*  
				 * if given email is not registered with given username,
				 * then send msg=invalidmatch back to ForgetPassword.jsp page
				 */
				response.sendRedirect("ForgetPassword.jsp?msg=invalidMatch");
			}
		}
	
	} //if(userExistance != 0) close
	else //if user does not exist
	{
		/*
		 * if userExistance=0, then it means that user does not exist with given username
		 */
		response.sendRedirect("ForgetPassword.jsp?msg=invalid");
	}

} // try block close
catch(Exception e)
{
	/*  
	 * If exception is thrown, then display exception in console
	 * And redirect to ForgetPassword.jsp page with msg variable
	 */
	System.out.print("\nForgetPasswordAction.jsp Exception: " + e);
	response.sendRedirect("ForgetPassword.jsp?msg=exception");
}
%>