<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="AdminError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	Here, User HireUpStatus is updated,
	if current HireUpStatus == Not-Selected
		then -> change it to Selected
	And,
		Vice-Versa
	with Updating hireupv1.company table
 -->

<%!
	String stuEmail = null;
	String currentHireUpStatus = null;
%>


<%
	
	/* Print on console, indicating the navigation of pages */
	System.out.print("\n AdminUpdateHireUpStatus.jsp called \n");
	
	/* session attribute "admin" is set only, in LoginAction.jsp page, only when admin login,
	   credentials are matched.
	   Its also helps, in preventing unauthorised access to admin pages
	*/
	String admin = session.getAttribute("admin").toString();
	
	/*  
	  colleting parameter passed from either AdminAddHireUpDetail.jsp form submit
	  OR,
	  From AdminViewUserRecords.jsp onClick of 'Mark As Not-Selected'
	*/
	stuEmail = request.getParameter("stuEmail");
	currentHireUpStatus = request.getParameter("hireUpStatus");
	
	System.out.println("\n CurrentHireStatus: " + currentHireUpStatus + "\n");
	
		
	try{
		 
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		

		/* if HireUpStatus == NOT-SELECTED */
		if("Not-Selected".equals(currentHireUpStatus))
		{
			/* Add student Hired Company Detail in hireupv1.company database table */
			String companyName = request.getParameter("companyName");
			String joiningDate = request.getParameter("joiningDate");
			String packageValue = request.getParameter("package");
			
			String offerLetterStatus = request.getParameter("offerLetterStatus");
			
			if("YES".equals(offerLetterStatus))
			{
				offerLetterStatus = "Recieved";
			}
			else
			{
				offerLetterStatus = "Not-Recieved";
			}
			
			/* Query to add details in hireupv1.Company Database Table */
			String insertIntoCompanyQuery = "INSERT INTO company VALUES (?, ?, ?, ?, ?)";
			
			PreparedStatement pstInsertIntoCompany = con.prepareStatement(insertIntoCompanyQuery);
			pstInsertIntoCompany.setString(1, stuEmail);
			pstInsertIntoCompany.setString(2, companyName);
			pstInsertIntoCompany.setString(3, joiningDate);
			pstInsertIntoCompany.setString(4, packageValue);
			pstInsertIntoCompany.setString(5, offerLetterStatus);
			
			int insertStatus = pstInsertIntoCompany.executeUpdate();
			
			if(insertStatus == 0)
			{
				response.sendRedirect("AdminAddHiredDetail.jsp?msg=insertError");
			}
			
			
			/*
			 * After Data is added into company table successfully,
			   Update HireUpStatus from Not-Selected to Selected 
			*/
			String updateHireUpStatusQuery = "UPDATE student_academic_detail "
										   + "SET hireupstatus = 'Selected' "
										   + "WHERE stuemail = ?";
			
			PreparedStatement pstUpdateHireUpStatus = con.prepareStatement(updateHireUpStatusQuery);
			pstUpdateHireUpStatus.setString(1, stuEmail);
			int updateStatus = pstUpdateHireUpStatus.executeUpdate();
			if(updateStatus != 0)
			{
				response.sendRedirect("AdminViewUserRecords.jsp?msg=updated");
			}
			else
			{
				response.sendRedirect("AdminViewUserRecords.jsp?msg=updateError");
			}
		}
		/* if currentHireUpStatus == "Not-Selected" close */
				
		
		/* if HireUpStatus == SELECTED */
		if(currentHireUpStatus.equals("Selected"))
		{
			/* Delete records from company table for stuemail = stuEmail... */
			String deleteCompanyRecordQuery = "DELETE FROM company WHERE stuemail = ?";
			PreparedStatement pstDeleteCompanyRecord = con.prepareStatement(deleteCompanyRecordQuery);
			pstDeleteCompanyRecord.setString(1, stuEmail);
			
			int insertStatus = pstDeleteCompanyRecord.executeUpdate();
			
			if(insertStatus == 0)
			{
				response.sendRedirect("AdminViewUserRecords.jsp?msg=updateError");
			}
					
			/* After record deleted from company table, update Student HireUpStatus to Not-Selected */
			String updateHireUpStatusQuery = "UPDATE student_academic_detail "
										   + "SET hireupstatus = 'Not-Selected' "
										   + "WHERE stuemail = ?";
			
			PreparedStatement pstUpdateHireUpStatus = con.prepareStatement(updateHireUpStatusQuery);
			
			pstUpdateHireUpStatus.setString(1, stuEmail);
			
			int updateStatus = pstUpdateHireUpStatus.executeUpdate();
			
			if(updateStatus != 0)
			{
				response.sendRedirect("AdminViewUserRecords.jsp?msg=updated");
			}
			else
			{
				response.sendRedirect("AdminViewUserRecords.jsp?msg=updateError");
			}
		}
		/* if currentHireUpStatus == "Selected" close */


	} /* try block close */
	catch(Exception e)
	{
		System.out.print("\n AdminUpdateHireUpStatus.jsp Exception: " + e);
		 response.sendRedirect("AdminUpdateHireUpStatus.jsp?msg=exception");
		
	} /* catch block close */
		
%>

