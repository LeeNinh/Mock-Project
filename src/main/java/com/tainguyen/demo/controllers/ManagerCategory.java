package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.Category;
import com.tainguyen.demo.repository.CategoryGet;
import com.tainguyen.demo.repository.UtilityRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.Date;

import static com.tainguyen.demo.controllers.utilities.Utility.*;

@Controller
public class ManagerCategory extends HttpServlet {

    @Autowired
    CategoryGet categoryDAO;

    @Autowired
    UtilityRepo utilityRepo;

    @GetMapping("/delete_category")
    protected String deleteCate(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String category_id = request.getParameter("category_id");

        String url = "";
        try {
            categoryDAO.deleteCategory(Long.parseLong(category_id));
            url = "/admin/manager_category";

        } catch (Exception e) {
        }
        return url;
    }

    @PostMapping("/create_category")
    public String insertCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String tenDanhMuc = request.getParameter("tenDanhMuc");
        String categoryImage = request.getParameter("image");

        String url = "", error = "";
        if (tenDanhMuc.equals("")) {
            error = "Vui lòng nhập tên danh mục!";
            request.setAttribute("error", error);
        }

        try {
            if (error.length() == 0) {
                categoryDAO.insertCategory(new Category(new Date().getTime(), tenDanhMuc, categoryImage));
                url = "/admin/manager_category";
            } else {
                url = "/admin/insert_category";
            }
        } catch (Exception e) {
        }
        return url;
    }

    @PostMapping("/update_category")
    public String updateCategory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String tenDanhMuc = request.getParameter("tenDanhMuc");
        String categoryImage = request.getParameter("image");

        String url = "", error = "";
        if (tenDanhMuc.equals("")) {
            error = "Vui lòng nhập tên danh mục!";
            request.setAttribute("error", error);
        }

        try {
            if (error.length() == 0) {

                long maDanhMuc = Long.parseLong(request.getParameter("maDanhMuc"));
                categoryDAO.updateCategory(new Category(maDanhMuc, tenDanhMuc, categoryImage));
                url = "/admin/manager_category";

            } else {
                url = "/admin/update_category";
            }
        } catch (Exception e) {
        }
        return url;
    }

}