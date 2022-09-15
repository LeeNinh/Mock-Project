package com.tainguyen.demo.services;

import com.tainguyen.demo.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    private static final String BASE_URL = "http://localhost:8080";

    private static final String ACTIVATE_URL = "/activate/";

    private final static String ACTIVATE_ACCOUNT_SUBJECT = "ACTIVATE_ACCOUNT_SUBJECT";
    private final static String NOTICE_ORDER = "NOTICE_ORDER";

    @Autowired
    private EmailSender emailSender;


    public void sendActivateEmail (String toEmail, User user) {
        String url = BASE_URL + ACTIVATE_URL + user.getUserID();
        String content = String.format("<!DOCTYPE html>\n" +
                "<html lang=\"en\">\n" +
                "<head>\n" +
                "    <meta charset=\"UTF-8\">\n" +
                "</head>\n" +
                "<body>\n" +
                "\n" +
                "<h1>Account request activate</h1>\n" +
                "<p>Hi boss!</p>\n" +
                "<p>Please click <a href=\"%s\">link</a> to activate account <b>%s</b> /p>\n" +
                "</body>\n" +
                "</html>", url, user.getUserName());

        emailSender.sendEmail(toEmail, ACTIVATE_ACCOUNT_SUBJECT, content);
    }

    public void sendNoticeOrder(String toEmail, String orderId) {
        String url = BASE_URL + ACTIVATE_URL;
        String content = String.format("<!DOCTYPE html>\n" +
                "<html >\n" +
                "<head>\n" +
                "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\n" +
                "</head>\n" +
                "<body>\n" +
                "\n" +
                "</body>\n" +
                "</html>");

        emailSender.sendEmail(toEmail, NOTICE_ORDER, content);

    }
}
