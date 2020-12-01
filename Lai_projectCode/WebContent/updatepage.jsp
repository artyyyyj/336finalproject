<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Database Update Page</title>
<style>
h1 {text-align: center;}
p {text-align: center;}
div {text-align: center;}
th {text-align: center;}
td {text-align: center;}
form {text-align: center;}

table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
  margin-left:auto;
  margin-right:auto;
}

</style>
</head>
<body>
<br/>
<br/>
<form method="get" action="updateresult.jsp">
			<table>
				<tr>    
					<td>UPDATE: </td><td><input type="text" name="inputupdate"  size="100"></td>
				</tr>
			</table>
			<br/>
			<input type="submit" value="Make Update!">
		</form>
		
</body>
</html>