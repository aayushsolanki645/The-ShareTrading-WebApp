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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>

<jsp:include page="header.jsp" />
<br>

<section class="dashboard">
    <aside class="sidebar">
        <h2>Dashboard</h2>
        <ul>
            <li><a href="dash">Your Portfolio</a></li>
            <li><a href="marcketWatch">Market Watch</a></li>
            <li><a href="#">All Transactions</a></li>
            <li><a href="#">Settings</a></li>
            <li><a href="index.jsp">Logout</a></li>
        </ul>
    </aside>

    <main class="main-content">
        <h1>Welcome, <%= request.getParameter("username") != null ? request.getParameter("username") : "Trader" %> 👋</h1>
        <p class="welcome-text">Here’s an overview of your portfolio and stock market performance.</p>

        <!-- Stats Cards -->
        <div class="cards">
            <div class="card">
                <h3>Total Balance</h3>
                <p class="value">$45,230</p>
                <span class="status up">+2.3%</span>
            </div>
            <div class="card">
                <h3>Today's Profit</h3>
                <p class="value">$1,240</p>
                <span class="status up">+5.6%</span>
            </div>
            <div class="card">
                <h3>Active Trades</h3>
                <p class="value">8</p>
                <span class="status neutral">Stable</span>
            </div>
            <div class="card">
                <h3>Pending Orders</h3>
                <p class="value">3</p>
                <span class="status down">-1.2%</span>
            </div>
        </div>

        <!-- Chart Section -->
        <div class="chart-section">
            <h2>Company Performance</h2>
            <label for="companySelect">Select Company:</label>
            <select id="companySelect">
                <option value="TSLA">Tesla (TSLA)</option>
                <option value="AAPL">Apple (AAPL)</option>
                <option value="GOOGL">Google (GOOGL)</option>
                <option value="AMZN">Amazon (AMZN)</option>
            </select>

            <div class="charts">
                <div class="chart-container">
                    <h3>Last Month</h3>
                    <canvas id="monthlyChart"></canvas>
                </div>
                <div class="chart-container">
                    <h3>Last Year</h3>
                    <canvas id="yearlyChart"></canvas>
                </div>
            </div>
        </div>

        <!-- Transaction Table -->
        <div class="table-section">
            <h2>Your Purchased Shares</h2>
            <table class="transaction-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Stock</th>
                        <th>Type</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>2025-11-02</td>
                        <td>TSLA</td>
                        <td>Buy</td>
                        <td>10</td>
                        <td>$220</td>
                        <td><span class="status up">Completed</span></td>
                    </tr>
                    <tr>
                        <td>2025-11-01</td>
                        <td>GOOGL</td>
                        <td>Buy</td>
                        <td>15</td>
                        <td>$120</td>
                        <td><span class="status up">Completed</span></td>
                    </tr>
                    <tr>
                        <td>2025-10-30</td>
                        <td>AMZN</td>
                        <td>Buy</td>
                        <td>8</td>
                        <td>$145</td>
                        <td><span class="status neutral">Pending</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </main>
</section>

<jsp:include page="footer.jsp" />

<!-- Chart Logic -->
<script>
const companyData = {
    TSLA: {
        month: [210, 215, 220, 230, 225, 240, 245],
        year: [180, 200, 210, 220, 230, 250, 270, 290, 280, 300, 310, 320]
    },
    AAPL: {
        month: [170, 172, 175, 178, 180, 185, 190],
        year: [150, 155, 160, 165, 170, 175, 180, 182, 184, 188, 190, 195]
    },
    GOOGL: {
        month: [120, 122, 121, 125, 127, 130, 135],
        year: [100, 105, 110, 115, 120, 125, 130, 132, 134, 136, 140, 142]
    },
    AMZN: {
        month: [140, 142, 145, 150, 152, 155, 160],
        year: [130, 132, 135, 140, 145, 150, 152, 155, 160, 162, 165, 170]
    }
};

const monthLabels = ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6", "Week 7"];
const yearLabels = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

let monthlyChart, yearlyChart;

function renderCharts(company) {
    const ctxMonth = document.getElementById('monthlyChart').getContext('2d');
    const ctxYear = document.getElementById('yearlyChart').getContext('2d');

    if (monthlyChart) monthlyChart.destroy();
    if (yearlyChart) yearlyChart.destroy();

    monthlyChart = new Chart(ctxMonth, {
        type: 'line',
        data: {
            labels: monthLabels,
            datasets: [{
                label: company + " - Last Month",
                data: companyData[company].month,
                borderColor: '#4CAF50',
                backgroundColor: 'rgba(76, 175, 80, 0.1)',
                fill: true,
                tension: 0.3
            }]
        }
    });

    yearlyChart = new Chart(ctxYear, {
        type: 'line',
        data: {
            labels: yearLabels,
            datasets: [{
                label: company + " - Last Year",
                data: companyData[company].year,
                borderColor: '#2196F3',
                backgroundColor: 'rgba(33, 150, 243, 0.1)',
                fill: true,
                tension: 0.3
            }]
        }
    });
}

// Initialize with Tesla
renderCharts('TSLA');

// Update charts when company changes
document.getElementById('companySelect').addEventListener('change', function() {
    renderCharts(this.value);
});
</script>

</body>
</html>
