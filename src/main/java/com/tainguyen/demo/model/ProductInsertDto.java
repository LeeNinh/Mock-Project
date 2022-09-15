package com.tainguyen.demo.model;

import lombok.Data;

import java.util.List;

@Data
public class ProductInsertDto {
    private long cateId;
    private long productId;
    private String productCode;
    private String productName;
    private String description;
    private List<ImageUrl> productImage;
    private List<ImageUrl> productColorImage;
    private List<ProductDetailDto> productDetail;

    public ProductInsertDto() {
    }
}
