package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.ProductDisplayDto;
import com.tainguyen.demo.model.ProductEntity;
import com.tainguyen.demo.model.ProductDetail;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
public class ProductRepo {

    ProductImageRepo productImageRepo = new ProductImageRepo();

    ProductSizeRepo productSizeRepo = new ProductSizeRepo();

    ProductColorRepo productColorRepo = new ProductColorRepo();

    public ArrayList<ProductDisplayDto> getListProductByCategory(long category_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product WHERE category_id = '" + category_id + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ArrayList<ProductDisplayDto> displayDtoList = new ArrayList<>();
        while (rs.next()) {
            ProductDisplayDto productDisplayDto = new ProductDisplayDto();

            productDisplayDto.setProductId(rs.getLong("product_id"));
            productDisplayDto.setCateId(rs.getLong("category_id"));
            productDisplayDto.setProductName(rs.getString("product_name"));
            productDisplayDto.setProductCode(rs.getString("product_code"));
            productDisplayDto.setNumberPurchases(rs.getInt("number_purchases"));
            displayDtoList.add(productDisplayDto);
        }

        // Lấy danh sách ảnh của sản phẩm
        for (int i = 0; i < displayDtoList.size(); i++) {
            displayDtoList.get(i).setProductImageList(productImageRepo.getImageByProductId(displayDtoList.get(i).getProductId()));
        }

        return displayDtoList;
    }

    // Lấy 6 sản phẩm có lượt bán cao nhất
    public ArrayList<ProductDisplayDto> getProductsByNumber() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product order by number_purchases desc, product_id desc limit 6";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ArrayList<ProductDisplayDto> displayDtoList = new ArrayList<>();
        while (rs.next()) {
            ProductDisplayDto productDisplayDto = new ProductDisplayDto();

            productDisplayDto.setProductId(rs.getLong("product_id"));
            productDisplayDto.setCateId(rs.getLong("category_id"));
            productDisplayDto.setProductName(rs.getString("product_name"));
            productDisplayDto.setProductCode(rs.getString("product_code"));
            productDisplayDto.setNumberPurchases(rs.getInt("number_purchases"));
            displayDtoList.add(productDisplayDto);
        }

        // Lấy danh sách ảnh của sản phẩm
        for (int i = 0; i < displayDtoList.size(); i++) {
            displayDtoList.get(i).setProductImageList(productImageRepo.getImageByProductId(displayDtoList.get(i).getProductId()));
        }

