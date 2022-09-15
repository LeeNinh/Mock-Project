package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class ProductColorEntity {
    private long productColorId;
    private long productId;

    public ProductColorEntity(long productId) {
        this.productId = productId;
    }

    public ProductColorEntity() {
    }
}
