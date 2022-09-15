package com.tainguyen.demo.controllers;

import com.tainguyen.demo.model.BillDetailEntity;
import com.tainguyen.demo.model.BillEntity;
import com.tainguyen.demo.repository.BillDetailGet;
import com.tainguyen.demo.repository.BillGet;
import com.tainguyen.demo.repository.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServlet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

@RestController
public class CheckOutController extends HttpServlet {

    @Autowired
    BillGet billGet;

    @Autowired
    BillDetailGet billDetailGet;

    @Autowired
    ProductRepo productGet;

    @PostMapping("checkout")
    protected ResponseEntity checkout(@RequestBody BillEntity billEntity) {
        try {
            // Bill id
            long billId = new Date().getTime();
            billEntity.setDate(new Timestamp(new Date().getTime()));
            billEntity.setStatus(1);

            /** Insert bill */
            billEntity.setBillId(billId);
            boolean isInsertProduct = billGet.insertBill(billEntity);
            if (!isInsertProduct) {
                return ResponseEntity.badRequest().body("Đặt hàng không thành công");
            }

            /** Insert bill detail */
            for (int i = 0; i < billEntity.getBillDetailEntityList().size(); i++) {
                BillDetailEntity item = billEntity.getBillDetailEntityList().get(i);

                // set field
                billEntity.setBillId(billId);

                // insert bill detail
                BillDetailEntity billDetailEntity = new BillDetailEntity(
                        billId,
                        item.getProductId(),
                        item.getColorId(),
                        item.getSizeId(),
                        item.getQuantity()
                );
                boolean isInsertBillDetail = billDetailGet.insertBillDetail(billDetailEntity);
                if (!isInsertBillDetail) {
                    return ResponseEntity.badRequest().body("Đặt hàng không thành công");
                }

                    // Trừ số hàng (theo mẫu sản phẩm) trong kho
                    productGet.modInventory(item.getSizeId(), item.getQuantity(), false);
            }

            // Tăng lượt mua cho sản phẩm
            productGet.incNumOfPurchases(billEntity.getProductId(), billEntity.getTotalQuantity());


            return ResponseEntity.ok("Đặt hàng thành công");

        } catch (SQLException exception) {
            exception.printStackTrace();
            return ResponseEntity.badRequest().body("Có lỗi xảy ra");
        }
    }
}