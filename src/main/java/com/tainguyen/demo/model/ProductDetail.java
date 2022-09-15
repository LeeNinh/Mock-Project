package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class ProductDetail {
    private long productDetailId;
    private long productId;
    private String name;
    private int inventory;

    public ProductDetail(long productId, String name, int inventory) {
        this.productId = productId;
        this.name = name;
        this.inventory = inventory;
    }

    public ProductDetail() {
    }
}
