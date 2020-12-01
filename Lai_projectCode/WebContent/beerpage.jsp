<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	This is the beer page. Enter a beer name to get started:
	
	<br>
		<form method="get" action="beerinfo.jsp">
			<table>
				<tr>    
					<td>Beer</td><td><input type="text" name="inputbeer"></td>
				</tr>
			</table>
			<input type="submit" value="See beer information!">
		</form>
	<br>
	
</body>
</html>