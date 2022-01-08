<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="AdminError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<% /* JSP Scriplet Tag start, for Java Logic for getting session attribute
    * And, making JDBC connection to update records of hireupv1.contacts table
    */

    /* Print on console, indicating the navigation of pages */
	System.out.print("\n AdminUpdateContacts.jsp called \n");
	
    /* session attribute "admin" is set only, in LoginAction.jsp page, only when admin login,
       credentials are matched.
       Its also helps, in preventing unauthorised access to admin pages
    */
    String admin = session.getAttribute("admin").toString();

	
    try{
		 
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		
		String updateContactsStatusQuery = " UPDATE contacts SET contactstatus = 'read' WHERE contactstatus = 'unread' ";
		
		PreparedStatement psUpdateContactsStatus = con.prepareCall(updateContactsStatusQuery);
		
		psUpdateContactsStatus.executeUpdate();

		response.sendRedirect("AdminViewContacts.jsp?msg=updateSuccessful");
		
    } /* try block close */
    catch(Exception e)
    {
    	System.out.print("\n AdminUpdateContacts.jsp Exception: " + e);
		 response.sendRedirect("AdminViewContacts.jsp?msg=updateException");
    } /* catch block close */




/* JSP Scriptet Tag end's */ %>

