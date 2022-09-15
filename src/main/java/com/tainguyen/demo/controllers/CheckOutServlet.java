package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.*;
import com.tainguyen.demo.repository.BillDetailGet;
import com.tainguyen.demo.repository.BillGet;
import com.tainguyen.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

@Controller
public class CheckOutServlet extends HttpServlet {

    @Autowired
    BillGet billGet;

    @Autowired
    BillDetailGet billDetailGet;

    @Autowired
    ProductRepo productGet;

    @PostMapping("CheckOutServlet")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");
        User users = (User) session.getAttribute("user");

        try {
            long ID = new Date().getTime();
            BillEntity billEntity = new BillEntity();
            billEntity.setBillId(ID);

            billEntity.setUserId(users.getUserID());
            billEntity.setDate(new Timestamp(new Date().getTime()));
//            billEntity.setTotal(cart.totalCart());
            billEntity.setStatus(1);

            billGet.insertBill(billEntity);
            for (Map.Entry<Long, Item> list : cart.getCartItems().entrySet()) {
                long productId = list.getValue().getProductEntity().getProductID();
                int inventory = productGet.getInventoryByProId(productId);
                int quantity = list.getValue().getQuantity();

                if (inventory >= quantity) {
//                    billDetailGet.insertBillDetail(new BillDetailEntity(new Date().getTime(), ID,
//                            productId,
//                            list.getValue().getProductEntity().getProductPrice(),
//                            list.getValue().getQuantity()));

                    productGet.incNumOfPurchases(productId, list.getValue().getQuantity());
                } else {
                    response.getWriter().write("Hàng trong kho không đủ");
                    return;
                }

//                billDetailGet.insertBillDetail(new BillDetailEntity(new Date().getTime(), ID,
//                        productId,
//                        list.getValue().getProductEntity().getProductPrice(),
//                        list.getValue().getQuantity()));

                productGet.incNumOfPurchases(productId, list.getValue().getQuantity());
            }
            cart = new Cart();
            session.setAttribute("cart", cart);
        } catch (Exception e) {
        }
        response.getWriter().write("success");
    }

    @GetMapping("/billMod")
    public String CartServlet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setCharacterEncoding("utf-8");

        String productID = request.getParameter("billId");
        String billStatus = request.getParameter("billStatus");
        String discountStr = request.getParameter("discount").replaceAll(",", "");
        Integer discount = discountStr.equals("") ? 0 : Integer.parseInt(discountStr);
        String adminNote = request.getParameter("adminNote");

        Long idProduct = Long.parseLong(productID);
        Integer status = Integer.parseInt(billStatus);

        try {
            billGet.billMod(idProduct, status, discount, adminNote);
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            response.getWriter().write("false");
        }
        response.getWriter().write("success");
        return null;
    }
}