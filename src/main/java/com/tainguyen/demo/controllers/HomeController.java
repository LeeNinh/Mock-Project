package com.tainguyen.demo.controllers;

import com.tainguyen.demo.repository.UtilityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    @Autowired
    UtilityRepo utilityRepo;

    @GetMapping
    public String home() {
        return "redirect:/index";
    }

    @GetMapping("/index")
    public String index() {
        return "index";
    }
}
