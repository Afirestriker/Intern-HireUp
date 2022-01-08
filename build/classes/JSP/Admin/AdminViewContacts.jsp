<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="AdminError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>


<!-- This page display, the contact-us detail to the admin, which includes
	 1. feedback
	 2. question, etc
 -->

<% /* JSP Scriplet Tag start, for Java Logic for getting session attribute
    * And, making JDBC connection to fetch records from hireupv1.contacts table
    */

    /* Print on console, indicating the navigation of pages */
	System.out.print("\n AdminViewContacts.jsp called \n");
	
    /* session attribute "admin" is set only, in LoginAction.jsp page, only when admin login,
       credentials are matched.
       Its also helps, in preventing unauthorised access to admin pages
    */
    String admin = session.getAttribute("admin").toString();

/* JSP Scriptet Tag end's */ %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>View Contacts Messages</title>
	<!-- link rel="icon", for displaying image in tab bar -->
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">

	<!-- link rel="stylesheet, for connecting css styling file -->
	<link rel="stylesheet" type="text/css" href="../../CSS/Admin/AdminViewContacts.css">

	<!-- this stylesheet is of google for icons design -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

	<!-- This is jquery embeded link, used for search field (Script is written at end of this page) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	

</head>
<body>

<!-- Menu Section -->
	<%@include file="AdminHeader.jsp" %>	
<!-- End of Menu  Section -->


	<div class="admin-view-messages-container">

		<div class="col-left">
			
			<div class="table-heading">
				Contacts Messages
			</div>

			<div class="table-container">

				<%
				String msg = request.getParameter("msg");
				
				/* This message is coming from this page when exception is thrown */
				if("exception".equals(msg))
				{
				%>
				<p style="text-align: center; color: red; font-size: 20px; font-weight: bold;"> Something went wrong! Data cannot be fetched</p>
				<%} %>
				
				<%
				/* This message is coming from AdminUpdateContacts.jsp page */
				if("updateSuccessful".equals(msg))
				{
				%>
				<p style="text-align: center; color: yellow; font-size: 20px; font-weight: bold;"> Data updated Successfully</p>
				<%} %>
				
				<%
				/* This message is coming from AdminUpdateContacts.jsp page */
				if("updateException".equals(msg))
				{
				%>
				<p style="text-align: center; color: red; font-size: 20px; font-weight: bold;"> Something went wrong! Data cannot be update</p>
				<%} %>
				
				<input type="search" id="searchField" placeholder="Search for names.." title="Type in a name"> <span class="material-icons"> search </span> <br>

				<table>

					<thead>
						<tr>
							<th>Email</th>
							<th>Name</th>
							<th>Place</th>
							<th class="col-comment">Comment</th>
							<th>Mark As Read</th>
						</tr>
					</thead>


<%
	/*********************************************************************************** 
	 * Java Business Logic,
	 * 1. Making Connection with JDBC
	 * 2. Fetching Records from hireupv1.contacts database table
	 * 3. Displaying the records
	 */
	 
	 try{
		 
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		
		/* variable, which hold result of query to countRecords in hireupv1.contacts table */
		int contactsRecordCount = 0;
		
		/* Query fetching records count in contacts table */
		String countContactsRecordsQuery = "SELECT COUNT(*) FROM contacts";
		Statement stCountContactsRecord = con.createStatement();
		ResultSet rsCountContactsRecord = stCountContactsRecord.executeQuery(countContactsRecordsQuery);
		while(rsCountContactsRecord.next())
		{
			contactsRecordCount = rsCountContactsRecord.getInt(1);
		} /* while(rsCountContacsRecord.next()) loop close */
		
%>
					<tbody id="tableBody">
						
						<!-- table row to display, if contact table records count is zero -->
						<%
						 if(contactsRecordCount == 0)
						 {
						%>
						<tr>
							<td colspan="6"> No Any Data To Display</td>
						</tr>
						<% } %>

<%
		/* query fetching records from contacts table */
		String fetchContactsQuery = "SELECT * FROM contacts";
		Statement stFetchContacts = con.createStatement();
		ResultSet rsFetchContacts = stFetchContacts.executeQuery(fetchContactsQuery);
		
		while(rsFetchContacts.next())
		{

%>

						<!-- table rows to display, if contact table records count is non zero -->
						<tr>
							<td>
								<%= rsFetchContacts.getString("contactemail") %>
							</td>

							<td>
								<%= rsFetchContacts.getString("contactname") %>
							</td>

							<td>
								<%= rsFetchContacts.getString("contactplace") %>
							</td>

							<td class="col-comment">
								<%= rsFetchContacts.getString("contactcomment") %>
							</td>

							<td>
								<%
								 if(rsFetchContacts.getString("contactstatus").equals("unread"))
								 {
								%>
								<input type="checkbox" name="unread">
								<%} %>
								
								<%
								 if(rsFetchContacts.getString("contactstatus").equals("read"))
								 {
								%>
								<input type="checkbox" name="Read" checked>
								<%} %>
								
							</td>

						</tr>

<%
		} /* while(rsFetchContacts.next()) loop close */
		
		/* Closing the connection */
		con.close();
	} /* try block close */
	catch(Exception e)
	{
		 System.out.print("\n AdminViewContacts.jsp Exception: " + e);
		 response.sendRedirect("AdminViewContacts.jsp?msg=exception");
	} /* catch block close */
	
	/* ********************************************************************************* */
%>

						<!-- Table Last Row -->
						<!-- Update Contacts Button -->
						<tr class="update-conacts-button">
							<td colspan="4"></td>

							<td colspan="2">
								<a href="AdminUpdateContacts.jsp"> <button>Mark All As Read</button> </a>
							</td>
						</tr>

					</tbody>

		
					
				</table>

			</div>
			<!-- table-container close -->

		</div>
		<!-- col-left close -->
			

		<div class="col-right">
			<div class="page-img">
				<img src="../../Images/Admin/contact-messages.jpg">
			</div>	
		</div>
		<!-- col-right close -->
	
	</div>
	<!-- admin-view-user-records-container close -->


<!-- Footer Section -->
	<%@include file="../Footer.jsp" %>
<!-- Footer Section End -->


<!-- This is JQuery script code for working of search field, for searching rcords live in the file -->
<script>
    $(document).ready(function() {
        $("#searchField").on("keyup", function() {
            var value = $(this).val().toLowerCase();
            $("#tableBody tr").filter(function() {
                $(this).toggle($(this).text()
                .toLowerCase().indexOf(value) > -1)
            });
        });
    });
</script>


</body>
</html>