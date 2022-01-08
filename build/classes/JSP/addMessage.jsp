<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="Error.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>
	
<% 
	/* This statement display a message on consle */
	System.out.print("\n\n addMessage.jsp called ");

	/* Here,
	 * Fetching form values, which are entered in index.jsp contact form
	 */
	String name    = request.getParameter("name");
	String email   = request.getParameter("email");
	String place   = request.getParameter("place");
	String comment = request.getParameter("comment");
	
	/* Helping variable, to check if sql query execute or note */
	int status = 0;
	
	try{
		/* 
		 * DbConnection class belong to hireupdb package
		 * getConnection() staic method of DbConnection class
		 * getConnection() throws connection object which prodivde jdbc connection
		 * Here, we are connecting to mysql 'hireupv1' database
		*/
		Connection con = DbConnection.getConnection();
		String sq = "INSERT INTO contacts (contactname, contactemail, contactplace, contactcomment) VALUES (?, ?, ?, ?)";
		
		/*
		 * using PreparedStatement interface, which runs parameterized query
		 * since we are passing variable in run-time and PreparedStatement provide,
		   better performance (compile only once).
		*/
		PreparedStatement pst = con.prepareStatement(sq);
		pst.setString(1, name);
		pst.setString(2, email);
		pst.setString(3, place);
		pst.setString(4, comment);
		
		/* 
		 * executeUpdate() is method used to execute DML database query 
		 * Its, update the contacts table and stores given value in it.
		 */
		status = pst.executeUpdate();
		
		if(status != 0)
		{
			response.sendRedirect("Index.jsp?msg=valid&name=" +name + "#contact");
		}
	}
	catch(Exception e)
	{
		/* If, exception is thrown,
		 * Display exception message in console
		 * Redirect to Index.jsp with msg=invalid
		 */
		System.out.println("addMessage.jsp Exception: " + e);
		response.sendRedirect("Index.jsp?msg=invalid#contact");
	
	}

%>
