<footer>
    <p>&copy; 2025 ShareTrade. All rights reserved.</p>
</footer>
<!--Start of Tawk.to Script-->

<%
String user = (String)session.getAttribute("username");
String type = (String)session.getAttribute("usertype");

if(user != null && type.equalsIgnoreCase("trader")){
%>

<script type="text/javascript">
var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();
(function(){
var s1=document.createElement("script"),s0=document.getElementsByTagName("script")[0];
s1.async=true;
s1.src='https://embed.tawk.to/694e2a0777283d197dcb7769/1jdcl8c5h';
s1.charset='UTF-8';
s1.setAttribute('crossorigin','*');
s0.parentNode.insertBefore(s1,s0);
})();
</script>
<%
}
%>
<!--End of Tawk.to Script-->
