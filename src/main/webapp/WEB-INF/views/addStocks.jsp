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
    <title>ShareTrade | Add Stocks</title>
    <link rel="stylesheet" href="css/details.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Optional image upload preview style */
       /* ================================
   PROFILE IMAGE UPLOAD DESIGN
================================== */
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
        <h2>Add Stocks</h2>
        <p class="subtitle">Join ShareTrade and start your investment journey today.</p>

        <!-- Important: enctype added for file uploads -->
        <form action="addStocks" method="post" enctype="multipart/form-data" class="signup-form" >
	
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
          <input  type="file" id="profileImage" name="dp" accept="image/*" required onchange="previewImage(event)">
          <label style="color: white;" for="profileImage" class="upload-btn">Choose Image</label>
      </div>
  </div>
  <p class="note">Upload a clear image (JPEG/PNG, max 2MB)</p>
</div>


            <div class="row">
                <div class="input-group">
                    <label for="firstname">Company Name</label>
                    <input type="text" id="firstname" name="cname" required>
                </div>
                <div class="input-group">
                    <label for="lastname">Rate per Stock</label>
                    <input type="text" id="lastname" name="rate" required>
                </div>
            </div>

            <div class="input-group">
                <label for="email">Availability</label>
                <input type="text" id="email" name="av" required>
            </div>

            <div class="input-group">
                <label for="contact">Available Quantity</label>
                <input type="number" id="contact" name="quant" required pattern="[0-9]{10}" title="Enter a 10-digit phone number">
            </div>


            <button type="submit" class="btn">Add Stock</button> <br> <br>
            <a href="manageUsers" class="btn-secondary">Back</a>

        </form>
    </div>
    
</section>

<jsp:include page="footer.jsp" />

<!-- Optional JS preview -->
<script>
function previewImage(event) {
  const reader = new FileReader();
  reader.onload = function(){
      const output = document.getElementById('imagePreview');
      output.src = reader.result;
  };
  reader.readAsDataURL(event.target.files[0]);
}

</script>

</body>
</html>
