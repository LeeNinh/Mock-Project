package com.tainguyen.demo.model;

import lombok.Data;

import java.util.List;

@Data
public class ProductDisplayDto {
    private long productId;
    private long cateId;
    private String productCode;
    private String productName;
    private String description;
    private List<ProductImageEntity> productImageList;
    private List<ProductImageEntity> productColorImageList;
    private List<ProductSizeEntity> productDetailList;
    private List<ProductColorEntity> productColorIdList;
    private int numberPurchases;
    private boolean isActive;

}
