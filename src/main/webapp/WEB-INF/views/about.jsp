<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About Us | ShareTrade</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<jsp:include page="header.jsp"/>

<!-- Hero Section -->
<section class="about-hero" style="background-image: url('images/about-bg.jpg');">
    <div class="overlay">
        <h1>About ShareTrade</h1>
        <p>Your trusted partner in smart and secure trading.</p>
    </div>
</section>

<!-- About Intro Section -->
<section class="about-section">
    <div class="container" style="flex-direction: column; text-align: center;">
        <h2>Who We Are</h2>
        <p class="intro-text">
            Welcome to <strong>ShareTrade</strong> — the modern platform that empowers traders and investors
            with data-driven insights, fast transactions, and an easy-to-use interface.
            We’re dedicated to making trading simpler, smarter, and more transparent for everyone.
        </p>

        <div class="about-grid">
            <div class="about-card">
                <img src="images/vision.jpg" alt="Our Vision">
                <h3>Our Vision</h3>
                <p>To make trading accessible and rewarding through innovation, education, and trust.</p>
            </div>
            <div class="about-card">
                <img src="images/technology.jpg" alt="Technology">
                <h3>Technology</h3>
                <p>Built on AI-driven analytics, cloud infrastructure, and real-time data systems for reliability.</p>
            </div>
            <div class="about-card">
                <img src="images/community.jpg" alt="Community">
                <h3>Community</h3>
                <p>We believe in shared knowledge and collaboration — helping every trader succeed together.</p>
            </div>
        </div>
    </div>
</section>

<!-- Stats Section -->
<section class="stats-section" style="background-image: url('images/stats-bg.jpg');">
    <div class="overlay">
        <div class="stats-grid">
            <div class="stat">
                <h3>10K+</h3>
                <p>Active Traders</p>
            </div>
            <div class="stat">
                <h3>50+</h3>
                <p>Markets Covered</p>
            </div>
            <div class="stat">
                <h3>99.9%</h3>
                <p>Uptime Reliability</p>
            </div>
            <div class="stat">
                <h3>24/7</h3>
                <p>Support Availability</p>
            </div>
        </div>
    </div>
</section>

<!-- Team Section -->
<section class="team-section">
    <h2 class="section-title">Meet Our Leadership</h2>
    <p class="section-subtitle">The people driving innovation and trust at MyShare</p>

    <div class="team-row">
        <div class="team-member">
            <img src="images/ayush.jpg" alt="CEO">
            <h3>Aayush Solanki</h3>
            <p class="role">Founder & CEO</p>
        </div>
        <div class="team-member">
            <img src="images/team2.jpg" alt="CTO">
            <h3>Kuldeep Choudhary</h3>
            <p class="role">Chief Technology Officer</p>
        </div>
        <div class="team-member">
            <img src="images/team3.jpg" alt="CFO">
            <h3>Muskan</h3>
            <p class="role">Chief Financial Officer</p>
        </div>
        <div class="team-member">
            <img src="images/team4.jpg" alt="CMO">
            <h3>Vaishali Choyal</h3>
            <p class="role">Marketing Head</p>
        </div>
    </div>
</section>

<jsp:include page="footer.jsp"/>
</body>
</html>
