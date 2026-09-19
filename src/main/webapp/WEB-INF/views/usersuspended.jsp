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
  
  .status{
    color: #842029;
    background-color: #f8d7da; /* red */
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
      <li><a href="manageUsers" >Manage Users And Stocks</a></li>
      <li><a href="addStocks">Add Stocks</a></li>
      <li><a href="userspending" >Pending Users</a></li>
      <li><a href="usersuspended" class="active">Suspended Users</a></li>
    </ul>
  </aside>

  <main class="main-content">
    <h1>Manage Users</h1>
    <p class="welcome-text">Search, view, and manage registered users on ShareTrade.</p>

    <!-- <!-- Search
    <div class="search-bar">
      <form method="get" action="manageUsers">
        <input type="text" name="searchQuery" placeholder="Search user by name or email...">
        <button type="submit" class="btn">Search</button>
      </form>
    </div> --> -->

    <%
      List<UserInfo> users = (List<UserInfo>) request.getAttribute("users1");
    %>

    <!-- USERS TABLE -->
    <div class="table-section">
      <h2>All Pending Users</h2>
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
                    <td><span class="status"><%= u.getStatus() %></span></td>
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
  </main>
</section>

<jsp:include page="footer.jsp" />
</body>
</html>
