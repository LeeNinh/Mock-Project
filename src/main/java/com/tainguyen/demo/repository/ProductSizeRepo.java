package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.ProductSizeEntity;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Component
public class ProductSizeRepo {

    // Add size of product
    public boolean insertSizeOfProduct(ProductSizeEntity productSizeEntity) throws SQLException {
        // connects to the database
        Connection connection = DBConnect.getConnecttion();
        try {
            // constructs SQL statement
            String sql = "INSERT INTO product_size (product_color_id, product_size.name, inventory, price) " +
                    " VALUES(?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, productSizeEntity.getProductColorId());
            ps.setString(2, productSizeEntity.getName());
            ps.setLong(3, productSizeEntity.getInventory());
            ps.setLong(4, productSizeEntity.getPrice());

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

    // Get list product size by product color id
    public List<ProductSizeEntity> getProductSize(long productColorID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product_size WHERE product_color_id = '" + productColorID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        List<ProductSizeEntity> productSizeEntities = new ArrayList<>();
        while (rs.next()) {
            ProductSizeEntity productSizeEntity = new ProductSizeEntity();

            productSizeEntity.setProductSizeId(rs.getLong("product_size_id"));
            productSizeEntity.setProductColorId(rs.getLong("product_color_id"));
            productSizeEntity.setName(rs.getString("name"));
            productSizeEntity.setInventory(rs.getInt("inventory"));
            productSizeEntity.setPrice(rs.getLong("price"));

            productSizeEntities.add(productSizeEntity);
        }

        connection.close();
        return productSizeEntities;
    }


    // Get list product size by product id
    public ArrayList<ProductSizeEntity> getProductSizeById(long productId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT product_size_id, product_color.product_color_id, product_image.image_url, product_size.name, inventory, price " +
                " FROM product_size left join product_image on product_image.product_color_id = product_size.product_color_id " +
                " left join product_color on product_size.product_color_id = product_color.product_color_id " +
                " WHERE product_color.product_id = '" + productId + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ArrayList<ProductSizeEntity> productSizeEntities = new ArrayList<>();
        while (rs.next()) {
            ProductSizeEntity productSizeEntity = new ProductSizeEntity();

            productSizeEntity.setProductSizeId(rs.getLong("product_size_id"));
            productSizeEntity.setProductColorId(rs.getLong("product_color_id"));
            productSizeEntity.setProductColorUrl(rs.getString("image_url"));
            productSizeEntity.setName(rs.getString("name"));
            productSizeEntity.setInventory(rs.getInt("inventory"));
            productSizeEntity.setPrice(rs.getLong("price"));

            productSizeEntities.add(productSizeEntity);
        }

        connection.close();
        return productSizeEntities;
    }
}
