package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.Cart;
import com.tainguyen.demo.model.Item;
import com.tainguyen.demo.model.ProductEntity;
import com.tainguyen.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@Controller
public class ProductController {

    @Autowired
    ProductRepo productGet;

    @GetMapping("/CartServlet")
    public String CartServlet(HttpServletRequest request) {
        HttpSession session = request.getSession();
        String command = request.getParameter("command");
        String productID = request.getParameter("productID");
        Cart cart = (Cart) session.getAttribute("cart");

        try {
            Long idProduct = Long.parseLong(productID);
            ProductEntity productEntity = new ProductEntity();

            switch (command) {
                case "plus":
                    if (cart.getCartItems().containsKey(idProduct)) {
                        cart.plusToCart(idProduct, new Item(productEntity, cart.getCartItems().get(idProduct).getQuantity()));
                    } else {
                        cart.plusToCart(idProduct, new Item(productEntity, 1));
                    }
                    break;
                case "minus" :
                    if (cart.getCartItems().get(idProduct).getQuantity() > 1) {
                        cart.subToCart(idProduct, new Item(productEntity, cart.getCartItems().get(idProduct).getQuantity()));
                    }
                    break;
                case "remove":
                    cart.removeToCart(idProduct);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "/checkout";
        }
        session.setAttribute("cart", cart);
        return "/checkout";
    }

    @GetMapping("searchProductByName")
    protected String searchProductByName(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        String key = request.getParameter("key");
        request.setAttribute("key", key);

        return "products";
    }
}
