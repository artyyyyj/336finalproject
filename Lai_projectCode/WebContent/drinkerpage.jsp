<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	This is the drinker page. Enter a drinker's name to get started:
	
	<br>
		<form method="get" action="drinkerinfo.jsp">
			<table>
				<tr>    
					<td>Drinker</td><td><input type="text" name="inputdrinker"></td>
				</tr>
			</table>
			<input type="submit" value="See drinker information!">
		</form>
	<br>
</body>
</html>