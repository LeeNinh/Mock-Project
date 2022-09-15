package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.ProductColorEntity;
import com.tainguyen.demo.model.ProductImageEntity;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

@Component
public class ProductImageRepo {

    // Add image of product
    public boolean insertImageOfProduct(ProductImageEntity productImageEntity) throws SQLException {
        // connects to the database
        Connection connection = DBConnect.getConnecttion();
        try {
            // constructs SQL statement
            String sql = "INSERT INTO product_image (product_id, image_url) " +
                    " VALUES(?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, productImageEntity.getProductId());
            ps.setString(2, productImageEntity.getImageUrl());

            // sends the statement to the database server
            int row = ps.executeUpdate();
            if (row > 0) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            connection.close();
            return false;
        }
        return false;
    }

    // Add image of color
    public boolean insertImageOfColor(ProductImageEntity productImageEntity) throws SQLException {
        // connects to the database
        Connection connection = DBConnect.getConnecttion();
        try {
            // constructs SQL statement
            String sql = "INSERT INTO product_image (product_color_id, image_url) " +
                    " VALUES(?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, productImageEntity.getProductColorId());
            ps.setString(2, productImageEntity.getImageUrl());

            // sends the statement to the database server
            int row = ps.executeUpdate();
            if (row > 0) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            connection.close();
            return false;
        }
        return false;
    }

    /** Get image url by product id */
    public ArrayList<ProductImageEntity> getImageByProductId(Long productId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product_image where product_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, productId);

        ResultSet rs = ps.executeQuery();
        ArrayList<ProductImageEntity> list = new ArrayList<>();
        while (rs.next()) {
            ProductImageEntity productImageEntity = new ProductImageEntity();
            productImageEntity.setProductImageId(rs.getLong("product_image_id"));
            productImageEntity.setProductId(rs.getLong("product_id"));
            productImageEntity.setImageUrl(rs.getString("image_url"));

            list.add(productImageEntity);
        }
        return list;
    }

    /** Get image entity by product color id */
    public ArrayList<ProductImageEntity> getImageByProductColorId(Long productColorId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product_image where product_color_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setLong(1, productColorId);

        ResultSet rs = ps.executeQuery();
        ArrayList<ProductImageEntity> list = new ArrayList<>();
        while (rs.next()) {
            ProductImageEntity imageUrl = new ProductImageEntity();
            imageUrl.setProductImageId(rs.getLong("product_image_id"));
            imageUrl.setProductColorId(rs.getLong("product_color_id"));
            imageUrl.setImageUrl( rs.getString("image_url"));

            list.add(imageUrl);
        }
        return list;
    }
}
