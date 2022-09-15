package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.ImageUrl;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
public class ImageRepo {

    public ArrayList<ImageUrl> getAllImageUrl() {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "SELECT * FROM duonglien.image_url";

            PreparedStatement ps = connection.prepareCall(sql);

            ResultSet rs = ps.executeQuery();
            ArrayList<ImageUrl> list = new ArrayList<>();
            while (rs.next()) {
                ImageUrl history = new ImageUrl();

                history.setId(rs.getLong("image_url_id"));
                history.setImageName(rs.getString("image_name"));
                history.setImageUrl(rs.getString("image_url"));

                list.add(history);
            }
            connection.close();
            return list;
        } catch (SQLException ex) {
            Logger.getLogger(ImageRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean getAllImageUrlByName(String imageName) {
        try {
            Connection connection = DBConnect.getConnecttion();
            String sql = "SELECT * FROM duonglien.image_url where image_name = ?";

            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, imageName);

            ResultSet rs = ps.executeQuery();
            ArrayList<ImageUrl> list = new ArrayList<>();
            while (rs.next()) {
                connection.close();
                return true;
            }
            connection.close();
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(ImageRepo.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public void insertImageUrl(ImageUrl imageUrl) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO image_url (image_name, image_url) " +
                " VALUES(?,?)";
        PreparedStatement ps = connection.prepareCall(sql);

        ps.setString(1, imageUrl.getImageName());
        ps.setString(2, imageUrl.getImageUrl());

        ps.executeUpdate();

        // close connection
        connection.close();
    }
}
