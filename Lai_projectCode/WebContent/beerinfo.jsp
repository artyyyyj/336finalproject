<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Beer Information</title>
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
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
		String inputBeer = request.getParameter("inputbeer");
		String testquery = "select * from beer where name = \"" + inputBeer + "\"";		
		ResultSet result = stmt.executeQuery(testquery);
		
		if (result.next() == false)
		{
			out.print("Beer not found!");
		}
		
		else
		{
			String x = "select bar, sum(quantity) sum from (select bills.bill_id, bills.bar, transactions.item, transactions.quantity, transactions.type FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and transactions.type = \"beer\" and transactions.item =\"" 
		+ inputBeer + "\") as t1 group by bar order by sum desc limit 5";
			result = stmt.executeQuery(x);
			
			%>
			
			<strong><center>Information for <%out.print(inputBeer);%> </center></strong>
			<br/>
			<table class="center">
			<tr>    
				<th>Bar</th>
				<th>Total <%out.print(inputBeer);%> bought</th>
			</tr>
			
			<%
			while (result.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>");
				out.print("   " + result.getString("bar")+ "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("sum") + "   ");
				out.print("</td>");
				
				out.print("</tr>");
			}
		
			%>
		
		</table>
		<br/>
		<br/>
		<%
		 x = "select drinker, sum(quantity) sum from (select bills.bill_id, bills.drinker, transactions.item, transactions.quantity, transactions.type FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and transactions.type = \"beer\" and transactions.item =\"" 
		+ inputBeer + "\") as t1 group by drinker order by sum desc limit 10";
		result = stmt.executeQuery(x);
		%>
		
		<table class="center">
			<tr>    
				<th>Drinker</th>
				<th>Total <%out.print(inputBeer);%> bought</th>
			</tr>
		
		<%
			while (result.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>");
				out.print("   " + result.getString("drinker")+ "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("sum") + "   ");
				out.print("</td>");
				
				out.print("</tr>");
			}
		
			%>
		</table>
		<br/>
		<br/>
		<%
			x = "select hour(time) hour, sum(quantity) sum from (select bills.bill_id, bills.time, transactions.item, bills.bar, transactions.quantity, transactions.type FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and transactions.type = \"beer\" and transactions.item =\""
			+ inputBeer + "\") as t1 group by hour";
			result = stmt.executeQuery(x);
			
			ArrayList<Map<String,Integer>> list = new ArrayList();
	   		Map<String,Integer> map = null;
	   		StringBuilder myData=new StringBuilder();
	   		String strData1 ="";
	   	    String chartTitle="";
	   	    String legend="";
	   		
	   		for (int i = 0; i < 24; i++)
	   		{
	   			map = new HashMap<String, Integer>();
	   			map.put("" + i, 0);
	   			list.add(map);
	   		}
	   		
	   		int count = 0;
	   		while (result.next()) { 
	   			count = result.getInt("hour");
	   			map=new HashMap<String,Integer>();
	   			map.put(result.getString("hour"),result.getInt("sum"));
	   			list.set(count, map);
	   	    } 
	   	    result.close();
	   	    
	   	 for(Map<String,Integer> hashmap : list){
	 		Iterator it = hashmap.entrySet().iterator();
	     	while (it.hasNext()) { 
	    		Map.Entry pair = (Map.Entry)it.next();
	    		String key = pair.getKey().toString().replaceAll("'", "");
	    		myData.append("['"+ key +"',"+ pair.getValue() +"],");
	    	}
	 }
	 		strData1 = myData.substring(0, myData.length()-1); 
	 		 chartTitle = "Purchases of " + inputBeer + " for every hour of the day";
	         legend = "# of purchases";
		%>
		<p></p>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data = [<%=strData1%>]; 
			var title = '<%=chartTitle%>'; 
			var legend = '<%=legend%>'
			var cat = [];
			data.forEach(function(item) {
			  cat.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			var myChart1 = Highcharts.chart('graphContainer', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			         
			        }
			    },
			    title: {
			        text: title
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend,
			        data: data
			    }]
			});
			});
		
		</script>
			<div id="graphContainer" style="width: 750px; height: 400px; margin: 0 auto"></div>
		
			
		<% }
		con.close();
	%>
</body>
</html>