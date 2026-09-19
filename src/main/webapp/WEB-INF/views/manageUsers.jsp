<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.univ.pojo.UserInfo" %>
<%@ page import="com.univ.pojo.StockInfo" %>

<%
String users1 =(String) session.getAttribute("username");
if(users1==null)
{
   response.sendRedirect("index");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ShareTrade | Manage Users</title>
  <link rel="stylesheet" href="css/style.css">

  <style>
  	
  	.status {
    padding: 4px 10px;
    border-radius: 4px;
    font-size: 0.70rem;
    font-weight: 500;
}

.status.up {
    color: #0f5132;
    background-color: #d1e7dd; /* green */
}

.status.down {
    color: #842029;
    background-color: #f8d7da; /* red */
}

.status.pending {
    color: #664d03;
    background-color: #fff3cd; /* yellow */
}
  	
  	
    .table-container {
      max-height: 250px; /* ~5 rows visible */
      overflow-y: auto;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin-bottom: 40px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
    }
    th, td {
      padding: 12px;
      text-align: left;
      border-bottom: 1px solid #eee;
    }
    th {
    	position: sticky;
  top: 0;
      background-color: #0056b3;
      color: white;
    }
    tr:hover {
      background-color: #f1f5ff;
      cursor: pointer;
    }
    .btn {
      background-color: #0056b3;
      color: white;
      padding: 6px 14px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
    }
    .btn:hover {
      background-color: #003d80;
    }
  </style>

  <script>
    // Redirect to details page on row click
    function openUserDetails(uid) {
      window.location.href = 'userDetails?id=' + uid;
    }
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
    <h2>Admin Panel</h2>
    <ul>
      <li><a href="home">Dashboard</a></li>
      <li><a href="manageUsers" class="active">Manage Users And Stocks</a></li>
      <li><a href="addStocks">Add Stocks</a></li>
      <li><a href="userspending">Pending Users</a></li>
      <li><a href="usersuspended">Suspended Users</a></li>
    </ul>
  </aside>

  <main class="main-content">
    <h1>Manage Users</h1>
    <p class="welcome-text">Search, view, and manage registered users on ShareTrade.</p>

    <!-- Search -->
    <div class="search-bar">
      <form method="get" action="manageUsers">
        <input type="text" name="searchQuery" placeholder="Search user by UID or Name...">
        <button type="submit" class="btn">Search</button>
      </form>
    </div>

    <%
      List<UserInfo> users = (List<UserInfo>) request.getAttribute("users");
      List<StockInfo> stocks = (List<StockInfo>) request.getAttribute("stocks");
    %>

    <!-- USERS TABLE -->
    <div class="table-section">
      <h2>All Registered Users</h2>
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>User ID</th>
              <th>Full Name</th>
              <th>Email</th>
              <th>Role</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <%
              if (users != null && !users.isEmpty()) {
                for (UserInfo u : users) {
            %>
                  <tr onclick="openUserDetails('<%=u.getUid()%>')">
                    <td><%=u.getUid()%></td>
                    <td><%=u.getFname()%> <%=u.getLname()%></td>
                    <td><%=u.getEmail()%></td>
                    <td>Trader</td>
                    <td>
                    <span class="status 
					<%= 
    				"Active".equalsIgnoreCase(u.getStatus()) ? "up" :
    				"Suspended".equalsIgnoreCase(u.getStatus()) ? "down" :
    				"Pending".equalsIgnoreCase(u.getStatus()) ? "pending" : ""
					%>">
    				<%= u.getStatus() %>
					</span>

                    </td>
                  </tr>
            <%
                }
              } else {
            %>
                <tr><td colspan="5" style="text-align:center;">No users found.</td></tr>
            <%
              }
            %>
          </tbody>
        </table>
      </div>
    </div>
	<br>
    <!-- STOCKS TABLE -->
    <h1>Manage Stocks</h1>
    <p class="welcome-text">Search, view, and manage registered stocks.</p>

    <div class="search-bar">
      <form method="get" action="manageUsers">
        <input type="text" name="stockQuery" placeholder="Search stock by SID or Name...">
        <button type="submit" class="btn">Search</button>
      </form>
    </div>
	<form action="">
    <div class="table-section">
      <h2>All Registered Stocks</h2>
      <div class="table-container">
        <table>
          <thead>
            <tr>
              <th>Stock ID</th>
              <th>Stock Name</th>
              <th>Rate</th>
              <th>Availability</th>
              <th>Available Stocks</th>
              <th>Status</th>
            </tr>
          </thead>
          <tbody>
            <%
              if (stocks != null && !stocks.isEmpty()) {
                for (StockInfo s : stocks) {
                	request.setAttribute("stock", s);
            %>
                  <tr onclick="openStockDetails('<%=s.getSid()%>')">
                    <td><%=s.getSid()%></td>
                    <td><%=s.getSname()%></td>
                    <td><%=s.getRate()%></td>
                    <td><%=s.getAvailability()%></td>
                    <td><%=s.getAvailableStocks()%></td>
                    <td><span class="status up">Active</span></td>
                  </tr>
            <%
                }
              } else {
            %>
                <tr><td colspan="5" style="text-align:center;">No stocks found.</td></tr>
            <%
              }
            %>
            
          </tbody>
        </table>
      </div>
    </div>
	</form>
  </main>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>
