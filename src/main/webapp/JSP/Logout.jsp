<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" errorPage="error.jsp" %>

<%
	System.out.print("\n Logout.jsp is called \n");

	session.invalidate();
	response.sendRedirect("Index.jsp");

%>