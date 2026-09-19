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
  UserInfo user = (UserInfo) request.getAttribute("user");
  String msg = (String) request.getAttribute("msg");
%>

<section class="details-container">
  <div class="details-card">
    <h2>User Details</h2>
    <% if (msg != null) { %>
      <p style="color: green; font-weight: bold;"><%= msg %></p>
    <% } %>

    <!-- Update form -->
    <form action="updateUser" method="post" class="details-form" >
      <input type="hidden" name="uid" value="<%=user.getUid()%>">

      <div class="image-section">
        <img id="imagePreview" src="images/<%=user.getImage()%>" alt="Profile Picture" class="details-img">
        <!-- <label for="dp" class="upload-btn">Change Image</label>
        <input type="file" id="dp" name="dp" accept="image/*" style="display:none;" onchange="previewImage(event)"> -->
      </div>

      <div class="form-grid">
        <div class="form-group">
          <label>First Name</label>
          <input type="text" name="fname" value="<%=user.getFname()%>" required>
        </div>

        <div class="form-group">
          <label>Last Name</label>
          <input type="text" name="lname" value="<%=user.getLname()%>" required>
        </div>

        <div class="form-group">
          <label>Email</label>
          <input type="email" name="email" value="<%=user.getEmail()%>" readonly>
        </div>

        <div class="form-group">
          <label>Contact</label>
          <input type="tel" name="contact" value="<%=user.getContact()%>" required>
        </div>

        <div class="form-group full">
          <label>Address</label>
          <textarea name="address" rows="3"><%=user.getAddress()%></textarea>
        </div>

        <div class="form-group">
          <label>Role</label>
          <select name="role">
            <option value="Trader" <%="Trader".equals(user.getType()) ? "selected" : ""%>>Trader</option>
            <option value="Admin" <%="Admin".equals(user.getType()) ? "selected" : ""%>>Admin</option>
          </select>
        </div>

        <div class="form-group">
          <label>Status</label>
          <select name="status">
            <option value="Active" <%="Active".equals(user.getStatus()) ? "selected" : ""%>>Active</option>
            <option value="Suspended" <%="Suspended".equals(user.getStatus()) ? "selected" : ""%>>Suspended</option>
            <option value="Pending" <%="Pending".equals(user.getStatus()) ? "selected" : ""%>>Pending</option>
          </select>
        </div>
      </div>

      <div class="button-row">
        <button type="submit" class="btn">Save Changes</button>
        <a href="manageUsers" class="btn-secondary">Back</a>
      </div>
    </form>

    <!-- < !-- Separate action buttons --> -->
    <div class="button-row" style="margin-top: 20px;">
      <!-- Block User -->
      <%-- <form action="blockUser" method="post" style="display:inline;">
        <input type="hidden" name="uid" value="<%=user.getUid()%>">
        <button type="submit" class="btn btn-warning" style="background-color:#ff9800;">🚫 Block User</button>
      </form>  --%>

      <!-- Delete User -->
      <form action="deleteUser" method="post" style="display:inline;" 
            onsubmit="return confirm('Are you sure you want to delete this user?');">
        <input type="hidden" name="uid" value="<%=user.getUid()%>">
        <button type="submit" class="btn btn-danger" style="background-color:#e53935;">🗑 Delete User</button>
      </form>
    </div>

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
