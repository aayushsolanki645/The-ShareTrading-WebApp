<%@page import="com.univ.pojo.StockInfo"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
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
    <title>ShareTrade | Market Watch</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style type="text/css">
    .height{
    	
    	min-height: 300px;
    }
    .cc {
      max-height: 650px; 
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
</head>
<body>

<jsp:include page="header.jsp" />
<br>
<section class="dashboard">
    <aside class="sidebar">
        <h2>Dashboard</h2>
        <ul>
            <li><a href="userHome">Your Portfolio</a></li>
            <li><a href="marketwatch.jsp" class="active">Market Watch</a></li>
            <li><a href="transactions">Transactions</a></li>
            <li><a href="addMoney">Add / Withdraw Balance</a></li>
            
        </ul>
    </aside>

    <main class="main-content">
        <h1>📊 Market Watch</h1>
        <p class="welcome-text">Get real-time insights and analytics of top-performing stocks in the market.</p>
<!-- 
        Top Market Overview Cards
        <div class="cards">
            <div class="card highlight">
                <h3>Global Market Index</h3>
                <p class="value">+1.7%</p>
                <span class="status up">Bullish</span>
            </div>
            <div class="card">
                <h3>Top Gainer</h3>
                <p class="value">TSLA +4.2%</p>
                <span class="status up">Tesla Inc.</span>
            </div>
            <div class="card">
                <h3>Top Loser</h3>
                <p class="value">AMZN -2.8%</p>
                <span class="status down">Amazon</span>
            </div>
            <div class="card">
                <h3>Average Volume</h3>
                <p class="value">2.5M</p>
                <span class="status neutral">Stable</span>
            </div>
        </div>

         
        
        <h2>Marcket</h2> <br>
         -->
         <div class="cards cc">
        
        <%	
       		session.setAttribute("mar", "marcket");
        	List<StockInfo> lst = (List<StockInfo>)request.getAttribute("lst");
        	if(lst != null && !lst.isEmpty()){
        		
        	for(StockInfo s:lst){
        %>
        
            <div class="card height">
            	<img class="details-img hw" alt="image" src="images/<%=s.getDp() %>">
                <h3><%= s.getSname() %></h3>
                <p class="value">Current Rate :<%= s.getRate() %></p> 
                <p>OverAll Marcket Cap : </p>
                <p class="value"><%= s.getRate() %></p><br>
                <span class="status up hv" onclick="openStockDetails('<%=s.getSid()%>')">More Details</span>
                <span class="status up"> <a href="stockDetails" style="text-decoration: none"></a></span>
            </div>
            <% }} %>
        </div>

       
    </main>
</section>

<jsp:include page="footer.jsp" />

<!-- Chart Logic -->
<script>

function openStockDetails(sid) {
window.location.href = 'stockDetails?id=' + sid;
}

</script>

</body>
</html>
