<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="AdminError.jsp" %>

<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>

<!-- 
	Here, Admin can see user records, 
	Only needed records are displayed by fetching detail from database table
	student_personal_deatail, student_academic_detail
 -->

<%
	/* Print on console, indicating the navigation of pages */
	System.out.print("\n AdminViewUserRecords.jsp called \n");
	
	/* session attribute "admin" is set only, in LoginAction.jsp page, only when admin login,
       credentials are matched.
       Its also helps, in preventing unauthorised access to admin pages
    */
	String admin = session.getAttribute("admin").toString();
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>View User Records</title>
	<link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
	<link rel="stylesheet" type="text/css" href="../../CSS/Admin/AdminViewUserRecords.css">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

	<!-- This is JQuery embedded link, used for search field (Script is written at end of this page) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
</head>
<body>

<!-- Menu Section -->
	<%@include file="AdminHeader.jsp" %>	
<!-- End of Menu  Section -->


	<div class="admin-view-user-records-container">

		<div class="col-left">
			
			<div class="text-content">
				All Student Records
			</div>

			<div class="table-container">

			<%
				String msg = request.getParameter("msg");
				if("exception".equals(msg))
				{
			%>
				<p style="text-align: center; color: #ff6969; font-size: 20px; font-weight: bold;"> Something went wrong! Data cannot be fecthed</p>
			<%	} %>
			
			<%
				if("updateError".equals(msg))
				{
			%>
				<p style="text-align: center; color: #ff6969; font-size: 20px; font-weight: bold;"> Error in Updating Database </p>
			<%	} %>
			
			<%
				if("updated".equals(msg))
				{
			%>
				<p style="text-align: center; color: #3fc908; font-size: 20px; font-weight: bold;"> Database Updated </p>
			<%	} %>
			
			
			
				<input type="search" id="searchField" placeholder="Search for names.." title="Type in a name"> <span class="material-icons"> search </span> <br>

				<div id="printableTable">
				<table border="1">

					<thead>
						<tr>
							<th>Email</th>
							<th>Name</th>
							<th>Age</th>
							<th>Course</th>
							<th>College Grade</th>
							<th>View</th>
							<th>Current HireStatus</th>
							<th>Update HireStatus</th>
						</tr>
					</thead>

<%
	/*********************************************************************************** 
	 * Java Business Logic,
	 * 1. Making Connection with JDBC
	 * 2. Fetching Records from student_personal_detail and student_academic_detail table of hireupv1 database table
	 * 3. Displaying thoes records
	 */
	 
	 try{
		 
		/* 
		* Make DBMS connection,
		* class DbConnection belongs to hireupdb package 
		* getConnection() is a static method of DbConnection which return connection object 
		*/
		Connection con = DbConnection.getConnection();
		
		String fetchSPD = "SELECT stuemail, stufirstname, stulastname, stuage FROM student_personal_detail";
		
		Statement st = con.createStatement();
		ResultSet rsSPD = st.executeQuery(fetchSPD);
		
		while(rsSPD.next())
		{
			String fetchSAD = "SELECT stucourse, college_aggregate, hireupstatus FROM student_academic_detail WHERE stuemail = ?";
			PreparedStatement pst = con.prepareStatement(fetchSAD);
			pst.setString(1, rsSPD.getString("stuemail"));
			ResultSet rsSAD = pst.executeQuery();			
		
			while(rsSAD.next())
			{
				
%>

					<tbody id="tableBody">
						<tr>
							<td>
								<%= rsSPD.getString("stuemail")  %>
							</td>

							<td>
								<%= rsSPD.getString("stufirstname") + " " + rsSPD.getString("stulastname") %>
							</td>

							<td>
								<%= rsSPD.getInt("stuage") %>
							</td>

							<td>
								<%= rsSAD.getString("stucourse") %>
							</td>

							<td>
								'<%= rsSAD.getString("college_aggregate") %>'
							</td>

							<td>
								
								<a href="AdminViewUserResume.jsp?stuEmail=<%= rsSPD.getString("stuemail") %>" target="_blank">View</a>
							</td>

						<% 
						 if(rsSAD.getString("hireupstatus").equals("Not-Selected"))
						 {%>
							<!-- if hireupstatus == Not-Selected -->
							<td style="color:red; font-weight: bold">
								<%= rsSAD.getString("hireupstatus") %>
							</td>
							
							<td class="hirestatus">
								<a href="AdminAddHiredDetail.jsp?stuEmail=<%= rsSPD.getString("stuemail") %>&hireUpStatus=<%= rsSAD.getString("hireupstatus") %>"> <button>Mark Placed</button> </a>
							</td>
							
						<%} %>
						
						<%  
						 if(rsSAD.getString("hireupstatus").equals("Selected"))
						 {%>
							<!-- if hireupstatus == Selected -->
							<td style="color: green; font-weight: bold">
								<%= rsSAD.getString("hireupstatus") %>
							</td>
							
							<td class="hirestatus">
								<a href="AdminUpdateHireUpStatus.jsp?stuEmail=<%= rsSPD.getString("stuemail") %>&hireUpStatus=<%= rsSAD.getString("hireupstatus") %>"> <button>Mark Unplaced</button> </a>
							</td>
						<%}%>
							
						</tr>
						
					</tbody>

<%
			} /* inner while loop while(rsSAD.next()) close */
		} /* outter while loop while(rsSPD.next()) close */
		/* Closing the connection */
		con.close();
	} /* try block close */
	catch(Exception e)
	{
		 System.out.print("\n AdminViewUserRecords.jsp Exception: " + e);
		 response.sendRedirect("AdminViewUserRecords.jsp?msg=exception");
	} /* catch block close */
	
	/* ********************************************************************************* */
%>
				</table>
				</div>
				<!-- div id="printableTable" close -->

				 <button class="button_print" onclick="printDiv()">Print</button>
				 <iframe name="print_table" width="0" height="0" frameborder="0" src="about:blank"></iframe>

			</div>
			<!-- table-container close -->

		</div>
		<!-- col-left close -->
			

		<div class="col-right">
			<div class="page-img">
				<img src="https://image.freepik.com/free-vector/recruit-agent-analyzing-candidates_74855-4565.jpg">
			</div>	
		</div>
	
	</div>
	<!-- admin-view-user-records-container close -->

<!-- Footer Section -->
	<%@include file="../Footer.jsp" %>
<!-- Footer Section End -->


</body>

<!-- This fied contains concept for searching records and printing the displayed records -->
<script src="../../JS/Admin/AdminViewRecords.js"></script>

</html>