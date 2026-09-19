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
            <li><a href="addMoney" class="active">Add / Withdraw Balance</a></li>
            
        </ul>
    </aside>

    <main style="width: 100%; max-width: 600px; margin-left: 250px;">
	<br>
        <!-- WALLET TOP BOX -->
        <div style="
            background: #ffffff; 
            padding: 25px; 
            border-radius: 12px; 
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            text-align: center;
            margin-bottom: 25px;">
            <%
            double s = (double)session.getAttribute("cuuTotal");
            %>
            <h2 style="margin: 0; font-size: 24px;">Your Wallet Balance</h2>
            <h1 style="margin: 10px 0; font-size: 36px; color: #007bff;">₹<%= s %></h1>
        </div>

        <!-- TAB SWITCH -->
        <div style="
            display: flex; 
            justify-content: center; 
            margin-bottom: 20px;">

            <button id="tabDeposit" onclick="showDeposit()"
                style="padding: 10px 20px; border: none; cursor: pointer; 
                background: #007bff; color: white; border-radius: 6px; margin-right: 10px;">
                Deposit
            </button>

            <button id="tabWithdraw" onclick="showWithdraw()"
                style="padding: 10px 20px; border: none; cursor: pointer;
                background: #e0e0e0; border-radius: 6px;">
                Withdraw
            </button>
        </div>
		<%
			String msg = (String)request.getAttribute("msg");
			if(msg != null)
				out.print(msg);
		%>

        <!-- DEPOSIT FORM -->
        <div id="depositBox" style="
            background: #ffffff; padding: 25px; border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1); margin-bottom: 25px;">

            <h3>Deposit Money</h3>

            <form action="addbalance" method="post" style="display: flex; flex-direction: column;">

                <label style="margin-top: 10px;">Amount (INR)</label>
                <input type="number" name="amount" min="1" required
                       placeholder="Enter amount"
                       style="padding: 10px; border-radius: 6px; border: 1px solid #ccc;">

                <label style="margin-top: 15px;">Payment Method</label>
                <select name="s1" style="padding: 10px; border-radius: 6px; border: 1px solid #ccc;">
                    <option value="upi">UPI</option>
                    <option value="card">Credit/Debit Card</option>
                    <option value="netbanking">Net Banking</option>
                </select>

                <button type="submit" name="b1" value="deposit"
                    style="margin-top: 20px; padding: 12px; border: none; 
                    border-radius: 6px; background: #007bff; color: white; cursor: pointer;">
                    Add Money
                </button>

            </form>
        </div>


        <!-- WITHDRAW FORM -->
        <div id="withdrawBox" style="
            background: #ffffff; padding: 25px; border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1); 
            margin-bottom: 25px; display: none;">

            <h3>Withdraw Money</h3>

            <form action="addbalance" method="post" style="display: flex; flex-direction: column;">

                <label style="margin-top: 10px;">Withdraw Amount (INR)</label>
                <input type="number" name="amount" min="1" required
                       placeholder="Enter amount"
                       style="padding: 10px; border-radius: 6px; border: 1px solid #ccc;">
                       
                <label style="margin-top: 15px;">Payment Method</label>
                <select name="s1" style="padding: 10px; border-radius: 6px; border: 1px solid #ccc;">
                    <option value="upi">UPI</option>
                    <option value="netbanking">Net Banking</option>
                </select>

                <!-- <label style="margin-top: 15px;">To Bank Account</label>
                <input type="text" name="bank" placeholder="Enter account number"
                       style="padding: 10px; border-radius: 6px; border: 1px solid #ccc;"> -->

                <button type="submit" name=b1 value="withdraw"
                    style="margin-top: 20px; padding: 12px; border: none; 
                    border-radius: 6px; background: #ff3b30; color: white; cursor: pointer;">
                    Withdraw Money
                </button>

            </form>
        </div>


       </main>
</section>


<jsp:include page="footer.jsp" />

<!-- TAB SWITCH SCRIPT -->
<script>

function openTransactionDetails(tid) {
    window.location.href = 'transactionDetails?id=' + tid;
  }

function showDeposit() {
    document.getElementById('depositBox').style.display = 'block';
    document.getElementById('withdrawBox').style.display = 'none';

    document.getElementById('tabDeposit').style.background = '#007bff';
    document.getElementById('tabDeposit').style.color = 'white';

    document.getElementById('tabWithdraw').style.background = '#e0e0e0';
    document.getElementById('tabWithdraw').style.color = 'black';
}

function showWithdraw() {
    document.getElementById('depositBox').style.display = 'none';
    document.getElementById('withdrawBox').style.display = 'block';

    document.getElementById('tabWithdraw').style.background = '#ff3b30';
    document.getElementById('tabWithdraw').style.color = 'white';

    document.getElementById('tabDeposit').style.background = '#e0e0e0';
    document.getElementById('tabDeposit').style.color = 'black';
}
</script>

</body>
</html>