        connection.close();
        return displayDtoList;
    }

    public ArrayList<ProductDisplayDto> getListProduct() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ArrayList<ProductDisplayDto> displayDtoList = new ArrayList<>();
        while (rs.next()) {
            ProductDisplayDto productDisplayDto = new ProductDisplayDto();

            productDisplayDto.setProductId(rs.getLong("product_id"));
            productDisplayDto.setCateId(rs.getLong("category_id"));
            productDisplayDto.setProductName(rs.getString("product_name"));
            productDisplayDto.setProductCode(rs.getString("product_code"));
            productDisplayDto.setNumberPurchases(rs.getInt("number_purchases"));
            productDisplayDto.setActive(rs.getInt("isActive") == 0 ? false : true);
            displayDtoList.add(productDisplayDto);
        }

        // Lấy danh sách ảnh của sản phẩm
        for (int i = 0; i < displayDtoList.size(); i++) {
            displayDtoList.get(i).setProductImageList(productImageRepo.getImageByProductId(displayDtoList.get(i).getProductId()));
        }

        return displayDtoList;
    }

    public ArrayList<ProductEntity> getListProductByBrand(long brand_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product WHERE brand_id = '" + brand_id + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<ProductEntity> list = new ArrayList<>();
        while (rs.next()) {

            ProductEntity productEntity = new ProductEntity();

            productEntity.setProductID(rs.getLong("product_id"));
            productEntity.setProductName(rs.getString("product_name"));
            productEntity.setProductDescription(rs.getString("product_description"));
            list.add(productEntity);
        }
        return list;
    }

    public ArrayList<ProductDisplayDto> getListProductRelated(long category_id, long product_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product WHERE category_id = '" + category_id + "' and product_id != '" + product_id + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<ProductDisplayDto> list = new ArrayList<>();
        while (rs.next()) {

            ProductDisplayDto productDisplayDto = new ProductDisplayDto();

            productDisplayDto.setProductId(rs.getLong("product_id"));
            productDisplayDto.setProductName(rs.getString("product_name"));
            productDisplayDto.setDescription(rs.getString("product_description"));

            /** Get product images */
            productDisplayDto.setProductImageList(productImageRepo.getImageByProductId(productDisplayDto.getProductId()));

            list.add(productDisplayDto);
        }


        return list;
    }

    // Hiển thị chi tiết sản phẩm
    public ProductDisplayDto getProduct(long productID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product WHERE product_id = '" + productID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ProductDisplayDto productDisplayDto = new ProductDisplayDto();
        while (rs.next()) {
            productDisplayDto.setProductId(rs.getLong("product_id"));
            productDisplayDto.setCateId(rs.getLong("category_id"));
            productDisplayDto.setProductName(rs.getString("product_name"));
            productDisplayDto.setProductCode(rs.getString("product_code"));
            productDisplayDto.setDescription(rs.getString("product_description"));
            productDisplayDto.setNumberPurchases(rs.getInt("number_purchases"));
            productDisplayDto.setActive(rs.getInt("isActive") == 1 ? true : false);
        }

        /** Get product color id */
        productDisplayDto.setProductColorIdList(productColorRepo.getProductColorIdByProDuctId(productID));

        /** Get product images */
        productDisplayDto.setProductImageList(productImageRepo.getImageByProductId(productDisplayDto.getProductId()));

        /** Get product color images */
        productDisplayDto.setProductColorImageList(new ArrayList<>());
        for (int i = 0; i < productDisplayDto.getProductColorIdList().size(); i++) {
            productDisplayDto.getProductColorImageList().addAll(productImageRepo.getImageByProductColorId(productDisplayDto.getProductColorIdList().get(i).getProductColorId()));
        }

        /** Get product size */
        productDisplayDto.setProductDetailList(new ArrayList<>());
        for (int i = 0; i < productDisplayDto.getProductColorImageList().size(); i++) {
            productDisplayDto.getProductDetailList().addAll(productSizeRepo.getProductSize(productDisplayDto.getProductColorIdList().get(i).getProductColorId()));
        }

        return productDisplayDto;
    }

    // Thêm mới sản phẩm
    public boolean insertProduct(ProductEntity productEntity) throws SQLException {
        // connects to the database
        Connection connection = DBConnect.getConnecttion();
        try {
            // constructs SQL statement
            String sql = "INSERT INTO product (product_id, category_id, product_name, product_code," +
                    " product_price, product_description, number_purchases, isActive) " +
                    " VALUES(?,?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, productEntity.getProductID());
            ps.setLong(2, productEntity.getCategoryID());
            ps.setString(3, productEntity.getProductName());
            ps.setString(4, productEntity.getProductCode());
            ps.setLong(5, productEntity.getProductPrice());
            ps.setString(6, productEntity.getProductDescription());
            ps.setInt(7, productEntity.getNumberPurchases());
            ps.setInt(8, productEntity.getIsActive());

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

    // cập nhật dữ liệu
    public boolean updateProduct(ProductEntity c) throws SQLException {

        Connection connection = DBConnect.getConnecttion();
        // String sql = "UPDATE product SET product_id = ?, category_id = ?, product_name = ?, product_image = ?, product_image_forward = ?, product_image_back = ?, product_price = ?, product_description = ? WHERE product_id = ?";
        String sql = "UPDATE product SET product_id=?, category_id=?, product_name=?, product_image=?, " +
                " product_image_forward=?, product_image_back=?, product_price=?, product_description = ? " +
                " WHERE product_id = ?";

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, c.getProductID());
            ps.setLong(2, c.getCategoryID());
            ps.setString(3, c.getProductName());
            ps.setString(8, c.getProductDescription());
            ps.setLong(9, c.getProductID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Xóa product và các thành phần liên quan
    public boolean deleteProduct(long product_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sqlDelete1 = "DELETE FROM product WHERE product_id = ?";
        String sqlDelete2 = "DELETE FROM product_color WHERE product_id = ?";
        String sqlDelete3 = "DELETE FROM product_image WHERE product_id = ?";

        String sqlSelect = "SELECT product_color_id FROM product_color WHERE product_id = ?";
        String sqlDelete4 = "DELETE FROM product_size WHERE product_color_id = ?";
        String sqlDelete5 = "DELETE FROM product_image WHERE product_color_id = ?";


        try {
            PreparedStatement ps1 = connection.prepareCall(sqlDelete1);
            PreparedStatement ps2 = connection.prepareCall(sqlDelete2);
            PreparedStatement ps3 = connection.prepareCall(sqlDelete3);

            PreparedStatement psSelect = connection.prepareCall(sqlSelect);
            PreparedStatement ps4 = connection.prepareCall(sqlDelete4);
            PreparedStatement ps5 = connection.prepareCall(sqlDelete5);

            // set param
            ps1.setLong(1, product_id);
            ps2.setLong(1, product_id);
            ps3.setLong(1, product_id);

            // execute
            ps1.executeUpdate();
            ps3.executeUpdate();

            // set param select
            psSelect.setLong(1, product_id);

            ResultSet rs = psSelect.executeQuery();
            while (rs.next()) {
                ps4.setLong(1, rs.getLong("product_color_id"));
                ps5.setLong(1, rs.getLong("product_color_id"));

                // execute
                ps4.executeUpdate();
                ps5.executeUpdate();
            }

            ps2.executeUpdate();

            connection.close();
            return true;

        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Tăng lần mua hàng cho sản phẩm
    public boolean incNumOfPurchases(long product_id, int quantity) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "update duonglien.product set product.number_purchases = product.number_purchases + " + quantity +
                " where product.product_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, product_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Trừ số hàng trong kho sau khi đặt
    public boolean modInventory(long productSizeId, int quantity, boolean isAdd) throws SQLException {
        Connection connection = DBConnect.getConnecttion();

        String sql;
        if (isAdd) {
            sql = "update product_size set inventory = inventory + " + quantity +
                    " where product_size_id = ?";
        } else {
            sql = "update product_size set inventory = inventory - " + quantity +
                    " where product_size_id = ?";
        }

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, productSizeId);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    // Lấy số lượng hàng tồn trong kho (theo mẫu sản phẩm)
    public int getInventoryByProId(long producDetailtId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql1 = "SELECT inventory FROM product_detail where product_detail_id = ?";

        try {
            PreparedStatement ps = connection.prepareCall(sql1);
            ps.setLong(1, producDetailtId);
            ResultSet rs = ps.executeQuery();
            int inventory = 0;
            while (rs.next()) {
                inventory = rs.getInt("inventory");
            }

            return inventory;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    // Search product by name
    public List<ProductDisplayDto> searchByName(String key) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM product WHERE product.product_name like '%" + key + "%' or product.product_code like '%" + key + "%'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ArrayList<ProductDisplayDto> displayDtoList = new ArrayList<>();
        while (rs.next()) {
            ProductDisplayDto productDisplayDto = new ProductDisplayDto();

            productDisplayDto.setProductId(rs.getLong("product_id"));
            productDisplayDto.setCateId(rs.getLong("category_id"));
            productDisplayDto.setProductName(rs.getString("product_name"));
            productDisplayDto.setProductCode(rs.getString("product_code"));
            productDisplayDto.setNumberPurchases(rs.getInt("number_purchases"));
            displayDtoList.add(productDisplayDto);
        }

        // Lấy danh sách ảnh của sản phẩm
        for (int i = 0; i < displayDtoList.size(); i++) {
            displayDtoList.get(i).setProductImageList(productImageRepo.getImageByProductId(displayDtoList.get(i).getProductId()));
        }

        return displayDtoList;
    }


//    Product detail

    // thêm sản phẩm chi tiết
    public boolean insertProductDetail(ProductDetail productDetail) throws SQLException {
        // connects to the database
        Connection connection = DBConnect.getConnecttion();
        try {
            // constructs SQL statement
            String sql = "INSERT INTO product_detail (product_id, product_detail.name, inventory) " +
                    " VALUES(?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, productDetail.getProductId());
            ps.setString(2, productDetail.getName());
            ps.setInt(3, productDetail.getInventory());

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

    // Lấy danh sách sản phẩm chi tiết từ productId
    public ArrayList<ProductDetail> getListProductDetailByPro(long productId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM duonglien.product_detail where product_id = '" + productId + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<ProductDetail> list = new ArrayList<>();

        while (rs.next()) {
            ProductDetail productDetail = new ProductDetail();

            productDetail.setProductId(rs.getLong("product_id"));
            productDetail.setProductDetailId(rs.getLong("product_detail_id"));
            productDetail.setName(rs.getString("name"));
            productDetail.setInventory(rs.getInt("inventory"));

            list.add(productDetail);
        }

        return list;
    }

    // xóa product detail theo product id
    public boolean deleteProductDetail(long productId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "DELETE FROM product_detail WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, productId);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // active product
    public boolean switchProduct(ProductDisplayDto productDisplayDto) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE product SET " +
                " isActive = ? " +
                " WHERE product_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, productDisplayDto.isActive() ? "1" : "0");
            ps.setLong(2, productDisplayDto.getProductId());

            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
