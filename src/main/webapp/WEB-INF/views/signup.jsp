<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%-- <%
String users =(String) session.getAttribute("username");
if(users==null)
{
   response.sendRedirect("index");
}
%> --%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShareTrade | Sign Up</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Optional image upload preview style */
       /* ================================
   PROFILE IMAGE UPLOAD DESIGN
================================== */

.modal {
    display: none;
    position: fixed;
    z-index: 2000;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    background: rgba(0,0,0,0.6);
}

.modal-content {
    background: #fff;
    margin: 15% auto;
    padding: 25px;
    width: 320px;
    border-radius: 10px;
    text-align: center;
}

.modal-content input {
    width: 100%;
    padding: 10px;
    margin-top: 10px;
}

.modal-content button {
    margin-top: 15px;
    padding: 10px 15px;
    background: #0056b3;
    color: #fff;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.close {
    float: right;
    font-size: 22px;
    cursor: pointer;
}


.error-msg {
    color: red;
    font-size: 0.85rem;
    margin-top: 5px;
}

.success-msg {
    color: green;
    font-size: 0.85rem;
    margin-top: 5px;
}

.input-error {
    border: 2px solid red !important;
}

.input-success {
    border: 2px solid green !important;
}



.image-upload {
  margin-bottom: 25px;
}

.image-upload label {
  font-weight: 600;
  color: #003366;
  display: block;
  margin-bottom: 8px;
}

.upload-box {
  display: flex;
  align-items: center;
  gap: 25px;
  flex-wrap: wrap;
}

.image-preview {
  width: 120px;
  height: 120px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid #0056b3;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
  background: #f9fafc;
  transition: transform 0.3s ease;
}

.image-preview:hover {
  transform: scale(1.05);
}

.upload-controls {
  display: flex;
  flex-direction: column;
  align-items: flex-start;
}

.upload-controls input[type="file"] {
  display: none;
}

.upload-btn {
  background-color: #0056b3;
  color: #fff;
  padding: 10px 18px;
  border-radius: 8px;
  cursor: pointer;
  font-weight: 500;
  transition: background 0.3s ease;
}

.upload-btn:hover {
  background-color: #003d80;
}

.note {
  font-size: 0.85rem;
  color: #777;
  margin-top: 8px;
}

    </style>
</head>
<body>

<jsp:include page="header.jsp" />

<section class="signup-section">
    <div class="signup-container">
        <h2>Create Your Account</h2>
        <p class="subtitle">Join ShareTrade and start your investment journey today.</p>

        <!-- Important: enctype added for file uploads -->
        <form action="register" method="post" enctype="multipart/form-data" class="signup-form" >
	
	<%
String msg = (String)request.getAttribute("msg");
if(msg!=null)
	out.print(msg);
%>
	
	
            <!-- Profile image upload -->
<div class="input-group image-upload">
  <label for="profileImage">Profile Picture</label>
  <div class="upload-box">
      <img id="imagePreview" class="image-preview" src="images/default-user.jpg" alt="Profile Preview">
      <div class="upload-controls">
          <input type="file" id="profileImage" name="dp" accept="image/*"  onchange="previewImage(event)">
          <label for="profileImage" class="upload-btn" style="color: white;">Choose Image</label>
      </div>
  </div>
  <!-- ERROR MESSAGE -->
  <p class="error-msg" id="profileImage_error"></p>
  <p class="note">Upload a clear image (JPEG/PNG, max 2MB)</p>
</div>


            <div class="row">
                <div class="input-group">
 			   <label for="firstname">First Name</label>
   			   <input type="text" id="firstname" name="firstname" required oninput="validateFirstName()">
    			<p class="error-msg" id="firstname_error"></p>
				</div>

                <div class="input-group">
    			<label for="lastname">Last Name</label>
    			<input type="text" id="lastname" name="lastname" required oninput="validateLastName()">
    			<p class="error-msg" id="lastname_error"></p>
				</div>
            </div>

            <div class="input-group">
    		<label for="email">Email Address</label>
    		<input type="email" id="email" name="email" onblur="verifyEmail()" required oninput="validateEmail()">
    		<p class="error-msg" id="email_error"></p>
			</div>


            <div class="input-group">
    		<label for="contact">Contact Number</label>
    		<input type="tel" id="contact" name="contact" required 
           maxlength="10"
           oninput="validateContact()">
    		<p class="error-msg" id="contact_error"></p>
			</div>


            <div class="input-group">
    		<label for="address">Address</label>
    		<textarea id="address" name="address" rows="3" required oninput="validateAddress()"></textarea>
    		<p class="error-msg" id="address_error"></p>
			</div>


           <div class="input-group">
    		<label for="password">Password</label>
    		<input type="password" id="password" name="password" required oninput="validatePassword()">
    		<p class="error-msg" id="password_error"></p>
			</div>

                

            <div class="input-group checkbox">
                <input type="checkbox" id="agree" name="agree" required>
                <label for="agree">I agree to the <a href="#">Terms & Conditions</a></label>
            </div>

            <button type="button" class="btn" onclick="openOtpPopup()" >Register</button>

            <p class="signup-text">Already have an account? <a href="index">Login here</a></p>
        </form>
    </div>
</section>

