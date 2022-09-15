package com.tainguyen.demo;

import com.tainguyen.demo.model.User;
import com.tainguyen.demo.services.MailService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class DuonglienorderApplicationTests {

    @Autowired
    private MailService mailService;

    @Test
    void contextLoads() {
    }

//    @Test
//    void testSendMail() {
//        User user = new User();
//        user.setUserEmail("hungnd.iist@gmail.com");
//        user.setUserID(123122);
//        mailService.sendActivateEmail("hungnd.iist@gmail.com", user);
//    }

}
