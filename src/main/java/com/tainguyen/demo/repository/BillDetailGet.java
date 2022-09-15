package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.BillDetailDto;
import com.tainguyen.demo.model.BillDetailEntity;
import com.tainguyen.demo.model.ProductColorEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
public class BillDetailGet {
    @Autowired
    private DriverManagerDataSource dataSource;

    public boolean insertBillDetail(BillDetailEntity billDetail) {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO bill_detail (bill_id, product_id, color_id, size_id, quantity) " +
                    "VALUES(?,?,?,?,?)";
            try {
                PreparedStatement ps = connection.prepareCall(sql);
                ps.setLong(1, billDetail.getBillId());
                ps.setLong(2, billDetail.getProductId());
                ps.setLong(3, billDetail.getColorId());
                ps.setDouble(4, billDetail.getSizeId());
                ps.setInt(5, billDetail.getQuantity());
                ps.executeUpdate();

                connection.close();
                return true;
            } catch (SQLException exp) {
                return false;
            }
    }

    // Get bill detail by product id
    public ArrayList<BillDetailDto> getBillDetailByProductId(long productId) {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "SELECT bill_detail_id, product_image.image_url, product_size.name, " +
                    " product_size.price, quantity FROM bill_detail " +
                    " left join product_image on product_image.product_color_id = bill_detail.color_id " +
                    " left join product_size on product_size.product_size_id = bill_detail.size_id " +
                    " where bill_detail.product_id = ?";

            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, productId);
            ResultSet rs = ps.executeQuery();
            ArrayList<BillDetailDto> list = new ArrayList<>();

            while (rs.next()) {
                BillDetailDto billDetailDto = new BillDetailDto();

                billDetailDto.setBillDetailId(rs.getLong("bill_detail_id"));
                billDetailDto.setColorImageUrl(rs.getString("image_url"));
                billDetailDto.setSize(rs.getString("name"));
                billDetailDto.setPrice(rs.getLong("price"));
                billDetailDto.setQuantity(rs.getInt("quantity"));

                list.add(billDetailDto);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDetailGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Get bill detail by bill id
    public ArrayList<BillDetailDto> getBillDetailByBillId(long billId) {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "SELECT bill_detail_id, product_image.image_url, product_size.name, " +
                    " product_size.price, quantity FROM bill_detail " +
                    " left join product_image on product_image.product_color_id = bill_detail.color_id " +
                    " left join product_size on product_size.product_size_id = bill_detail.size_id " +
                    " where bill_detail.bill_id = ?";

            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, billId);
            ResultSet rs = ps.executeQuery();
            ArrayList<BillDetailDto> list = new ArrayList<>();

            while (rs.next()) {
                BillDetailDto billDetailDto = new BillDetailDto();

                billDetailDto.setBillDetailId(rs.getLong("bill_detail_id"));
                billDetailDto.setColorImageUrl(rs.getString("image_url"));
                billDetailDto.setSize(rs.getString("name"));
                billDetailDto.setPrice(rs.getLong("price"));
                billDetailDto.setQuantity(rs.getInt("quantity"));
                billDetailDto.setNameImage(getNameImage(billDetailDto.getColorImageUrl()));

                list.add(billDetailDto);
            }
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(BillDetailGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return new ArrayList<>();
    }

    String getNameImage(String urlImage) {
        int start = urlImage.indexOf("=");
        int end = urlImage.indexOf(".");
        return urlImage.substring(start + 1, end);
    }
}
