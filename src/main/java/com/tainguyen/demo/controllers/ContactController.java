package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.Contact;
import com.tainguyen.demo.repository.ContactGet;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;

@Controller
public class ContactController extends HttpServlet {
    @Autowired
    ContactGet contactGet;

    @PostMapping("/ContactServlet")
    public String ContactServlet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String name = request.getParameter("name");

        String url = "", error = "";
        if (name.equals("")) {
            error = "Vui lòng nhập Họ và Tên";
            request.setAttribute("error", error);
        }

        try {
            if (error.length() == 0) {
                String message = request.getParameter("message");
                String title = request.getParameter("title");

                contactGet.insertContact(new Contact(new Date().getTime(), name, title, message, new Timestamp(new Date().getTime())));
                url = "/thanksyourcontact";

            } else {
                url = "/contact.jsp";
            }
        } catch (Exception e) {
        }

        return url;

    }

}
