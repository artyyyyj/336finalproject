<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Database Homepage</title>

<style>
h1 {text-align: center;}
p {text-align: center;}
div {text-align: center;}
form {text-align: center;}
</style>
</head>
<body>
    <h1><b> Welcome to a very alcoholic database! </b></h1>
    
    
    <form action="beerpage.jsp">
    <input type="submit" value="See all Beers" />
</form>
&nbsp;&nbsp;&nbsp;&nbsp;
<form action="barpage.jsp">
    <input type="submit" value="See all Bars" />
</form>
&nbsp;&nbsp;&nbsp;&nbsp;
<form action="drinkerpage.jsp">
    <input type="submit" value="See all Drinkers" />
</form>
&nbsp;&nbsp;&nbsp;&nbsp;
<form action="updatepage.jsp">
    <input type="submit" value="Make an Update to the DB" />
</form>
    

</body>
</html>