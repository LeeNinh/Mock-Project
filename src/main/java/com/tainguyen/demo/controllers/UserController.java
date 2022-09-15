package com.tainguyen.demo.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    @GetMapping("/products")
    public String products() {
        return "products";
    }

    @GetMapping("/navigate")
    public String navigate() {
        return "navigate";
    }

    @GetMapping("/contact")
    public String contact() {
        return "contact";
    }

    @GetMapping("/single")
    public String single() {
        return "single";
    }

    @GetMapping("/checkout")
    public String checkout() {
        return "checkout";
    }

    @GetMapping("/myaccount")
    public String myAccount() {
        return "myaccount";
    }

    @GetMapping("/billdetail")
    public String billdetail() {
        return "billdetail";
    }

    @GetMapping("/history")
    public String history() {
        return "history";
    }

    @GetMapping("/conduct")
    public String getListConduct() {
        return "news_list";
    }

}
