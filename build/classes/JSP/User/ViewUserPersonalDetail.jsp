<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="UserError.jsp" %>
    
<!-- importing hireupdb package classes and interface for connection to database -->
<%@ page import="hireupdb.*" %>

<!-- importing java.sql package which provide classes and interfaces for JDBC -->
<%@ page import="java.sql.*" %>


<!--
	This page is used to show user his/her personal information,
	NOTE: AboutME information is not shown here.
-->


<%!
	/* This are variables, declared outside service() method, and available in the whole page
	 * This variables are used to store the column values fetched from database table
	*/
	String email = null;
	String firstname = null;
	String lastname = null;
	String birthdate = null;
	int age;
	String mobile = null;
	String gender = null;
	String address = null;
	String city = null;
	String country = null;
%>

<% 
try{
	/* Print message on console, indicating which page is visited */
	System.out.println("\n ViewUserPersonalDetail.jsp Called \n"); 
	
	/* collect username value, from session set in JSP/LoginAction.jsp page */
	String username = session.getAttribute("username").toString();

	/* 
	* Make DBMS connection,
	* class DbConnection belongs to hireupdb package 
	* getConnection() is a static method of DbConnection which return connection object 
	*/
	Connection con = DbConnection.getConnection();

	/* User Personal Details validation, does it exist or not */
	
		String checkDetailInPersonalDetailTable = "SELECT COUNT(stuemail) FROM student_personal_detail WHERE stuemail = (SELECT email FROM login WHERE username = ?)";
		PreparedStatement pstCheckPersonalDetail = con.prepareStatement(checkDetailInPersonalDetailTable);
		pstCheckPersonalDetail.setString(1, username);
		ResultSet rs1 = pstCheckPersonalDetail.executeQuery();
		while(rs1.next())
		{
			if(rs1.getInt(1) == 0)
			{
				response.sendRedirect("UserLoginAction.jsp");
			}
		}
	
	/* User Detail Validation End */
	
	String fetchPdQuery = "SELECT * FROM student_personal_detail WHERE stuemail = (SELECT email FROM login WHERE username = '"+username+"') ";
	Statement st = con.createStatement();
	ResultSet rs = st.executeQuery(fetchPdQuery);
	
	while(rs.next())
	{
		email = rs.getString("stuemail");
		firstname = rs.getString("stufirstname");
		lastname = rs.getString("stulastname");
		birthdate = rs.getString("stubirthdate");
		age = rs.getInt("stuage");
		mobile = rs.getString("stumobile");
		
		if("M".equals(rs.getString("stugender")))
		{
			gender = "Male";
		}
		else if("F".equals(rs.getString("stugender")))
		{
			gender = "Female";
		}
		else
		{
			gender = "Other";
		}
		
		address = rs.getString("stuaddress");
		city = rs.getString("stucity");
		country = rs.getString("stucountry");

	} //while loop close
	
}
catch(Exception e)
{
	System.out.println("\n ViewUserPersonalDetail.jsp Exception: " + e);
}
%>    
    

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<title>User Personal Details</title>
	
	<!-- display image in browser tab -->
    <link rel="icon" href="../../Images/HireUpIcon.png" type="image/png">
    
    <!-- Link CSS file to style this page -->
    <link rel="stylesheet" href="../../CSS/User/ViewUserDetails.css">
</head>
<body>

<!-- Menu Section -->
	<%@include file="UserHeader.jsp" %>	
<!-- End of Menu  Section -->


<div class="container" style="width:1140px; height:840px; padding-top: 150px;">

    <div class="left">
    	<!-- Display image in left side container -->
        <img src="../../Images/user/woman-laptop-pic.jpg" title="woman working on laptop" alt="user-profile">
    </div>

    <div class="right">

        <div class="info">
            <p class="info-title">Personal Information</p> <br>
            
            <div class="info-data">
                <label for="Email">Email</label> <br>
                <p> <%= email %> </p>
         
                <label for="Name">Name</label> <br>
                <p><%= firstname + " " + lastname %></p>
                
                <label for="Birth-Date">Birth-Date</label>
                <p><%= birthdate %></p>

                <label for="Age">Age</label> <br>
                <p> <%= age %> </p>

				<label for="Mobile">Mobile</label>
                <p> <%= mobile %> </p>

                <!-- If m = male, f = female, o = other -->
                <label for="Gender">Gender</label> <br>
                <p> <%= gender %> </p>

				<label for="Address">Address</label> <br>
                <p><%= address %></p>

                <label for="City (Country)">City (Country)</label> <br>
                <p> <%= city + " (" + country + ")" %> </p>
					
				<div class="button-edit">
      				<!-- Edit Button which redirect to setting page for editing user details -->
        			<a href="UserSettings.jsp"><button>Update Detail </button></a>    
      			</div>

            </div>
            <!-- class info-data close -->
        
        </div>
        <!-- class info close -->

    </div>
    <!-- class right close -->

</div>
<!-- class container close  -->

</body>
</html>
