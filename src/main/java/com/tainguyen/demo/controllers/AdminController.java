package com.tainguyen.demo.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @GetMapping(value = {"", "/index"})
    public String HomeAdmin() {
        return "admin/index";
    }

    @GetMapping("/login")
    public String LoginAdmin() {
        return "admin/login";
    }

    @GetMapping("/upload_image")
    public String UploadImage() {
        return "admin/upload_image";
    }

    @GetMapping("/manager_category")
    public String ManagerCategory() {
        return "admin/manager_category";
    }

    @GetMapping("/manager_product")
    public String ManagerProduct() {
        return "admin/manager_product";
    }

    @GetMapping("/manager_bill")
    public String ManagerBill() {
        return "admin/manager_bill";
    }

    @GetMapping("/manager_user")
    public String ManagerUser() {
        return "admin/manager_user";
    }

    @GetMapping("/manager_contact")
    public String ManagerContact() {
        return "admin/manager_contact";
    }

    @GetMapping("/manager_newsletter")
    public String ManagerNewsletter() {
        return "admin/manager_newsletter";
    }

    @GetMapping("/insert_category")
    public String InsertCategory() {
        return "admin/insert_category";
    }

    @GetMapping("/insert_product")
    public String InsertProduct() {
        return "admin/insert_product";
    }

    @GetMapping("/update_category")
    public String UpdateCategory() {
        return "admin/update_category";
    }

    @GetMapping("/update_product")
    public String UpdateProduct() {
        return "admin/update_product";
    }

    @GetMapping("/product_description")
    public String ProductDescription() {
        return "admin/product_description";
    }

    @GetMapping("/manager_chart")
    public String ManagerChart() {
        return "admin/manager_chart";
    }

    @GetMapping("/add_news")
    public String newAdmin() {
        return "admin/add_news";
    }

    @GetMapping("/news_list")
    public String NewsList() {
        return "admin/news_list";
    }
}
