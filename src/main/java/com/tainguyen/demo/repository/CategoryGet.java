package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
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
public class CategoryGet {
    @Autowired
    private DriverManagerDataSource dataSource;

    public ArrayList<Category> getListCategory() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Category> list = new ArrayList<>();
        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getLong("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryImage(rs.getString("category_image"));
            list.add(category);
        }
        return list;
    }

    public Category getCategory(long categoryID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category WHERE category_id = '" + categoryID + "'";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        Category category = new Category();
        while (rs.next()) {
            category.setCategoryID(rs.getLong("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryImage(rs.getString("category_image"));
        }
        return category;
    }

    public List<Category> getList6Category() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category order by category_id desc limit 6";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        List<Category> categories = new ArrayList<>();
        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getLong("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryImage(rs.getString("category_image"));

            categories.add(category);
        }
        return categories;
    }

    public boolean insert(Category c) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO category VALUE(?,?)";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, c.getCategoryID());
            ps.setString(2, c.getCategoryName());
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean update(Category c) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "UPDATE category SET category_name = ? WHERE category_id = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, c.getCategoryName());
            ps.setLong(2, c.getCategoryID());
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean delete(long category_id) throws SQLException {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM category WHERE category_id = ?";
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, category_id);
            int temp = ps.executeUpdate();
            return temp == 1;
        } catch (Exception e) {
            return false;
        }
    }

    public boolean insertCategory(Category c) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO category (category_id, category_name, category_image) VALUES(?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, c.getCategoryID());
            ps.setString(2, c.getCategoryName());
            ps.setString(3, c.getCategoryImage());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // Cập nhật danh mục
    public boolean updateCategory(Category c) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE category SET category_name = ?, category_image = ? WHERE category_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getCategoryImage());
            ps.setLong(3, c.getCategoryID());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // xóa dữ liệu
    public boolean deleteCategory(long category_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "DELETE FROM category WHERE category_id = ?";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, category_id);
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(CategoryGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
