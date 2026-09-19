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

    @PostMapping("/sendOtpFromJs")
    @ResponseBody
    public String sendOtpFromJs(@RequestParam("email") String email,
                                HttpSession session) {

        otpMailService.sendOtp(email, session); // calls your sender
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

