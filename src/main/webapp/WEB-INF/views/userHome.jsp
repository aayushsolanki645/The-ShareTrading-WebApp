<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="com.univ.daoimpl.DaoImpl"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.univ.pojo.Cart"%>
<%@page import="com.univ.pojo.StockInfo"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="java.util.List"%>
<%@page import="com.univ.pojo.Transactions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
response.setHeader("Cache-Control","no-cache , no-store, must-revalidate");
response.setHeader("pragma", "no-cache");
response.setDateHeader("Expires", -1);

String users =(String) session.getAttribute("username");
if(users==null)
{
   response.sendRedirect("index");
}

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShareTrade | Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
    
    <style type="text/css">
    /* */
    tr:hover {
      background-color: #f1f5ff;
      cursor: pointer;
    }
    .table-container {
      max-height: 500px; /* ~5 rows visible */
      overflow-y: auto;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin-bottom: 40px;
    }
    .height{
    	
    	min-height: 300px;
    }
    .cc {
      max-height: 330px; 
      overflow-y: auto;
      /* border: 1px solid #ddd; */
      border-radius: 8px;
      margin-bottom: 10px;
    }
    .hw{
    	margin-left:20px;
    	max-height: 150px;
    	max-width: 150px;
    }
    .hv:hover{
    	cursor: pointer;
    }
    </style>
    <script type="text/javascript">
    	function openStockDetails(sid) {
        window.location.href = 'stockDetails?id=' + sid;
      }
    </script>
</head>
<body>

<jsp:include page="header.jsp" />
<br>
<section class="dashboard">
    <aside class="sidebar">
        <h2>Dashboard</h2>
        <ul>
            <li><a href="userHome" class="active">Your Portfolio</a></li>
            <li><a href="marcketWatch">Market Watch</a></li>
            <li><a href="transactions">Transactions</a></li>
            <li><a href="addMoney">Add / Withdraw Balance</a></li>
            <li><a href="learnTrading">Learn Trading..</a></li>
            <li><a href="logout">Logout</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <h1>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Trader" %> 👋</h1>
        <p class="welcome-text">Here’s an overview of your trading account and the latest market updates.</p>
		<%
		DecimalFormat df = new DecimalFormat("#.##");
		String total = df.format((double)session.getAttribute("total1"));
		double netTotal = (double) session.getAttribute("total1");
		String netColor = netTotal >= 0 ? "green" : "red";
		
		%>
        <div class="cards">
            <div class="card">
                <h3>Total Balance</h3>
                <p class="value">$<%= total %></p>
                <!-- <span class="status up">+2.3%</span> -->
            </div>
            
            <%
			double todayPL = request.getAttribute("todayPL") != null
        	? (double) request.getAttribute("todayPL")
        	: 0;
			String todayColor = todayPL >= 0 ? "green" : "red";
			%>
            
            <div class="card">
   			 	<h3>Today's Profit / Loss</h3>
    			<p class="value" style="color:<%=todayColor%>">
        		₹ <%= df.format(todayPL) %>
    			</p>
			</div>
            <div class="card">
   			 <h3>Overall Profit / Loss</h3>
   			 <p class="value" style="color:<%=netColor%>">
      		  ₹ <%= df.format(todayPL) %>
   			 </p>
			</div>
            <!-- <div class="card">
                <h3>Your Cart</h3>
                <p class="value"><h3>Current Items : 3</h3></p>
                <span class="status up"> <a href="cart" style="text-decoration: none">Open</a></span>
            </div> --> 
        </div>
        <h2>Your Stock's</h2> <br>
        <div class="cards cc">
        
        <%	
        	session.setAttribute("mar", null);
        	List<Cart> lst = (List<Cart>)request.getAttribute("lst");
        	if(lst != null && !lst.isEmpty()){
        		
        	for(Cart s:lst){
        		session.setAttribute("cartstatus", s);
        		double buyRate = s.getRate();    // purchase price
        	    double currentRate = s.getCurrentRate();          // replace with DB price if separate
        	    int qty = s.getQuantity();

        	    double pl = (currentRate - buyRate) * qty;
        	    String plColor = pl >= 0 ? "green" : "red";
        %>
        
            <div class="card height">
            	<img class="details-img hw" alt="image" src="images/<%=s.getDp() %>">
                <h3><%= s.getSname() %></h3>
                <p class="value">Purchase Rate : ₹<%= buyRate %></p>
				<p class="value">Current Rate  : ₹<%= currentRate %></p>

				<p class="value" style="color:<%=plColor%>">
    			Profit / Loss : ₹ <%= df.format(pl) %>
				</p>
                <p>Purchased Quantity: </p>
                <p class="value"><%= s.getQuantity() %></p><br>
                <span class="status up hv" onclick="openStockDetails('<%=s.getSid()%>')">More Details</span>
                <span class="status up"> <a href="stockDetails" style="text-decoration: none"></a></span>
            </div>
            <% }
        	}
        	else{
        		out.print("No Stocks Bought Yet!");
        	}
        	%>
        </div>
	</main>
</section>

<jsp:include page="footer.jsp" />

</body>
</html>
