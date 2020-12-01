<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Drinker Information</title>
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
		String inputDrinker = request.getParameter("inputdrinker");
		String testquery = "select * from drinker where name = \"" + inputDrinker + "\"";		
		ResultSet result = stmt.executeQuery(testquery);
		
		if (result.next() == false)
		{
			out.print("Drinker not found!");
		}
		
		else
		{
			String x = "select bills.bill_id, transactions.item, transactions.quantity, transactions.type, bills.bar, bills.date, bills.time FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and drinker = \"" 
		+ inputDrinker + "\" ORDER BY bar, date desc, hour(time) desc";
			result = stmt.executeQuery(x);
		%>
		<strong><center>Information for <%out.print(inputDrinker);%> </center></strong>
			<br/>
			<table class="center">
			<tr>    
				<th>bill_id</th>
				<th>item</th>
				<th>quantity</th>
				<th>type</th>
				<th>bar</th>
				<th>date</th>
				<th>time</th>
			</tr>
			
			<%
			while (result.next()) {
				//make a row
				out.print("<tr>");
				
				out.print("<td>");
				out.print("   " + result.getString("bill_id")+ "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("item") + "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("quantity") + "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("type") + "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("bar") + "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("date") + "   ");
				out.print("</td>");
				
				out.print("<td>");
				out.print("   " + result.getString("time") + "   ");
				out.print("</td>");
				
				out.print("</tr>");
			}
		
			%>
		
		</table>
		<br/>
		<br/>
		
		<%
			x = "select item, sum(quantity) sum from (select bills.bill_id, transactions.item, transactions.quantity, transactions.type, bills.bar, bills.date, bills.time FROM bills INNER JOIN transactions on transactions.bill_id = bills.bill_id and drinker =\"" 
			+ inputDrinker + "\" and type = \"beer\") as t1 group by item";
			result = stmt.executeQuery(x);
			
			ArrayList<Map<String,Integer>> list = new ArrayList();
	   		Map<String,Integer> map = null;
	   		StringBuilder myData=new StringBuilder();
	   		String strData1 ="";
	   	    String chartTitle="";
	   	    String legend="";
	   		
	   		
	   		while (result.next()) { 
	   			map=new HashMap<String,Integer>();
	   			map.put(result.getString("item"),result.getInt("sum"));
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
	 		strData1 = myData.substring(0, myData.length()-1); 
	 		 chartTitle = "Purchased beers by " + inputDrinker;
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
			<br/>
		<br/>
			
			<%
				x = "select bar, truncate(sum(total_price), 2) sum from (select * from bills where drinker =\"" + inputDrinker + "\") as t1 group by bar";
				result = stmt.executeQuery(x);
				
				ArrayList<Map<String,Double>> list2 = new ArrayList();
		   		Map<String,Double> map2 = null;
			   		myData=new StringBuilder();
			   		String strData2 ="";
			   	    chartTitle="";
			   	    legend="";
			   		

			   		while (result.next()) { 
			   			map2=new HashMap<String,Double>();
			   			map2.put(result.getString("bar"),result.getDouble("sum"));
			   			list2.add(map2);
			   	    } 
			   	    result.close();
			   	    
			   	 for(Map<String,Double> hashmap : list2){
			 		Iterator it = hashmap.entrySet().iterator();
			     	while (it.hasNext()) { 
			    		Map.Entry pair = (Map.Entry)it.next();
			    		String key = pair.getKey().toString().replaceAll("'", "");
			    		myData.append("['"+ key +"',"+ pair.getValue() +"],");
			    	}
			 }
			 		strData2 = myData.substring(0, myData.length()-1); 
			 		 chartTitle = "Transactions of " + inputDrinker + " at bars";
			         legend = "$ Total Transactions";
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
			<br/>
		<br/>
			
			<%
				x = "select day, truncate(sum(total_price), 2) sum from (select * from bills where drinker =\"" + inputDrinker + "\") as t1 group by day order by sum desc";
				result = stmt.executeQuery(x);
				
				list2 = new ArrayList();
		   		map2 = null;
			   		myData=new StringBuilder();
			   		String strData3 ="";
			   	    String chartTitle3="";
			   	   String legend3="";
			   		

			   		while (result.next()) { 
			   			map2=new HashMap<String,Double>();
			   			map2.put(result.getString("day").substring(0, result.getString("day").length() - 1),result.getDouble("sum"));
			   			list2.add(map2);
			   	    } 
			   	    result.close();
			   	    
			   	 for(Map<String,Double> hashmap : list2){
			 		Iterator it = hashmap.entrySet().iterator();
			     	while (it.hasNext()) { 
			    		Map.Entry pair = (Map.Entry)it.next();
			    		String key = pair.getKey().toString().replaceAll("'", "");
			    		myData.append("['"+ key +"',"+ pair.getValue() +"],");
			    	}
			 }
			 		strData3 = myData.substring(0, myData.length()-1); 
			 		 chartTitle3 = "Transactions of " + inputDrinker + " for each day";
			         legend3 = "$ Total Transactions";
			%>
			
			<p></p>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data3 = [<%=strData3%>]; 
			var title3 = '<%=chartTitle3%>'; 
			var legend3 = '<%=legend3%>'
			cat3 = [];
			data3.forEach(function(item) {
			  cat3.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			myChart3 = Highcharts.chart('graphthree', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			         
			        }
			    },
			    title: {
			        text: title3
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat3
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend3,
			        data: data3
			    }]
			});
			});
		
		</script>
		
			<div id="graphthree" style="width: 750px; height: 400px; margin: 0 auto"></div>
			
		<%
		 x = "select month(date) month, truncate(sum(total_price), 2) sum from (select * from bills where drinker = \"" + inputDrinker +
		 		"\") as t1 group by month(date) order by sum desc";
		result = stmt.executeQuery(x);
		
		list2 = null;
		list2 = new ArrayList();
   		map2 = null;
	   		myData=new StringBuilder();
	   		String strData4 ="";
	   	    String chartTitle4="";
	   	   String legend4="";
	   		
	   	for (int i = 0; i < 12; i++)
   		{
   			map2 = new HashMap<String, Double>();
   			map2.put("" + (i + 1), 0.0);
   			list2.add(map2);
   		}

	   		int count = 0;
	   		while (result.next()) { 
	   			count = result.getInt("month");
	   			map2=new HashMap<String,Double>();
	   			map2.put(result.getString("month"),result.getDouble("sum"));
	   			list2.set(count- 1, map2);
	   	    } 
	   	    result.close();
	   	    
	   	 for(Map<String,Double> hashmap : list2){
	 		Iterator it = hashmap.entrySet().iterator();
	     	while (it.hasNext()) { 
	    		Map.Entry pair = (Map.Entry)it.next();
	    		String key = pair.getKey().toString().replaceAll("'", "");
	    		myData.append("['"+ key +"',"+ pair.getValue() +"],");
	    	}
	 }
	 		strData4 = myData.substring(0, myData.length()-1); 
	 		 chartTitle4 = "Transactions of " + inputDrinker + " for each month";
	         legend4 = "$ Total Transactions";
		%>
		
		
			<p></p>
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script> 
		
			var data4 = [<%=strData4%>]; 
			var title4 = '<%=chartTitle4%>'; 
			var legend4 = '<%=legend4%>'
			cat4 = [];
			data4.forEach(function(item) {
			  cat4.push(item[0]);
			});
			document.addEventListener('DOMContentLoaded', function () {
			myChart4 = Highcharts.chart('graph4', {
			    chart: {
			        defaultSeriesType: 'column',
			        events: {
			         
			        }
			    },
			    title: {
			        text: title4
			    },
			    xAxis: {
			        text: 'xAxis',
			        categories: cat4
			    },
			    yAxis: {
			        text: 'yAxis'
			    },
			    series: [{
			        name: legend4,
			        data: data4
			    }]
			});
			});
		
		</script>
		
			<div id="graph4" style="width: 750px; height: 400px; margin: 0 auto"></div>
			
		<%}
		con.close();
		%>
</body>
</html>