<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	This page is used for Updating skills database table 
	This page is called from UserSettins.jsp page -> Update Skills Form Action
-->

<%

	/* Print message on console, indicating which page is visited */
	System.out.print("\n UpdateUserSkillsAction.jsp page called \n");
	String username = session.getAttribute("username").toString();
	
	/* Collecting and storing parameter from update skills form action */
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
	 * Next step, is to update this values in database hireupv1.skills table
	*/

	/* Inside try block, connection with JDBC, and executing update query */
	try{
		
		/* 
		 * Make DBMS connection,
		 * class DbConnection belongs to hireupdb package 
		 * getConnection() is a static method of DbConnection which return connection object 
		 */
		Connection con = DbConnection.getConnection();

		String updateSkills =  "UPDATE skills "
							+  "SET html = ?, css = ?, javascript = ?, c = ?, cpp = ?, java = ?, sports = ?, animation = ?, act = ?, photography = ?, socialmedia = ?, art = ? "
							+  "WHERE stuemail = (SELECT email FROM login WHERE username = ?)";

		PreparedStatement pst = con.prepareStatement(updateSkills);
		pst.setInt(1, html);
		pst.setInt(2, css);
		pst.setInt(3, javaScript);
		pst.setInt(4, c);
		pst.setInt(5, cpp);
		pst.setInt(6, java);
		pst.setInt(7, sports);
		pst.setInt(8, animation);
		pst.setInt(9, act);
		pst.setInt(10, photography);
		pst.setInt(11, socialMedia);
		pst.setInt(12, art);
		
		pst.setString(13, username);
		
		/* status is used, to hold the return value of pst.executeUpdate()
		 * if status != 0, its mean , that at a row is affected i.e record updated
		 * if status == 0, its mena, that no row is affected i.e no record updated
		*/
		int status = pst.executeUpdate();
		
		if(status != 0)
		{
			response.sendRedirect("UserSettings.jsp?update=updated");
		}
		
		if(status == 0)
		{
			response.sendRedirect("UserSettings.jsp?update=notupdated");
		}
		
	} /* try block close */
	catch(Exception e)
	{
		System.out.print("\n UpdateUserSkillsAction.jsp Exception: " + e);
		response.sendRedirect("UserSettings.jsp?update=exception");
	} /* catch block close */
	
%>

