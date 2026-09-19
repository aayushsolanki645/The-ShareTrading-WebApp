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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShareTrade | Dashboard</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>


<br>
<section class="dashboard">
    

    <main class="main-content">
        <h1>HELLO, <%= request.getParameter("username") != null ? request.getParameter("username") : "Trader" %> 👋</h1>
        

        <div class="table-section" style="text-align: center">
          	<br>
          	<br>
        	<h1 class="welcome-text">Your Account is currently Pending or Suspended.</h1>
        	<br>  
        	<a href="index">Back to LogIn Page..</a>
        </div>
    </main>
</section>

<jsp:include page="footer.jsp" />

</body>
</html>
