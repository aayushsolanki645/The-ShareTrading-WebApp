package com.univ.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import java.util.List;
import java.util.Map;

@Service
public class EmailService {

	 @Value("${brevo.api.key}")
	    private String apiKey;

	    @Value("${mail.from}")
	    private String fromEmail;

    private final RestClient client;

    public EmailService() {
        SimpleClientHttpRequestFactory factory = new SimpleClientHttpRequestFactory();
        factory.setConnectTimeout(5000);
        factory.setReadTimeout(10000);
        this.client = RestClient.builder().requestFactory(factory).build();
    }

    public void sendEmail(String to, String subject, String htmlBody) {
        Map<String, Object> body = Map.of(
            "sender", Map.of("name", "ShareTrade", "email", fromEmail),
            "to", List.of(Map.of("email", to)),
            "subject", subject,
            "htmlContent", htmlBody
        );

        client.post()
              .uri("https://api.brevo.com/v3/smtp/email")
              .header("api-key", apiKey)
              .contentType(MediaType.APPLICATION_JSON)
              .body(body)
              .retrieve()
              .toBodilessEntity();
    }
}