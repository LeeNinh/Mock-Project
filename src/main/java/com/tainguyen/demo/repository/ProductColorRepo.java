package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.Newsletter;
import com.tainguyen.demo.model.ProductColorEntity;
import com.tainguyen.demo.model.ProductSizeEntity;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Component
public class ProductColorRepo {

    // Add product color
    public long insertColorOfProduct(ProductColorEntity productColorEntity) throws SQLException {
        // connects to the database
        Connection connection = DBConnect.getConnecttion();
        try {
            String idAfterInsert = "SELECT product_color_id FROM duonglien.product_color" +
                    " order by product_color_id desc limit 1";

            // constructs SQL statement
            String sql = "INSERT INTO product_color (product_id) " +
                    " VALUES(?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, productColorEntity.getProductId());

            // sends the statement to the database server
            int row = ps.executeUpdate();
            if (row > 0) {
                PreparedStatement ps1 = connection.prepareCall(idAfterInsert);
                ResultSet rs = ps1.executeQuery();

                while (rs.next()) {
                    long productColorId = rs.getLong("product_color_id");

                    connection.close();
                    return productColorId;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            connection.close();
            return 0;
        }
        return 0;
    }

    // Get list product_color_id by productId
    public List<ProductColorEntity> getProductColorIdByProDuctId(long productId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product_color WHERE product_id = '" + productId + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        List<ProductColorEntity> productColorEntities = new ArrayList<>();

        while (rs.next()) {
            ProductColorEntity productColorEntity = new ProductColorEntity();
            productColorEntity.setProductColorId(rs.getLong("product_color_id"));

            productColorEntities.add(productColorEntity);
        }

        connection.close();
        return productColorEntities;
    }

}
