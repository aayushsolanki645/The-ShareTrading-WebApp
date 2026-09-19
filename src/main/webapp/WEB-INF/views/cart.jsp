<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.univ.pojo.Cart" %>

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
    <title>Your Cart | ShareTrade</title>
    <link rel="stylesheet" href="css/style.css">

    <style>
        .cart-wrapper {
            width: 90%;
            margin: 20px auto;
        }

        .cart-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
            gap: 20px;
        }

        .cart-item {
            background: #ffffff;
            border-radius: 14px;
            padding: 20px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
            transition: 0.3s ease;
        }

        .cart-item:hover {
            transform: translateY(-2px);
        }

        .cart-img {
            width: 100%;
            height: 160px;
            border-radius: 12px;
            object-fit: cover;
        }

        .stock-name {
            font-size: 20px;
            font-weight: bold;
            margin-top: 12px;
        }

        .stock-info {
            margin-top: 6px;
            font-size: 15px;
            color: #444;
        }

        .stock-info span {
            font-weight: bold;
            color: #000;
        }

        .actions {
            margin-top: 15px;
            display: flex;
            justify-content: space-between;
        }

        .remove-btn {
            padding: 7px 14px;
            background: #e53935;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .total-summary {
            margin-top: 30px;
            padding: 20px;
            background: #f0f7ff;
            border-left: 5px solid #2196F3;
            font-size: 20px;
            border-radius: 10px;
            font-weight: bold;
        }

        .checkout-btn {
            margin-top: 20px;
            padding: 12px 20px;
            background: #4CAF50;
            color: white;
            border-radius: 10px;
            border: none;
            cursor: pointer;
            float: right;
            font-size: 16px;
        }
    </style>

</head>
<body>

<jsp:include page="header.jsp" />
<br>
<section class="dashboard">

    <!-- Sidebar -->
    <aside class="sidebar">
        <h2>Dashboard</h2>
        <ul>
            <li><a href="userHome">Your Portfolio</a></li>
            <li><a href="marcketWatch">Market Watch</a></li>
            <li><a href="cart" class="active">Cart</a></li>
        </ul>
    </aside>

    <main class="main-content">

        <h1>🛒 Your Cart</h1>
        <p class="welcome-text">Review your selected stocks before checkout.</p>

        <div class="cart-wrapper">

            <%
                List<Cart> list = (List<Cart>) request.getAttribute("cart");
            	
                double grandTotal = 0;
                String msg =(String) request.getAttribute("msg");
                if(msg != null)
                	out.println(msg);
            %>

            <div class="cart-grid">

                <%
                    if (list != null && !list.isEmpty()) {

                        for (Cart c : list) {
                            grandTotal += c.getTotal();
                %>

                <!-- CART ITEM CARD -->
                <div class="cart-item">
                    <img src="images/<%=c.getDp()%>" class="cart-img">

                    <div class="stock-name"><%=c.getSname()%></div>

                    <div class="stock-info">
                        Rate: ₹<span><%=c.getRate()%></span><br>
                        Quantity: <span><%=c.getQuantity()%></span><br>
                        Total: ₹<span><%=c.getTotal()%></span>
                    </div>

                    <div class="actions">
                        <form action="cartAction" method="post">
                            <input type="hidden" name="cid" value="<%= c.getCid() %>">
                            <input type="hidden" name="sid" value="<%= c.getSid() %>">
                            <div class="form-group">
          					<label>Payment Option :</label>
          					<select name="status">
            				<option value="Card">Card</option>
            				<option value="Upi">Bhim UPI</option>
          					</select>
        					</div>
                            <button type="submit" name="btn" value="remove" class="remove-btn">Remove</button>
                            <button type="submit" name="btn" value="buy" class="remove-btn" style="background: green">Buy Now</button>
                        </form>
                    </div>
                </div>

                <% 
                        }
                    } else {
                %>

                <div style="padding: 20px; font-size: 18px;">Your cart is empty.</div>

                <% } %>

            </div>

            <!-- TOTAL SUMMARY -->
            <div class="total-summary">
                Total Amount: ₹ <%=grandTotal%>
            </div>

            <% if (grandTotal > 0) { %>
            <form action="checkout" method="post">
                <button class="checkout-btn">Proceed to Checkout</button>
            </form>
            <% } %>

        </div>

    </main>

</section>

<jsp:include page="footer.jsp" />

</body>
</html>
