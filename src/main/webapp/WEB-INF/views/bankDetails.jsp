<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
String user = (String) session.getAttribute("username");
if (user == null) {
    response.sendRedirect("index");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>ShareTrade | Add Bank Account</title>
<link rel="stylesheet" href="css/style.css">

<style>
/* ===== CENTER LAYOUT ===== */
.center-wrapper {
    min-height: 80vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

.center-card {
    width: 100%;
    max-width: 500px;
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 8px 25px rgba(0,0,0,0.1);
    text-align: center;
}

.center-card h1 {
    margin-bottom: 10px;
}

.center-card .welcome-text {
    margin-bottom: 25px;
    color: #555;
}

/* ===== FORM ===== */
.input-group {
    text-align: left;
    margin-bottom: 15px;
}

.input-group label {
    font-weight: 600;
    display: block;
    margin-bottom: 6px;
}

.input-group input {
    width: 100%;
    padding: 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
}

/* ===== ERRORS ===== */
.error-msg {
    color: red;
    font-size: 0.85rem;
    margin-top: 4px;
}

/* ===== BUTTONS ===== */
.btn-group {
    display: flex;
    justify-content: center;
    gap: 15px;
    margin-top: 20px;
}

.btn {
    background-color: #0056b3;
    color: white;
    padding: 10px 22px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.btn:hover {
    background-color: #003d80;
}
</style>
</head>

<body>

<jsp:include page="header.jsp" />
<br>
<div class="center-wrapper">

    <div class="center-card">

        <h1>Add Bank Account</h1>
        <p class="welcome-text">Add your bank details securely.</p>

        <form action="addBankAccount" method="post" onsubmit="return validateForm();">

            <div class="input-group">
                <label>Bank Name</label>
                <input type="text" name="bankName" id="bankName">
                <p class="error-msg" id="bank_error"></p>
            </div>

            <div class="input-group">
                <label>Account Holder Name</label>
                <input type="text" name="holder" id="holder">
                <p class="error-msg" id="holder_error"></p>
            </div>

            <div class="input-group">
                <label>Account Number</label>
                <input type="text" name="accountNo" id="accountNo">
                <p class="error-msg" id="account_error"></p>
            </div>

            <div class="input-group">
                <label>IFSC Code</label>
                <input type="text" name="ifsc" id="ifsc">
                <p class="error-msg" id="ifsc_error"></p>
            </div>

            <div class="input-group">
                <label>Branch Name</label>
                <input type="text" name="branch" id="branch">
                <p class="error-msg" id="branch_error"></p>
            </div>

            <div class="btn-group">
                <button type="submit" class="btn">Add Account</button>
				<a class="btn" href="userHome" style="text-decoration: none;" >Back</a>
            </div>

        </form>
    </div>
</div>

<jsp:include page="footer.jsp" />

<script>
function validateForm() {
    let valid = true;

    let bank = document.getElementById("bankName").value.trim();
    let holder = document.getElementById("holder").value.trim();
    let account = document.getElementById("accountNo").value.trim();
    let ifsc = document.getElementById("ifsc").value.trim();
    let branch = document.getElementById("branch").value.trim();

    document.querySelectorAll(".error-msg").forEach(e => e.innerText = "");

    if (bank.length < 3) {
        document.getElementById("bank_error").innerText = "Enter valid bank name";
        valid = false;
    }

    if (holder.length < 3) {
        document.getElementById("holder_error").innerText = "Enter account holder name";
        valid = false;
    }

    if (!/^[0-9]{9,18}$/.test(account)) {
        document.getElementById("account_error").innerText = "Account number must be 9–18 digits";
        valid = false;
    }

    if (!/^[A-Z]{4}0[A-Z0-9]{6}$/.test(ifsc)) {
        document.getElementById("ifsc_error").innerText = "Invalid IFSC code (ex: SBIN0001234)";
        valid = false;
    }

    if (branch.length < 3) {
        document.getElementById("branch_error").innerText = "Enter branch name";
        valid = false;
    }

    return valid;
}
</script>

</body>
</html>
