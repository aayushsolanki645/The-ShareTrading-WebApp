 <%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.univ.pojo.Transactions"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.univ.pojo.UserInfo" %>
<%@ page import="com.univ.daoimpl.DaoImpl" %>

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
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Details | ShareTrade</title>
  <link rel="stylesheet" href="css/details.css">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="header.jsp" />

<%
  Transactions tr = (Transactions) request.getAttribute("transaction");
  String msg = (String) request.getAttribute("msg");
  System.out.println(tr.getTid());
%>

<section class="details-container">
  <div class="details-card">
    <h2>Transaction Details</h2>
    <% if (msg != null) { %>
      <p style="color: green; font-weight: bold;"><%= msg %></p>
    <% } %>

    <!-- Update form -->
    <!-- <form action="updateUser" method="post" class="details-form" enctype="multipart/form-data"> -->
      <input type="hidden" name="uid" value="<%=tr.getTid()%>">

      <div class="form-grid">
        <div class="form-group">
          <label>Transaction ID</label>
          <input type="text" name="fname" value="<%=tr.getTid()%>" readonly="readonly">
        </div>

        <div class="form-group">
          <label>Buyer</label>
          <input type="text" name="lname" value="<%=tr.getUsername()%>" required>
        </div> 
        <div class="form-group">
          <label>Seller</label>
          <input type="email" name="email" value="<%=tr.getSname()%>" readonly="readonly">
        </div>

        <div class="form-group">
          <label>Date & Time</label>
          <input type="tel" name="contact" value="<%=tr.getDateTime()%>" readonly="readonly">
        </div>
        
        <div class="form-group">
          <label>Price/Stock</label>
          <input type="tel" name="contact" value="<%=tr.getPps()%>" readonly="readonly">
        </div>  

        <div class="form-group">
          <label>Quantity</label>
          <input type="tel" name="contact" value="<%=tr.getQuantity()%>" readonly="readonly">
        </div>
        
        <div class="form-group">
          <label>Total</label>
          <input type="tel" name="contact" value="<%=tr.getTotal()%>" readonly="readonly">
        </div>
        
       <%--  <div class="form-group">
          <label>Payment By</label>
          <input type="tel" name="contact" value="<%=tr.getStatus()%>" readonly="readonly">
        </div> --%>
        
        <div class="form-group">
          <label>Status</label>
          <input type="tel" name="contact" value="<%=tr.getCurrTotal()%>" readonly="readonly">
        </div>

        
      </div>

      <div class="button-row">
        <!-- <button type="submit" class="btn">Save Changes</button> -->
        <a href="addMoney" class="btn-secondary">Back</a>
      </div>
    </form>

    <!-- Separate action buttons -->
    <%-- <div class="button-row" style="margin-top: 20px;">
      <!-- Block User -->
      <form action="blockUser" method="post" style="display:inline;">
        <input type="hidden" name="uid" value="<%=user.getUid()%>">
        <button type="submit" class="btn btn-warning" style="background-color:#ff9800;">🚫 Block User</button>
      </form>

      <!-- Delete User -->
      <form action="deleteUser" method="post" style="display:inline;" 
            onsubmit="return confirm('Are you sure you want to delete this user?');">
        <input type="hidden" name="uid" value="<%=user.getUid()%>">
        <button type="submit" class="btn btn-danger" style="background-color:#e53935;">🗑 Delete User</button>
      </form>
    </div> --%>

  </div>
</section>

<script>
function previewImage(event) {
  const reader = new FileReader();
  reader.onload = function(){
      document.getElementById('imagePreview').src = reader.result;
  };
  reader.readAsDataURL(event.target.files[0]);
}
</script>

<jsp:include page="footer.jsp" />
</body>
</html>
