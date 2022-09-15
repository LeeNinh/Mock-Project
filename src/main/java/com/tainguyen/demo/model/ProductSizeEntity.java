package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class ProductSizeEntity {
    private long productSizeId;
    private long productColorId;
    private String productColorUrl;
    private String name;
    private int inventory;
    private long price;

    public ProductSizeEntity(long productColorId, String name, int inventory, long price) {
        this.productColorId = productColorId;
        this.name = name;
        this.inventory = inventory;
        this.price = price;
    }

    public ProductSizeEntity() {
    }
}
