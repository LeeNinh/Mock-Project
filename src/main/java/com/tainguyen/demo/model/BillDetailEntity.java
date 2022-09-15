package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class BillDetailEntity {

    private long billDetailId;
    private long billId;
    private ProductEntity productEntity;
    private long productId;
    private long colorId;
    private long sizeId;
    private int quantity;

    public BillDetailEntity() {
    }

    public BillDetailEntity(long billId, long productId, long colorId, long sizeId, int quantity) {
        this.billId = billId;
        this.productId = productId;
        this.colorId = colorId;
        this.sizeId = sizeId;
        this.quantity = quantity;
    }
}