<jsp:include page="footer.jsp" />

<!-- OTP MODAL -->
<div id="otpModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeOtpPopup()">&times;</span>

        <h3>OTP Verification</h3>
        <p>An OTP has been sent to your email</p>

        <input type="text" id="otpInput" placeholder="Enter 6-digit OTP" maxlength="6">
        <p class="error-msg" id="otp_error"></p>

        <button onclick="verifyOtp()">Verify OTP</button>
    </div>
</div>



<!-- Optional JS preview -->
<script>

let validations = {
    firstname: false,
    lastname: false,
    email: false,
    contact: false,
    address: false,
    password: false
};

function updateSubmitButton() {
    const allValid = Object.values(validations).every(v => v === true);
    document.querySelector(".btn").disabled = !allValid;
}

function setValidation(inputId, messageId, valid, message="") {
    let input = document.getElementById(inputId);
    let msg = document.getElementById(messageId);

    if (valid) {
        input.classList.add("input-success");
        input.classList.remove("input-error");
        msg.innerHTML = "";
    } else {
        input.classList.add("input-error");
        input.classList.remove("input-success");
        msg.innerHTML = message;
    }

    validations[inputId] = valid;
    updateSubmitButton();
}

/* ---------------- VALIDATION FUNCTIONS ---------------- */

function validateFirstName() {
    let v = document.getElementById("firstname").value.trim();
    let valid = /^[A-Za-z]{2,20}$/.test(v);
    setValidation("firstname", "firstname_error", valid, "Enter a valid first name (letters only).");
}

function validateLastName() {
    let v = document.getElementById("lastname").value.trim();
    let valid = /^[A-Za-z]{2,20}$/.test(v);
    setValidation("lastname", "lastname_error", valid, "Enter a valid last name (letters only).");
}

function validateEmail() {
    let v = document.getElementById("email").value;
    let valid = /^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(v);
    setValidation("email", "email_error", valid, "Enter a valid email.");
}

function validateContact() {
    let v = document.getElementById("contact").value;
    let valid = /^[0-9]{10}$/.test(v);
    setValidation("contact", "contact_error", valid, "Enter a 10-digit mobile number.");
}

function validateAddress() {
    let v = document.getElementById("address").value.trim();
    let valid = v.length >= 5;
    setValidation("address", "address_error", valid, "Address must be at least 5 characters.");
}

function validatePassword() {
    let pass = document.getElementById("password").value;

    let pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

    let valid = pattern.test(pass);

    setValidation("password", "password_error", valid,
        "Password must contain 8+ chars, uppercase, lowercase, number & special char."
    );
}

function previewImage(event) {
  const reader = new FileReader();
  reader.onload = function(){
      const output = document.getElementById('imagePreview');
      output.src = reader.result;
  };
  reader.readAsDataURL(event.target.files[0]);
}

window.onload = () => {
    document.querySelector(".btn").disabled = false; // allow first submission
};

let generatedOtp = null;

function openOtpPopup() {
	
	runAllValidations();
	
    let email = document.getElementById("email").value;

    if (email === "") {
        alert("Enter email first");
        return;
    }

    fetch("sendOtpFromJs", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "email=" + encodeURIComponent(email)
    })
    .then(response => response.text())
    .then(data => {
        if (data === "OTP_SENT") {
            document.getElementById("otpModal").style.display = "block";
        } else {
            alert("Failed to send OTP");
        }
    })
    .catch(err => console.error(err));
}


function closeOtpPopup() {
    document.getElementById("otpModal").style.display = "none";
}

function verifyOtp() {
    let otp = document.getElementById("otpInput").value;

    fetch("verifyOtpFromJs", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "otp=" + otp
    })
    .then(res => res.text())
    .then(result => {
        if (result === "SUCCESS") {
            document.querySelector(".signup-form").submit();
        } else {
            document.getElementById("otp_error").innerText = "Invalid OTP";
        }
    });
}

function verifyEmail() {

    let email = document.getElementById("email").value;
    let error = document.getElementById("email_error");

    if (email.trim() === "") {
        error.innerText = "Email is required";
        return;
    }

    fetch("verifyEmail", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "email=" + encodeURIComponent(email)
    })
    .then(res => res.text())
    .then(result => {
        if (result === "EXISTS") {
            error.innerText = "Email already registered";
        } else if (result === "AVAILABLE") {
            error.innerText = "";
        }
    })
    .catch(err => console.error(err));
}


function runAllValidations() {
    validateFirstName();
    validateLastName();
    validateEmail();
    validateContact();
    validateAddress();
    validatePassword();
    validateProfileImage();
}

function validateProfileImage() {
    const fileInput = document.getElementById("profileImage");
    const error = document.getElementById("profileImage_error");
    const section = document.getElementById("imageSection");

    if (!fileInput.files || fileInput.files.length === 0) {
        error.innerText = "Please select a profile picture.";

        // 👇 scroll to image section
        section.scrollIntoView({ behavior: "smooth", block: "center" });

        // 👇 focus file input
        fileInput.focus();

        return false;
    }

    error.innerText = "";
    return true;
}



function clearImageError() {
    document.getElementById("profileImage_error").innerText = "";
}


</script>


</body>
</html>
