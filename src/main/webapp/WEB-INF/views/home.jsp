
<%@page import="com.univ.pojo.Transactions"%>
<%@page import="java.util.List"%>
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
    .table-section{
    	max-height: 300px;
    	overflow-y: auto; 
    }
    thead th{
    	position: sticky;
    	top : 0;
    	z-index: 1;
    }
    
    .menu {
    list-style: none;
    padding: 0;
}

.dropdown {
    position: relative;
    width: 200px;
    padding: 10px;
    background: #0056b3;
    color: white;
    cursor: pointer;
}

.dropdown-list {
    list-style: none;
    padding: 0;
    margin: 0;
    position: absolute;
    top: 100%;
    left: 0;
    width: 100%;
    background: white;
    display: none;
    box-shadow: 0 4px 10px rgba(0,0,0,.2);
}

.dropdown-list li {
    padding: 10px;
}

.dropdown-list li a {
    text-decoration: none;
    color: #333;
}

.dropdown:hover .dropdown-list {
    display: block;
}
    .dropdown-list {
    opacity: 0;
    transform: translateY(-10px);
    visibility: hidden;
    transition: 0.3s ease;
}

.dropdown:hover .dropdown-list {
    opacity: 1;
    transform: translateY(0);
    visibility: visible;
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
            <li><a href="#" class="active">Dashboard</a></li>
            <li><a href="manageUsers">Manage Users & Stocks</a></li>
            
            <ul class="menu">
            <li class="dropdown">
     		   Downloads
        		<ul class="dropdown-list">
            	<li><a href="downloadAllStockList">Stock List</a></li>
            	<li><a href="downloadAllUserList">User List</a></li>
        	</ul>
        	</li>
        	</ul>
        	<li><a href="logout">Logout</a></li>
        </ul>
    </aside>
	
	<%
		int stc =(int) request.getAttribute("stc");
		int uc =(int) request.getAttribute("uc");
		int uspd =(int) request.getAttribute("uspd");
	%>
	
    <main class="main-content">
        <h1>Welcome, <%= session.getAttribute("username") != null ? session.getAttribute("username") : "Trader" %> 👋</h1>
        <p class="welcome-text">Here’s the an overview of your trading account and the latest market updates.</p>

        <div class="cards">
            <div class="card">
                <h3>Total Stocks</h3>
                <p class="value"><%= stc %></p>
                <span class="status up">+2.3%</span>
            </div>
            <div class="card">
                <h3>Total Users</h3>
                <p class="value"><%= uc %></p>
                <span class="status up">+5.6%</span>
            </div>
            <div class="card">
                <h3>Pending Users</h3>
                <p class="value"><%= uspd %></p>
                <span class="status neutral"></span>
            </div>
            
        </div>
	<%
		List<Transactions> tlst = (List<Transactions>) request.getAttribute("stlst");
	%>
        <div class="table-section">
            <h2>Recent Stock Buy & Sell</h2>
            <table class="transaction-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Stock</th>
                        <th>Username</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Type</th>
                        <th>Status</th>
                    </tr>
                </thead>
                
                <%
                 for(int i=0;i<tlst.size();i++)
                 {	Transactions t = tlst.get(i);
                %>
                
                <tbody>
                    <tr>
                        <td><%= t.getDateTime() %></td>
                        <td><%= t.getSname() %></td>
                        <td><%= t.getUsername() %></td>
                        <td><%= t.getQuantity() %></td>
                        <td><%= t.getTotal() %></td>
                        <td><%= t.getWd() %></td>
                        <td><span class="status up">Completed</span></td>
                    </tr>
                </tbody>
                <%
                 }
                %>
            </table>
        </div>
    </main>
</section>

<jsp:include page="footer.jsp" />

</body>
</html>
