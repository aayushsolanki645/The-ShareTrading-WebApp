package com.univ.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.univ.pojo.UserInfo;
import com.univ.repo.UserInfoRepo;

import jakarta.servlet.http.HttpSession;

@Controller
public class OtpController {

    @Autowired
    private MailSender otpMailService;
    
    @Autowired
    private UserInfoRepo repo;
    
    @Autowired
    private EmailService emailService;

    @PostMapping("/sendOtpFromJs")
    @ResponseBody
    public String sendOtpFromJs(@RequestParam("email") String email,
                                HttpSession session) {
    	
    	String text = session.toString();
    	
    	String otp = String.valueOf(new java.security.SecureRandom().nextInt(900000) + 100000);

        session.setAttribute("otp", otp);
        session.setAttribute("otpEmail", email);
        session.setAttribute("otpTime", System.currentTimeMillis());
    	
    	emailService.sendEmail(
    		    email, otp,
    		    "Your ShareTrade OTP"
    		   //, "<p>Your OTP is <b>" + otp + "</b>. It is valid for 5 minutes.</p>"
    		);
    	
        //otpMailService.sendOtp(email, session); // calls your sender
        return "OTP_SENT";
    }
    
    @PostMapping("/verifyOtpFromJs")
    @ResponseBody
    public String verifyOtp(@RequestParam("otp") String otp,
                            HttpSession session) {

        String sessionOtp = (String) session.getAttribute("otp");

        if (sessionOtp != null && sessionOtp.equals(otp)) {
            return "SUCCESS";
        }
        return "FAIL";
    }
    
    @PostMapping("/verifyEmail")
    @ResponseBody
    public String verifyMail(@RequestParam("email") String otp,
                            HttpSession session) {

    	UserInfo u = repo.findByEmail(otp);
        if (u == null) {
            return "AVAILABLE";
        }
        return "EXISTS";
    }

}

