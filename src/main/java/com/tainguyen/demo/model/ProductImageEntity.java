package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class ProductImageEntity {
    private long productImageId;
    private long productId;
    private long productColorId;
    private String imageUrl;

    public ProductImageEntity(long productId, long productColorId, String imageUrl) {
        this.productId = productId;
        this.productColorId = productColorId;
        this.imageUrl = imageUrl;
    }

    public ProductImageEntity() {
    }
}
