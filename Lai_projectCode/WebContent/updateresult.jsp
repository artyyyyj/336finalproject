<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<style>
h1 {text-align: center;}
p {text-align: center;}
div {text-align: center;}
th {text-align: center;}
td {text-align: center;}


table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
  margin-left:auto;
  margin-right:auto;
}
</style>
</head>
<body>
	<%
			try
			{
			String inputUpdate = request.getParameter("inputupdate");
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			stmt.executeUpdate(inputUpdate);
			out.println("Update Successfully Made!");
		}
		catch(SQLException e){
			int i = e.getErrorCode();
			
			if (i == 1062)
			{
				out.println("Duplicate primary key! Insertion has failed.");
			}
			
			else if (i == 1452)
			{
			out.println("Foreign key constraint fails! Insertion has failed.");
			}
		}
		%>
</body>
</html>