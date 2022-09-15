package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class ProductEntity {
    private long productID;
    private long categoryID;
    private String productName;
    private String productCode;
    private long productPrice;
    private String productDescription;
    private int numberPurchases;
    private int isActive;

    public ProductEntity() {

    }

    public ProductEntity(long productID, long categoryID, String productName, String productCode,
                         long productPrice, String productDescription, int numberPurchases, int isActive) {
        this.productID = productID;
        this.categoryID = categoryID;
        this.productName = productName;
        this.productCode = productCode;
        this.productPrice = productPrice;
        this.productDescription = productDescription;
        this.numberPurchases = numberPurchases;
        this.isActive = isActive;
    }

    public ProductEntity(long productID, long categoryID, String productName,
                         String productDescription, String productCode) {
        this.productID = productID;
        this.categoryID = categoryID;
        this.productName = productName;
        this.productDescription = productDescription;
        this.productCode = productCode;
    }
}
