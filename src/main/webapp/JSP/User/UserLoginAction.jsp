
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="../Login.jsp" %>

<!-- 
Steps:
	 * 1. Check if user is new, by checking whether the email, registered with given username is store in student personal and academic detail
	 * 2. If email is present in both table, then redirect to Dashboard
	 * 3. If email is not present in any one of them, then redirect to fill that table attributes value
 -->

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>


<%
	/* This statement display a message on consle */
	System.out.print("\n UserLoginAction.jsp called \n");

	/* Get username parameter from Login.jsp */
	String username = session.getAttribute("username").toString();
%>

<%! 
	String email = null;
	int recordCount = 0;
%>
		
<%
	try{
		
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		
		/* Query to fetched email from login table, which is associated with username */
		String fetchedEmailQuery = "SELECT Email FROM login WHERE Username = ?";
		PreparedStatement pst = con.prepareStatement(fetchedEmailQuery);
		pst.setString(1, username);
		ResultSet rs = pst.executeQuery();
		while(rs.next())
		{
			/* Store email in String email */
			email = rs.getString(1);
		}
		
		if(!email.equals(null))
		{
			/* check current user records with email in student personal detail table 
			 * if exist i.e recordCount != 0,
			 * if not exist, i.e recordCount == 0
			*/
			String checkEmail_spd = "SELECT COUNT(*) FROM student_personal_detail WHERE StuEmail = ?";
			PreparedStatement pst1 = con.prepareStatement(checkEmail_spd);
			pst1.setString(1, email);
			ResultSet rs1 = pst1.executeQuery();
			while(rs1.next())
			{
				recordCount = rs1.getInt(1);
			}
			
			/* check if email exist in student_personal_detail or not
			 * If not, then go inside if condition
			 * If yes then go in else block, to check with student_academic_detail
			*/
			if(recordCount == 0)
			{
				session.setAttribute("email", email);
				response.sendRedirect("AddUserPersonalDetail.jsp");
			}
			else
			{
				/* check email in student academic detail table */
				String checkEmail_sad = "SELECT COUNT(*) FROM student_academic_detail WHERE StuEmail = ?";
				PreparedStatement pst2 = con.prepareStatement(checkEmail_sad);
				pst2.setString(1, email);
				ResultSet rs2 = pst2.executeQuery();
				while(rs2.next())
				{
					recordCount = rs2.getInt(1);
				}
				
				/* If email is not present in student_academic_detail table then go inside if condition
				 * If email exist in student_academic_detail then go in else block				
				*/
				if(recordCount == 0)
				{
					session.setAttribute("email", email);
					response.sendRedirect("AddUserAcademicDetail.jsp");
				}
				else
				{
					/* Check Skills table records exist for current user or not */
					String checkSkillsDetails = "SELECT COUNT(stuemail) FROM skills WHERE stuemail = ?";
					PreparedStatement pstCheckSkillsDetails = con.prepareStatement(checkSkillsDetails);
					pstCheckSkillsDetails.setString(1, email);
					ResultSet rsCheckSkills = pstCheckSkillsDetails.executeQuery();
					while(rsCheckSkills.next())
					{
						recordCount = rsCheckSkills.getInt(1);	
					}
					
					if(recordCount == 0)
					{
						session.setAttribute("email", email);
						response.sendRedirect("AddUserSkillsDetail.jsp");
					}
					else
					{	
						/* If cursor comes here,
						 * Its means, that user is old, and his/her data is entered already
						*/
	
						/* NOTE: Session (attribute="username") is already set in LoginAction.jsp page */
						response.sendRedirect("UserIndex.jsp");
					}
				
				} /* else close, checking record using email in skills table for current user */
			
			} /* else close, checking record using email in student academic detail table for current user */
			
		} /* if(!email.equals(null)) close, and checking student_personal_detail table if current user record exist or not */

		
		
	} //try block close
	catch(Exception e)
	{
		/* 
		 * If there is any run time exception then, the excpetion is display in console
		 * And user is redirected back to Login.jsp page
		*/
		System.out.print("\nUserLoginAction.jsp Exception: " + e);
	
	} //catch block close
		

%>
