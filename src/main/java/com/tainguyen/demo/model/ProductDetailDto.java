package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class ProductDetailDto {
    private long productColorId;
    private String imageColorUrl;
    private String sizeName;
    private int price;
    private int inventory;
}
