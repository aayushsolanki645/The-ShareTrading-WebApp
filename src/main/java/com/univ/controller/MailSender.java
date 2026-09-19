package com.univ.controller;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;


import org.springframework.stereotype.Service;

import com.univ.pojo.StockInfo;

@Service("otpMailService")
public class MailSender {
		public  void sendOtp(String toEmail, HttpSession session ) {
			
			OtpGeneretor otpg = new OtpGeneretor();
		    String otp = otpg.OTPGenerator();

		    session.setAttribute("otp", otp);   // 🔐 store OTP
		    session.setAttribute("otpTime", System.currentTimeMillis());
			
			//String user=(String)session1.getAttribute("cName");
			final String fromEmail="solankiayush645@gmail.com";
			final String password="osdvgnvefnfnkbdj";
			
			Properties props=new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			
			Session session1=Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, password);
				}
			});
			
			try {
				Message message=new MimeMessage(session1);
				message.setFrom(new InternetAddress(fromEmail));
				
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
				
				
				message.setSubject("OTP for Verification");
				String msg = "<p>Hi <strong>"+ toEmail +"</strong>,</p>"
				        + "<p>We received a request to verify your identity. Please use the following One-Time Password (OTP) to complete your Registration</p>"
				        + "<h2 style='color:blue;'>" +
				        otp
				        + "<p>This OTP is valid for 5 minutes. <b>Do not share this code</b> with anyone for security reasons.</p>"
				        + "<p>If you did not initiate this request, please ignore this email or contact our support immediately.</p>"
				        + "<br><p>Thank you for choosing <strong>Your Company Name</strong>!</p>"
				        + "<p>Stay secure,<br>The ShareTrading Team</p>";

				message.setContent(msg, "text/html");
				Transport.send(message);
				
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
		
		
	public  void sendRegMail(String toEmail) {
			
			
			//String user=(String)session1.getAttribute("cName");
			final String fromEmail="solankiayush645@gmail.com";
			final String password="osdvgnvefnfnkbdj";
			
			Properties props=new Properties();
			props.put("mail.smtp.host", "smtp.gmail.com");
			props.put("mail.smtp.port", "587");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.starttls.enable", "true");
			
			Session session1=Session.getInstance(props, new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(fromEmail, password);
				}
			});
			
			try {
				Message message=new MimeMessage(session1);
				message.setFrom(new InternetAddress(fromEmail));
				
				message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
				
				
				message.setSubject("Registration Succesfull!");
				String msg = "<p>Hi <strong>"+ toEmail +"</strong>,</p>"
				        + "<p>You are Registered Succesfully.</p>"
				        + "<p>Your Account currently on hold for admin approval, You will be notified</p>"
				        + "<p>once you get approved.</p>"
				        + "<br><p>Thank you for choosing <strong>The ShareTrading App</strong>!</p>"
				        + "<p>Stay secure,<br>The ShareTrading Team</p>";

				message.setContent(msg, "text/html");
				Transport.send(message);
				
			} catch (Exception e) {
				throw new RuntimeException(e);
			}
		}
	
	public  void sendConfirmationMail(String toEmail ) {
		
		
		//String user=(String)session1.getAttribute("cName");
		final String fromEmail="solankiayush645@gmail.com";
		final String password="osdvgnvefnfnkbdj";
		
		Properties props=new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		
		Session session1=Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});
		
		try {
			Message message=new MimeMessage(session1);
			message.setFrom(new InternetAddress(fromEmail));
			
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			
			
			message.setSubject("Status Update");
			String msg = "<p>Hi <strong>"+ toEmail +"</strong>,</p>"
			        + "<p>Youre Status has been Updated. </p>"
			        + "<br><p>Thank you for choosing <strong>The ShareTrading App</strong>!</p>"
			        + "<p>Stay secure,<br>The ShareTrading Team</p>";

			message.setContent(msg, "text/html");
			Transport.send(message);
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
public  void sendPurchaseMail(String toEmail,StockInfo st ) {
		
		
		//String user=(String)session1.getAttribute("cName");
		final String fromEmail="solankiayush645@gmail.com";
		final String password="osdvgnvefnfnkbdj";
		
		Properties props=new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		
		Session session1=Session.getInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(fromEmail, password);
			}
		});
		
		try {
			Message message=new MimeMessage(session1);
			message.setFrom(new InternetAddress(fromEmail));
			
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
			
			
			message.setSubject("Purchase Done");
			String msg = "<p>Hi <strong>"+ toEmail +"</strong>,</p>"
			        + "<p>Congratulations on your purchase. </p>"
			        + "<br><p>Purchase Details:</p>"
			        + "<p>Stock Name:</p>"+st.getSname()
					+ "<p>Stock Price:</p>"+st.getRate();

			message.setContent(msg, "text/html");
			Transport.send(message);
			
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
public  void sendSellMail(String toEmail,StockInfo st ) {
	
	
	//String user=(String)session1.getAttribute("cName");
	final String fromEmail="solankiayush645@gmail.com";
	final String password="osdvgnvefnfnkbdj";
	
	Properties props=new Properties();
	props.put("mail.smtp.host", "smtp.gmail.com");
	props.put("mail.smtp.port", "587");
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.starttls.enable", "true");
	
	Session session1=Session.getInstance(props, new Authenticator() {
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(fromEmail, password);
		}
	});
	
	try {
		Message message=new MimeMessage(session1);
		message.setFrom(new InternetAddress(fromEmail));
		
		message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
		
		
		message.setSubject("Sell Done");
		String msg = "<p>Hi <strong>"+ toEmail +"</strong>,</p>"
		        + "<p>You Have Made a Sell:</p>"
		        + "<br><p>Sell Details:</p>"
		        + "<p>Stock Name:</p>"+st.getSname()
				+ "<p>Stock Price:</p>"+st.getRate();

		message.setContent(msg, "text/html");
		Transport.send(message);
		
	} catch (Exception e) {
		throw new RuntimeException(e);
	}
}
	
	}