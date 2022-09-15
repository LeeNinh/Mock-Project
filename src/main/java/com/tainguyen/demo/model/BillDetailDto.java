package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class BillDetailDto {

    // id bill detail
    private long billDetailId;
    // url color image
    private String colorImageUrl;
    // name of image
    private String nameImage;
    // name of size
    private String size;
    // price of size
    private long price;
    // quantity of order
    private int quantity;

    private long discount;

    private String productName;

    public BillDetailDto() {
    }
}
