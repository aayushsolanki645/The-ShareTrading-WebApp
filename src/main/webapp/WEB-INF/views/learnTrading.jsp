<%@page import="com.univ.pojo.Transactions"%>
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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShareTrade | Wallet</title>
    <link rel="stylesheet" href="css/style.css">
    
    <style type="text/css">
    
    tr:hover {
      background-color: #f1f5ff;
      cursor: pointer;
    }
    .table-container {
      max-height: 270px; /* ~5 rows visible */
      overflow-y: auto;
      border: 1px solid #ddd;
      border-radius: 8px;
      margin-bottom: 40px;
    }
    
    </style>
    
    
</head>


<body>

<jsp:include page="header.jsp" />
<br>
 <!-- style="width: 100%; display: flex; padding: 20px;" -->
<section class="dashboard" >

	<aside class="sidebar">
        <h2>Dashboard</h2>
        <ul>
            <li><a href="userHome" >Your Portfolio</a></li>
            <li><a href="marcketWatch">Market Watch</a></li>
            <li><a href="transactions" >Transactions</a></li>
            <li><a href="addMoney" >Add / Withdraw Balance</a></li>
            <li><a href="learnTrading" class="active">Learn Trading..</a></li>
            
        </ul>
    </aside>

    <main style="width: 100%; max-width: 600px; margin-left: 250px;">
	<br>
	<iframe
    width="640"
    height="360"
    src="https://www.youtube.com/embed/rs_iHi5UhZI"
    allowfullscreen>
	</iframe>

	<br><br>
	<iframe
    width="640"
    height="360"
    src="https://www.youtube.com/embed/3WI9RZODuag?list=PLxNHpNhDaEFJsuzKNrMbr_SESDCCLmSu4"
    allowfullscreen>
</iframe>

	
    </main>
</section>


<jsp:include page="footer.jsp" />

<!-- TAB SWITCH SCRIPT -->
<script>

</script>

</body>
</html>
