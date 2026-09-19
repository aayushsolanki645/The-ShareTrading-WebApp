<%@page import="com.univ.pojo.Cart"%>
<%-- <%@page import="org.hibernate.internal.build.AllowSysOut"%> --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.univ.pojo.StockInfo" %>
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
  <title>Stock Details | ShareTrade</title>
  <link rel="stylesheet" href="css/details.css">
  <link rel="stylesheet" href="css/style.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style type="text/css">
  .cp{
  	margin: 50px;
  }
  .cv{
  
  padding: 50px 20px;
  background: #f8faff;
  }
  
  </style>
</head>
<body>

<jsp:include page="header.jsp" />

<%
StockInfo stock = (StockInfo) request.getAttribute("stock");
%>

<section class="details-container">
  <div class="details-card">
    <h2>Stock Details</h2>
    <%
    	String msg = (String)request.getAttribute("msg");
    	if(msg!=null)
    	out.print(msg);
    	Cart t = (Cart)session.getAttribute("cartstatus");
    	String cts;
    	if(t != null){
    		cts = t.getStatus();
    	}else{cts="hi";}
    	String type1 = (String)session.getAttribute("usertype");
    	String mar = "hi";
    	mar = (String)session.getAttribute("mar");
    	System.out.println(mar+"asdhg");
		boolean flag = "marcket".equalsIgnoreCase(mar);
    	%>
    <form action="updateStock" method="post" class="details-form" ">
      <input type="hidden" name="sid" value="<%=stock.getSid()%>">
	
		<div class="image-section">
        <img id="imagePreview" src="images/<%=stock.getDp()%>" alt="Profile Picture" class="details-img">
        <%-- 
    <%
	String type = (String)session.getAttribute("type");
	if("Admin".equals(type)){
	%>
        <label for="dp" class="upload-btn">Change Image</label>
        <% } %>
        <input type="file" id="dp" name="dp" accept="images/**" style="display:none;"  onchange="previewImage(event)"> --%>
      </div>
	
      <div class="form-grid">
        <div class="form-group">
          <label>Stock Name</label>
          <input id="sec" type="text" name="sname" value="<%=stock.getSname()%>" required
          <% if(flag){ %> readonly <% } %>	>
        </div>

        <div class="form-group">
          <label>Current Rate</label>
          <input id="sec" type="number" step="0.01" name="rate" value="<%=stock.getRate()%>" required
          <% if(flag){ %> readonly <% } %> >
        </div>

        <div class="form-group">
          <label>Availability</label>
          <input id="sec" type="text" name="availability" value="<%=stock.getAvailability()%>" required
          <% if(flag){ %> readonly <% } %> >
        </div>
        
        <div class="form-group">
          <label>Availabile Quantity</label>
          <input id="sec" type="text" name="quantity" value="<%=stock.getAvailableStocks()%>" required
          readonly >
        </div>
        <% 
	if("Admin".equals(type1)){
	%>
        <div class="form-group">
          <label>Current Liquid</label>
          <input type="text" name="liquid" value="<%=stock.getLiquid()%>" required>
        </div>
		
        <div class="form-group">
          <label>Status</label>
          <select name="status">
            <option value="Active">Active</option>
            <option value="Suspended">Suspended</option>
          </select>
        </div>
        
        <% }
	
	if("Trader".equals(type1) && "marcket".equalsIgnoreCase(mar) == true ){
		
	%>
        <div class="form-group">
        <label for="qty">Quantity:</label>
		<input id="sec" id="qty" type="number" value="1" name="squantity" min="1" max="<%= stock.getAvailableStocks() %>"  step="1">
		</div>
		<% } %>
      </div>
	<%
	if("Admin".equals(type1)){
	%>
      <div class="button-row">
        <button type="submit" class="btn" name="btn" value="update">Update Stock</button>
        
      </div>
      <% }
	else{
		if("Done".equalsIgnoreCase(cts) && "marcket".equalsIgnoreCase(mar) == false){
	%>	
	<div class="form-group">
        <label for="qty">Quantity you have:</label>
		<input id="sec" type="number" name="squantity" value="<%= t.getQuantity() %>" readonly="readonly">
	</div>
	
	<div class="form-group">
        <label for="qty">You Bought At</label>
		<input id="sec" type="number" value="<%= t.getRate() %>" readonly="readonly">
	</div>
	
	<div class="button-row">
        <button type="submit" class="btn" name="btn" value="sell">Sell</button>
        <a href="userHome" class="btn-secondary">Back</a>
      </div>
	<%}
		else{ %>
		<div class="button-row">
        <button type="submit" class="btn" name="btn" value="cart">Buy Now</button>
        <a href="marcketWatch" class="btn-secondary">Back</a>
      </div>
      <% } 
		}%>
    </form>
    <%
	if("Admin".equals(type1)){
	%>
	<br>
	<!-- Delete User -->
   		   <form action="deleteStock" method="post" style="display:inline;" 
            onsubmit="return confirm('Are you sure you want to delete this Stock?');">
       		 <input type="hidden" name="uid" value="<%=stock.getSid()%>">
     	  	 <button type="submit" class="btn btn-danger" style="background-color:#e53935;">🗑 Delete Stock</button>
   		   </form> <br> <br>
        <a href="manageUsers" class="btn-secondary">Back</a>
        <% } %>
  </div>
  <!-- Charts Section -->
        <div class="chart-grid cp">
            <div class="chart-box">
                <h3>Weekly Price Trend</h3>
                <canvas id="priceChart"></canvas>
            </div>
            <div class="chart-box">
                <h3>Daily Trading Volume</h3>
                <canvas id="volumeChart"></canvas>
            </div>
        </div> 
