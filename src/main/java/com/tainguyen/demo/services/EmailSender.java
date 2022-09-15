package com.tainguyen.demo.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Component
public class EmailSender {

    @Autowired
    private JavaMailSender javaMailSender;

    public void sendEmail(String toEmail, String title, String template) {

        MimeMessage msg = javaMailSender.createMimeMessage();

        // true = multipart message
        MimeMessageHelper helper = null;
        try {
            helper = new MimeMessageHelper(msg, true);
            helper.setTo(toEmail);

            helper.setSubject(title);
            helper.setText(template);

            javaMailSender.send(msg);
        } catch (MessagingException e) {
            e.printStackTrace();
        }


    }
}
