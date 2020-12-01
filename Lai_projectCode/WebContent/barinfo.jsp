<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bar Information</title>
</head>
<body>
	<%

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		
		Statement stmt = con.createStatement();
		String inputBar = request.getParameter("input");
		String testquery = "select * from bar where name = \"" + inputBar + "\"";		
		ResultSet result = stmt.executeQuery(testquery);
		
		if (result.next() == false)
		{
			out.print("Bar not found!");
		}
		
		else
		{
			//TOP 10 DRINKERS WHO ARE LARGEST SPENDERS
			String x = "select d, truncate(sum(total_price), 2) sum from (select distinct drinker d, total_price from bills where bar = \""
			+ inputBar + "\") as t1 group by d ORDER BY sum DESC limit 10";

			result = stmt.executeQuery(x);
		%>
		
		<table class="center">
		<tr>    
			<th>Drinker</th>
			<th>Total Spent at <%out.print(inputBar);%></th>
		</tr>
		
		<% 
	
		while (result.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>");
				out.print("   " + result.getString("d")+ "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   $" + result.getString("sum") + "   ");
				out.print("</td>");
				
				out.print("</tr>");
		}
		
		%>
		
		</table>
		<br/>
		<br/>
		<%
			// TOP 10 BEERS OF A BAR
			x = "select i, sum(quantity) sum from (select bill_id, item i, quantity from transactions where type = \"beer\" and bill_id in (select bill_id from bills where bar = \""+
			inputBar + "\")) as t1 group by i order by sum desc limit 10";
			result = stmt.executeQuery(x);
		%>
		
		<table>
		<tr>    
			<th>Beer</th>
			<th>Total Purchased At <%out.print(inputBar);%></th>
		</tr>
		
		<% 
	
		while (result.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>");
				out.print("   " + result.getString("i")+ "   ");
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
		// top 5 manf of a bar (sold)
		x = "select manf, sum(quantity) sum from (select transactions.bill_id, transactions.item, beer.manf, transactions.quantity FROM transactions INNER JOIN beer on transactions.item = beer.name and bill_id in (select bill_id from bills where bar = \"" 
		+ inputBar + "\")) as t1 group by manf order by sum desc limit 5";
		result = stmt.executeQuery(x);
		%>
		
			<table>
		<tr>    
			<th>Manufacturer</th>
			<th>Total Purchased At <%out.print(inputBar);%></th>
		</tr>
		
		<% 
		while (result.next()) {
			//make a row
			out.print("<tr>");
			
			out.print("<td>");
			out.print("   " + result.getString("manf")+ "   ");
			out.print("</td>");
			
			out.print("<td>");
			out.print("   " + result.getString("sum") + "   ");
			out.print("</td>");
			
			out.print("</tr>");
		}
		%>
		</table>
		
		
		<%
		x = "select hour(time) hour, count(hour(time)) count from bills where bar = \"" + inputBar + "\" group by hour(time) order by hour asc";
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
   			map.put(result.getString("hour"),result.getInt("count"));
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
 		 chartTitle = "Transactions at " + inputBar + " for every hour";
         legend = "# of transactions";
        
		
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
			
			
				<%
		x = "select day day, count(day) count from bills where bar = \"" + inputBar + "\" group by day order by count desc";
		result = stmt.executeQuery(x);
		
		 list = new ArrayList();
   		map = null;
   		myData=new StringBuilder();
   		String strData2 ="";
   	    chartTitle="";
   	    legend="";
   		

   		while (result.next()) { 
   			map=new HashMap<String,Integer>();
   			map.put(result.getString("day").substring(0, result.getString("day").length() - 1),result.getInt("count"));
   			list.add(map);
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
 		strData2 = myData.substring(0, myData.length()-1); 
 		 chartTitle = "Transactions at " + inputBar + " for every day of the week";
         legend = "# of transactions";
         
		%>
		
		
		<p></p>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data2 = [<%=strData2%>]; 
			var title2 = '<%=chartTitle%>'; 
			var legend2 = '<%=legend%>'
			cat2 = [];
			data2.forEach(function(item) {
			  cat2.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			myChart2 = Highcharts.chart('graph2', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			         
			        }
			    },
			    title: {
			        text: title2
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat2
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend2,
			        data: data2
			    }]
			});
			});
		
		</script>
		
			<div id="graph2" style="width: 750px; height: 400px; margin: 0 auto"></div>
		
		<% }
		con.close();
		%>
</body>
</html>