<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShareTrade | Home</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<jsp:include page="header.jsp" />

<section class="hero">
    <div class="hero-content">
        <h1>Welcome to <span>ShareTrade</span></h1>
        <p>Your trusted platform for smart and secure stock trading.</p>
    </div>

    <div class="login-box">
    	<%
		String msg = (String)request.getAttribute("msg");
        		if(msg != null)
        			out.print(msg);
		%>
        <h2>Login</h2>
        <form action="checkUser" method="post">
            <div class="input-group">
                <label for="username">E-Mail</label>
                <input type="text" id="username" name="username" required>
            </div>
            <div class="input-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>
            <button type="submit" class="btn">Login</button>
        </form>
        <p class="signup-text">New here? <a href="signup">Create an account</a></p>
    </div>
</section>

<jsp:include page="footer.jsp" />

</body>
</html>
