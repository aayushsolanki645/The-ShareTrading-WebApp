<%@ page contentType="text/html;charset=UTF-8" language="java" %>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Contact Us | ShareTrade</title>
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<jsp:include page="header.jsp"/>
<br>
<section class="contact-hero">
    <div class="overlay">
        <h1>Get in Touch</h1>
        <p>We’re here to help you trade smarter and grow faster. Let’s connect.</p>
    </div>
</section>

<section class="contact-main">
    <div class="container contact-grid">
        
        <!-- Left Info Panel -->
        <div class="contact-info">
            <h2>Contact Information</h2>
            <p>Have questions, feedback, or partnership ideas? Reach out to our team — we’ll respond within 24 hours.</p>

            <div class="info-item">
                <i class="fa-solid fa-envelope"></i>
                <div>
                    <h4>Email</h4>
                    <p>support@sharetrade.com</p>
                </div>
            </div>

            <div class="info-item">
                <i class="fa-solid fa-phone"></i>
                <div>
                    <h4>Phone</h4>
                    <p>+1 (800) 555-1234</p>
                </div>
            </div>

            <div class="info-item">
                <i class="fa-solid fa-location-dot"></i>
                <div>
                    <h4>Address</h4>
                    <p>Somewhere on Earth.</p>
                </div>
            </div>

            <div class="info-item">
                <i class="fa-solid fa-clock"></i>
                <div>
                    <h4>Office Hours</h4>
                    <p>Mon–Fri, 9 AM – 6 PM</p>
                </div>
            </div>

            <div class="social-links">
                <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#"><i class="fa-brands fa-x-twitter"></i></a>
                <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
            </div>
        </div>

        <!-- Right Contact Form -->
        <div class="contact-form">
            <h2>Send Us a Message</h2>
            <form action="contactSubmit.jsp" method="post" class="form">
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" name="fullname" required placeholder="John Doe">
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="email" name="email" required placeholder="john@example.com">
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Subject</label>
                        <input type="text" name="subject" required placeholder="Inquiry about ShareTrade features">
                    </div>
                    <div class="form-group">
                        <label>Phone</label>
                        <input type="tel" name="phone" placeholder="+91 9876543210">
                    </div>
                </div>

                <div class="form-group full">
                    <label>Message</label>
                    <textarea name="message" rows="5" required placeholder="Write your message here..."></textarea>
                </div>

                <button type="submit" class="btn"><i class="fa-solid fa-paper-plane"></i> Send Message</button>
            </form>
        </div>

    </div>
</section>

<jsp:include page="footer.jsp"/>
</body>
</html>
