<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	This is the bar page. Enter a bar name to get started:
	
	<br>
		<form method="get" action="barinfo.jsp">
			<table>
				<tr>    
					<td>Bar</td><td><input type="text" name="input"></td>
				</tr>
			</table>
			<input type="submit" value="See bar information!">
		</form>
	<br>
	
</body>
</html>