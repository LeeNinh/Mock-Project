package com.tainguyen.demo.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * Lịch sử mua hàng
 */

@Data
public class BillDto {
    private long billId;
    private long productId;
    private long userId;
    private String userName;
    private ArrayList<ProductImageEntity> ProductImage;
    private ArrayList<ProductImageEntity> colorImage;
    private String productCode;
    private String productName;
    private ArrayList<ProductSizeEntity> sizeEntities;
    // data for export excel
    private List<BillDetailDto> billDetailDtos;

    private String date;
    private int status;
    private int totalQuantity;
    private int totalPrice;
    private String userNote;
    private String adminNote;
    private int discount;

    // TaiNT them
    private String phoneNumber;
    private String address;

    public BillDto() {
    }

    public List<String []> exportExcelRow() {
        List<String []> list = new ArrayList<>();
        if (Objects.nonNull(billDetailDtos))
        for (BillDetailDto billDetailEntity : billDetailDtos) {
            list.add(new String [] {userName, productName, productCode,
                    Objects.nonNull(billDetailEntity) ? billDetailEntity.getNameImage() : null,
                    Objects.nonNull(billDetailEntity) ? billDetailEntity.getSize() : null,
                    Objects.nonNull(billDetailEntity) ? String.valueOf(billDetailEntity.getQuantity()) : "0"});
        }
        return list;
    }
}
