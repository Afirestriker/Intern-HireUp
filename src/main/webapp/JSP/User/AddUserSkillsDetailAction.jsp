<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>


<!-- 
	This File represent the backend process of AddUserSkillsDetail.jsp page
	Here, the value parameter is collected from AddUserSkillsDetail.jsp page
	and this values are enter with current user email id into the hireupv1.skills database table
	And,
	
	NOTE: At here, the session attribute email, which is set in UserLoginAction.jsp page is collected
		  to add current user detail in skills table and make it connect with other tables database for 
		  current user (stuemail is an foreign key in skills database table)
	
	NOTE: At the end of this page execution, we are removing session attribute email, since
		  this is the last page of data entry. Its means that if user complete the data entry of
		  skills database table, then all of his/her details are collected.
		  
	Also session attribute email, prevent wrong access to this page by using url addressing
 -->

<%
try{

	/* This statement display a message on consle, indicating current page execution */
	System.out.print("\n AddUserSkillsDetailAction.jsp called \n");

	/* Get session from UserPersonalDetail.jsp and store in User_Personal_Detail database table */
	/* email session, also helps in avoiding user to directly naviage to this page, since
	   email is set in UserLongAction.jsp which check, if user has completed its profile details or not   
	*/
	String email = session.getAttribute("email").toString();
	
	/* Get, all parameter from AddUserSkillsDetail.jsp to store in hireupb1.Skills table */
	int html = Integer.parseInt(request.getParameter("html"));
	int css = Integer.parseInt(request.getParameter("css"));
	int javaScript = Integer.parseInt(request.getParameter("javaScript"));
	int c= Integer.parseInt(request.getParameter("c"));
	int cpp = Integer.parseInt(request.getParameter("cpp"));
	int java = Integer.parseInt(request.getParameter("java"));
	int sports = Integer.parseInt(request.getParameter("sports"));
	int animation = Integer.parseInt(request.getParameter("animation"));
	int act = Integer.parseInt(request.getParameter("act"));
	int photography = Integer.parseInt(request.getParameter("photography"));
	int socialMedia = Integer.parseInt(request.getParameter("socialMedia"));
	int art = Integer.parseInt(request.getParameter("art"));
	

	/* 
	System.out.println("\n\n" + email + "\n" );
	System.out.println(html + " " + css + " " + javaScript + "\n" );
	System.out.println( c + " " + cpp + " " + java + "\n" );
	System.out.println( sports + " " + animation + " " + act + "\n" );
	System.out.println( photography + " " + socialMedia + " " + art + "\n" );
	*/
	
	/**************************************************************************
	 * Now, As parameters are collected, 
	 * Next step, is to add this values in database hireupv1.skills table
	*/
	
	/* 
	* Make DBMS connection,
	* class DbConnection belongs to hireupdb package 
	* getConnection() is a static method of DbConnection which return connection object 
	*/
	Connection con = DbConnection.getConnection();

	/* Check If user data already exist
	 * if yes, then redirect to UserLoginAction.jsp
	 * if No, then insert details
	*/
	
	String checkDuplicateEntry = "SELECT COUNT(stuemail) FROM skills WHERE stuemail = '"+email+"' ";
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(checkDuplicateEntry);
	while(rs.next())
	{
		if(rs.getInt(1) != 0)
		{
			response.sendRedirect("UserLoginAction.jsp");
		}
	}
	
	/* Write MySql query to insert values in hireupv1.skills table */
	String updateSkills = "INSERT INTO skills VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	
	/* Using PreparedStatement interface to update database table,
	 * since we are accepting value at run time
	*/
	PreparedStatement pst = con.prepareStatement(updateSkills);
	pst.setString(1, email);
	pst.setInt(2, html);
	pst.setInt(3, css);
	pst.setInt(4, javaScript);
	pst.setInt(5, c);
	pst.setInt(6, cpp);
	pst.setInt(7, java);
	pst.setInt(8, sports);
	pst.setInt(9, animation);
	pst.setInt(10, act);
	pst.setInt(11, photography);
	pst.setInt(12, socialMedia);
	pst.setInt(13, art);
	
	pst.executeUpdate();

	/* One database is successfully updated,
	 * remove session and redirect to UserIndex.jsp page
	*/
	
	/* 
	 * Remove session with attribute="email"
	 * As, now data entry is done, and email is not required for further procesing
	*/
	session.removeAttribute("email");
	response.sendRedirect("UserIndex.jsp");
	
}
catch(Exception e)
{
	/* In Case if run-time exception is thrown 
	 * Then, counter comes inside catch block and display error on console
	 * And, redirect to AddUserSkillsDetail.jsp with messsage  = exception
	 * Then, at AddUserSkillsDetail.jsp there's an condition which check if msg = exception 
	   and accordingly message is display on that page
	*/
	System.out.println("AddUserSkillsDetailAction.jsp Exception: " + e);
	response.sendRedirect("AddUserSkillsDetail.jsp?msg=exception");
}

%>