package com.univ.controller;

import java.util.Random;

import org.springframework.stereotype.Component;

@Component
public class OtpGeneretor {
	public static String OTPGenerator() {
		final int length=6;
		String number="0123456789";
		Random rand=new Random();
		StringBuilder otp=new StringBuilder();
		for(int i=0;i<length;i++) {
			otp.append(number.charAt(rand.nextInt(number.length())));
			System.out.println(" - "+number.charAt(rand.nextInt(number.length())));
		}
		return otp.toString();
	}
}