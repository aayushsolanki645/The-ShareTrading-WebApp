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
    ads {
	height: 500px;
    }
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
            <li><a href="transactions" class="active">Transactions</a></li>
            <li><a href="addMoney">Add / Withdraw Balance</a></li>
        </ul>
    </aside>

    <main style="width: 100%; max-width: 900px; margin-left: 60px;">

        <%-- <!-- WALLET TOP BOX -->
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
        </div> --%>
<br> <br> <br>
        <!-- TAB SWITCH -->
        <div style="
            display: flex; 
            justify-content: center; 
            margin-bottom: 20px;">
			
			<button id="tabAll" onclick="showAll()"
                style="padding: 10px 20px; border: none; cursor: pointer; 
                background: #007bff; color: white; border-radius: 6px; margin-right: 10px;">
                All
            </button>
			
            <button id="tabDeposit" onclick="showDeposit()"
                style="padding: 10px 20px; border: none; cursor: pointer; 
                background: #007bff; color: white; border-radius: 6px; margin-right: 10px;">
                Deposit
            </button>

            <button id="tabWithdraw" onclick="showWithdraw()"
                style="padding: 10px 20px; border: none; cursor: pointer;
                background: #e0e0e0; border-radius: 6px; margin-right: 10px;">
                Withdraw
            </button>
            
            <button id="tabBuy" onclick="showBuy()"
                style="padding: 10px 20px; border: none; cursor: pointer;
                background: #e0e0e0; border-radius: 6px; margin-right: 10px;">
                Buy
            </button>
            
            <button id="tabSell" onclick="showSell()"
                style="padding: 10px 20px; border: none; cursor: pointer;
                background: #e0e0e0; border-radius: 6px; margin-right: 10px;">
                Sell
            </button> 
        </div>
		<%
		List<Transactions> with = (List<Transactions>) session.getAttribute("w");
		List<Transactions> depo = (List<Transactions>)session.getAttribute("d");
		List<Transactions> buy = (List<Transactions>) session.getAttribute("b");
		List<Transactions> sell = (List<Transactions>) session.getAttribute("s");
		List<Transactions> lst = (List<Transactions>) session.getAttribute("lst");
		
		if(!lst.isEmpty()){
			%>

	        <!-- All FORM -->

	            <div id="all" class="table-container ads" style="
	            background: #ffffff; padding: 25px; border-radius: 12px; 
	            box-shadow: 0 3px 10px rgba(0,0,0,0.1);  ">
	            <h3 style="margin-bottom: 15px;">Recent Transactions</h3>

	            <table class="transaction-table" style="width: 100%; border-collapse: collapse;">
	                <thead>
	                <tr  style="background: #f1f1f1; color: black;">
	                    <th style="padding: 10px;">Date and Time</th>
	                    <th>Transaction ID</th>
	                    <th>Amount</th>
	                    <th>Via</th>
	                    <th>Type</th>
	                </tr>
	                </thead>

	                <tbody>
	                <%
	               	 	for (Transactions u : lst) {
	               	 		request.setAttribute("transaction", u);
	           		 %>
	                  <tr  onclick="openTransactionDetails('<%=u.getTid()%>')">
	              	    <td><%=u.getDateTime()%></td>
	                    <td><%=u.getTid()%></td>
	                    <td><%=u.getTotal()%></td>
	                    <td><%=u.getVia()%></td>
	                    <td><span class="status up"><%= u.getType() %></span></td>
	                  </tr>
	            <%
	                }
	              } else {
	            %>
	                <tr><td colspan="5" style="text-align:center;">No Transactions found.</td></tr>
	            <%
	              }
	            %>
	        </tbody>
	            </table>
	        </div>
		
		

        <!-- DEPOSIT FORM -->
        
            <div id="with" class="table-container" style="
            background: #ffffff; padding: 25px; border-radius: 12px; 
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);">
            <% 
		if(!with.isEmpty()){
		%>
            <h3 style="margin-bottom: 15px;">Recent Transactions</h3>

            <table class="transaction-table" style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr  style="background: #f1f1f1; color: black;">
                    <th style="padding: 10px;">Date and Time</th>
                    <th>Transaction ID</th>
                    <th>Amount</th>
                    <th>Via</th>
                    <th>Type</th>
                </tr>
                </thead>

                <tbody>
                <%
               	 	for (Transactions u : with) {
               	 		request.setAttribute("transaction", u);
           		 %>
                  <tr  onclick="openTransactionDetails('<%=u.getTid()%>')">
              	    <td><%=u.getDateTime()%></td>
                    <td><%=u.getTid()%></td>
                    <td><%=u.getTotal()%></td>
                    <td><%=u.getVia()%></td>
                    <td><span class="status up"><%= u.getType() %></span></td>
                  </tr>
            <%
                }
              } else {
            %>
                <tr><td colspan="5" style="text-align:center;">No Transactions found.</td></tr>
            <%
              }
            %>
        </tbody>
            </table>
        </div>
        
        
        
        <!-- DEPOSIT FORM -->
        
            <div id="depo" class="table-container" style="
            background: #ffffff; padding: 25px; border-radius: 12px; 
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);">
            <% if(!depo.isEmpty()){ %>
            <h3 style="margin-bottom: 15px;">Recent Transactions</h3>

            <table class="transaction-table" style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr  style="background: #f1f1f1; color: black;">
                    <th style="padding: 10px;">Date and Time</th>
                    <th>Transaction ID</th>
                    <th>Amount</th>
                    <th>Via</th>
                    <th>Type</th>
                </tr>
                </thead>

                <tbody>
                <%
               	 	for (Transactions u : depo) {
               	 		request.setAttribute("transaction", u);
           		 %>
                  <tr  onclick="openTransactionDetails('<%=u.getTid()%>')">
              	    <td><%=u.getDateTime()%></td>
                    <td><%=u.getTid()%></td>
                    <td><%=u.getTotal()%></td>
                    <td><%=u.getVia()%></td>
                    <td><span class="status up"><%= u.getType() %></span></td>
                  </tr>
            <%
                }
              } else {
            %>
                <tr><td colspan="5" style="text-align:center;">No Transactions found.</td></tr>
            <%
              }
            %>
                </tbody>
            </table>
        </div>
	
		

        <!-- Buy FORM -->

            <div id="buy" class="table-container" style="
            background: #ffffff; padding: 25px; border-radius: 12px; 
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);">
            <%
	if (with != null && !with.isEmpty()) {
	%>
            <h3 style="margin-bottom: 15px;">Recent Transactions</h3>

            <table class="transaction-table" style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr  style="background: #f1f1f1; color: black;">
                    <th style="padding: 10px;">Date and Time</th>
                    <th>Transaction ID</th>
                    <th>Amount</th>
                    <th>Via</th>
                    <th>Type</th>
                </tr>
                </thead>

                <tbody>
                <%
             	 	
               	 	for (Transactions u : buy) {
               	 		request.setAttribute("transaction", u);
           		 %>
                  <tr  onclick="openTransactionDetails('<%=u.getTid()%>')">
              	    <td><%=u.getDateTime()%></td>
                    <td><%=u.getTid()%></td>
                    <td><%=u.getTotal()%></td>
                    <td><%=u.getVia()%></td>
                    <td><span class="status up"><%= u.getType() %></span></td>
                  </tr>
            <%
                }
              } else {
            %>
                <tr><td colspan="5" style="text-align:center;">No Transactions found.</td></tr>
            <%
              }
            %>
                </tbody>
            </table>
        </div>
        
        
        <!-- Sell FORM -->

            <div id="sell" class="table-container" style="
            background: #ffffff; padding: 25px; border-radius: 12px; 
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);">
            	<%
					if (sell != null && !sell.isEmpty()) {
				%>
            
            <h3 style="margin-bottom: 15px;">Recent Transactions</h3>

            <table class="transaction-table" style="width: 100%; border-collapse: collapse;">
                <thead>
                <tr  style="background: #f1f1f1; color: black;">
                    <th style="padding: 10px;">Date and Time</th>
                    <th>Transaction ID</th>
                    <th>Amount</th>
                    <th>Via</th>
                    <th>Type</th>
                </tr>
                </thead>

                <tbody>
                <%
             	 	
               	 	for (Transactions u : sell) {
               	 		request.setAttribute("transaction", u);
           		 %>
                  <tr  onclick="openTransactionDetails('<%=u.getTid()%>')">
              	    <td><%=u.getDateTime()%></td>
                    <td><%=u.getTid()%></td>
                    <td><%=u.getTotal()%></td>
                    <td><%=u.getVia()%></td>
                    <td><span class="status up"><%= u.getType() %></span></td>
                  </tr>
            <%
                }
              } else {
            %>
                <tr><td colspan="5" style="text-align:center;">No Transactions found.</td></tr>
            <%
              }
            %>
                </tbody>
            </table>
        </div>
        <% if(lst != null){ %>
			<form action="downloadReport" method="get">
   			<button type="submit" class="btn">Download All Transactions Report</button>
			</form>
		<% } %>
    </main>
</section>


<jsp:include page="footer.jsp" />

<!-- TAB SWITCH SCRIPT -->

<script>
function openTransactionDetails(tid) {
    window.location.href = 'transactionDetails?id=' + tid;
}

function showTab(tabName) {
    const tabs = ["all", "depo", "with", "buy", "sell"];
    const buttons = {
        "all": "tabAll",
        "depo": "tabDeposit",
        "with": "tabWithdraw",
        "buy": "tabBuy",
        "sell": "tabSell"
    };

    // hide all divs
    tabs.forEach(t => {
        document.getElementById(t).style.display = "none";
        document.getElementById(buttons[t]).style.background = "#e0e0e0";
        document.getElementById(buttons[t]).style.color = "black";
    });

    // show selected
    document.getElementById(tabName).style.display = "block";
    document.getElementById(buttons[tabName]).style.background = "#007bff";
    document.getElementById(buttons[tabName]).style.color = "white";
}

// individual button functions
function showAll()     { showTab("all"); }
function showDeposit() { showTab("depo"); }
function showWithdraw(){ showTab("with"); }
function showBuy()     { showTab("buy"); }
function showSell()    { showTab("sell"); }

// load default tab
window.onload = function() { showAll(); };
</script>


</body>
</html>