</section>
<!-- <div class="cv">
Company Selector
         <div class="company-select" style="margin-left: 50px;">
            <label for="companySelect">Select Company:</label>
            <select id="companySelect">
                <option value="TSLA">Tesla (TSLA)</option>
                <option value="AAPL">Apple (AAPL)</option>
                <option value="AMZN">Amazon (AMZN)</option>
                <option value="GOOGL">Google (GOOGL)</option>
            </select>
        </div>
</div> -->
<script>



const weeklyData = {
	    TSLA: [220, 230, 225, 240, 245, 250, 255],
	    AAPL: [182, 185, 184, 187, 189, 190, 192],
	    AMZN: [150, 153, 155, 160, 162, 164, 161],
	    GOOGL: [130, 132, 133, 136, 138, 139, 141]
	};

	const volumeData = {
	    TSLA: [1.8, 2.1, 2.0, 2.4, 2.2, 2.3, 2.5],
	    AAPL: [3.0, 3.2, 3.4, 3.8, 3.6, 3.7, 3.9],
	    AMZN: [1.5, 1.7, 1.8, 1.9, 1.7, 1.6, 1.8],
	    GOOGL: [1.2, 1.3, 1.4, 1.5, 1.3, 1.4, 1.5]
	};

	const labels = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
	let priceChart, volumeChart;

	function renderCharts(company) {
	    const ctx1 = document.getElementById('priceChart').getContext('2d');
	    const ctx2 = document.getElementById('volumeChart').getContext('2d');

	    if (priceChart) priceChart.destroy();
	    if (volumeChart) volumeChart.destroy();

	    priceChart = new Chart(ctx1, {
	        type: 'line',
	        data: {
	            labels: labels,
	            datasets: [{
	                label: company + " Weekly Price",
	                data: weeklyData[company],
	                borderColor: '#4CAF50',
	                backgroundColor: 'rgba(76,175,80,0.1)',
	                fill: true,
	                tension: 0.4
	            }]
	        },
	        options: {
	            plugins: { legend: { display: true } },
	            scales: { y: { beginAtZero: false } }
	        }
	    });

	    volumeChart = new Chart(ctx2, {
	        type: 'bar',
	        data: {
	            labels: labels,
	            datasets: [{
	                label: company + " Volume (in millions)",
	                data: volumeData[company],
	                backgroundColor: 'rgba(33,150,243,0.4)',
	                borderColor: '#2196F3',
	                borderWidth: 1
	            }]
	        },
	        options: {
	            scales: { y: { beginAtZero: true } }
	        }
	    });
	}



	// Initialize
	renderCharts('TSLA');

	// Event listener for selector
	document.getElementById('companySelect').addEventListener('change', function() {
	    renderCharts(this.value);
	});

function previewImage(event) {
  const reader = new FileReader();
  reader.onload = function(){
      const output = document.getElementById('imagePreview');
      output.src = reader.result;
  };
  reader.readAsDataURL(event.target.files[0]);
}

</script>

<jsp:include page="footer.jsp" />
</body>
</html>
