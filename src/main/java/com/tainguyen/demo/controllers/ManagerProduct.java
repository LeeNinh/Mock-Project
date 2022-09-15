package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.*;
import com.tainguyen.demo.repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

@Controller
public class ManagerProduct extends HttpServlet {

    @Autowired
    ProductRepo productRepo;

    @Autowired
    UtilityRepo utilityRepo;

    @Autowired
    ProductImageRepo productImageRepo;

    @Autowired
    ProductColorRepo productColorRepo;

    @Autowired
    ProductSizeRepo productSizeRepo;

    @GetMapping("delete_product")
    protected String deleteProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String command = request.getParameter("command");
        String product_id = request.getParameter("product_id");

        String url = "";
        try {
            productRepo.deleteProduct(Long.parseLong(product_id));
            url = "/admin/manager_product";
        } catch (Exception e) {
        }
        return url;
    }

    @PostMapping("/insert_product")
    protected ResponseEntity insert(@RequestBody ProductInsertDto productInsertDto)
            throws SQLException {

        // create product id from time stamp
        long productId = new Date().getTime();

        // product color id
        ArrayList<Long> productColorIdList = new ArrayList<>();

        /** insert product */
        ProductEntity productEntity = new ProductEntity(
                productId,
                productInsertDto.getCateId(),
                productInsertDto.getProductName(),
                productInsertDto.getProductCode(),
                0,
                productInsertDto.getDescription(),
                0,
                1
        );
        if (!productRepo.insertProduct(productEntity)) {
            return ResponseEntity.badRequest().body("Sản phẩm thêm lỗi");
        }

        /** insert product color */
        for (int i = 0; i < productInsertDto.getProductColorImage().size(); i++) {
            ProductColorEntity productColorEntity = new ProductColorEntity(
                    productId
            );

            long productColorId = productColorRepo.insertColorOfProduct(productColorEntity);
            if (productColorId == 0l) {
                return ResponseEntity.badRequest().body("Màu sản phẩm thêm lỗi");
            }

            // get product color id after insert
            for (int j = 0; j < productInsertDto.getProductDetail().size(); j++) {
                if (productInsertDto.getProductDetail().get(j).getImageColorUrl().equals(productInsertDto.getProductColorImage().get(i).getImageUrl())) {
                    productInsertDto.getProductDetail().get(j).setProductColorId(productColorId);
                }
            }

            // colect product color id
            productColorIdList.add(productColorId);
        }

        /** insert product size */
        for (int i = 0; i < productInsertDto.getProductDetail().size(); i++) {
            if (!productSizeRepo.insertSizeOfProduct(
                    new ProductSizeEntity(
                            productInsertDto.getProductDetail().get(i).getProductColorId(),
                            productInsertDto.getProductDetail().get(i).getSizeName(),
                            productInsertDto.getProductDetail().get(i).getInventory(),
                            productInsertDto.getProductDetail().get(i).getPrice())
            )) {
                return ResponseEntity.badRequest().body("Size sản phẩm thêm lỗi");
            }
        }

        /** insert product image */
        for (int i = 0; i < productInsertDto.getProductImage().size(); i++) {
            ProductImageEntity productImageEntity = new ProductImageEntity(
                    productId,
                    0,
                    productInsertDto.getProductImage().get(i).getImageUrl()
            );

            if (!productImageRepo.insertImageOfProduct(productImageEntity)) {
                return ResponseEntity.badRequest().body("Image sản phẩm thêm lỗi");
            }
        }

        /** insert color image */
        for (int i = 0; i < productInsertDto.getProductColorImage().size(); i++) {
            ProductImageEntity productImageEntity = new ProductImageEntity(
                    0,
                    productColorIdList.get(i),
                    productInsertDto.getProductColorImage().get(i).getImageUrl()
            );

            if (!productImageRepo.insertImageOfColor(productImageEntity)) {
                return ResponseEntity.badRequest().body("Image sản phẩm thêm lỗi");
            }
        }

        return ResponseEntity.ok("success");
    }

    @PostMapping("/switch_active")
    protected ResponseEntity switchActive(HttpServletRequest request, HttpServletResponse response) {
        try {
            ProductDisplayDto productDisplayDto = new ProductDisplayDto();
            productDisplayDto.setProductId(Long.parseLong(request.getParameter("id")));
            productDisplayDto.setActive(request.getParameter("state").equals("true") ? true : false);

            productRepo.switchProduct(productDisplayDto);

            if (productDisplayDto.isActive()) {
                response.getWriter().write("active");
            } else {
                response.getWriter().write("inactive");
            }
        } catch (IOException | SQLException ex) {
            Logger.getLogger("account.update").log(Level.SEVERE, "Update account information false !!", ex);
        }
        return null;
    }

    @PostMapping("/update_product")
    protected ResponseEntity update(@RequestBody ProductInsertDto productInsertDto)
            throws SQLException {

//        /** Delete */
//        productRepo.deleteProduct(productInsertDto.getProductId());
//
//        insert(productInsertDto);
        return ResponseEntity.ok("success");
    }
}
