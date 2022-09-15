package com.tainguyen.demo.model;

import lombok.Data;

import java.sql.Timestamp;
import java.util.List;

@Data
public class BillEntity {

    private long billId;
    private long userId;
    private long productId;
    private Timestamp date;
    private String userNote;
    private String adminNote;
    private int totalQuantity;
    private int totalPrice;
    private int status;
    private List<BillDetailEntity> billDetailEntityList;

    public BillEntity() {
    }

    public BillEntity(long billId, long userId, long productId, Timestamp date, String userNote,
                      String adminNote, int totalQuantity, int totalPrice, int status) {
        this.billId = billId;
        this.userId = userId;
        this.productId = productId;
        this.date = date;
        this.userNote = userNote;
        this.adminNote = adminNote;
        this.totalQuantity = totalQuantity;
        this.totalPrice = totalPrice;
        this.status = status;
    }
}
