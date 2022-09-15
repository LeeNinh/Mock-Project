package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.User;
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

import static com.tainguyen.demo.controllers.utilities.Utility.ADMIN_ROLE;

@Component
public class UserGet {
    @Autowired
    private DriverManagerDataSource dataSource;

    public ArrayList<User> getListUser() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM users";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<User> list = new ArrayList<>();
        while (rs.next()) {
            User user = new User();
            user.setUserID(rs.getLong("user_id"));
            user.setUserName(rs.getString("user_name"));
            user.setPassword(rs.getString("password"));
            user.setRole(rs.getString("role"));
            user.setBirthday(rs.getString("biirthday"));
            user.setZaloName(rs.getString("zalo_name"));
            user.setZaloPhoneNumber(rs.getString("zalo_phone_number"));
            user.setFullName(rs.getString("full_name"));
            user.setPhoneNumber(rs.getString("phone_number"));
            user.setAddress(rs.getString("address"));
            user.setIsActive(rs.getBoolean("is_active"));

            // ignore admin account
            if (user.getRole().equals(ADMIN_ROLE)) {
                continue;
            }

            list.add(user);
        }
        connection.close();
        return list;
    }

    public boolean checkEmail(String name) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM users WHERE user_name = '" + name + "'";
        PreparedStatement ps;
        try {
            ps = connection.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    // phương thức thêm tài khoản
    public boolean insertUser(User u) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO users VALUES(?,?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, u.getUserID());
            ps.setString(2, u.getUserName());
            ps.setString(3, u.getPassword());
            ps.setString(4, u.getRole());
            ps.setString(5, u.getBirthday());
            ps.setString(6, u.getZaloName());
            ps.setString(7, u.getZaloPhoneNumber());
            ps.setString(8, u.getFullName());
            ps.setString(9, u.getPhoneNumber());
            ps.setString(10, u.getAddress());
            ps.setBoolean(11, u.getIsActive());

            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public User login(String name, String password) {
        Connection con = DBConnect.getConnecttion();
        String sql = "select * from users where user_name=? and password=?";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserID(rs.getLong("user_id"));
                u.setUserName(rs.getString("user_name"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                con.close();
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public User getUser(long userID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM users WHERE user_id = ?";
        PreparedStatement ps = connection.prepareCall(sql);
        ps.setString(1, String.valueOf(userID) );
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            User user = new User();
            user.setUserID(rs.getLong("user_id"));
            user.setUserName(rs.getString("user_name") == null ? "" : rs.getString("user_name"));
            user.setPassword(rs.getString("password") == null ? "" : rs.getString("password"));
            user.setRole(rs.getString("role") == null ? "" : rs.getString("password"));
            user.setBirthday(rs.getString("biirthday") == null ? "" : rs.getString("biirthday"));
            user.setZaloName(rs.getString("zalo_name") == null ? "" : rs.getString("zalo_name"));
            user.setZaloPhoneNumber(rs.getString("zalo_phone_number") == null ? "" : rs.getString("zalo_phone_number"));
            user.setFullName(rs.getString("full_name") == null ? "" : rs.getString("full_name"));
            user.setPhoneNumber(rs.getString("phone_number") == null ? "" : rs.getString("phone_number"));
            user.setAddress(rs.getString("address") == null ? "" : rs.getString("address"));

            connection.close();
            return user;
        }
        connection.close();
        return null;
    }

    public boolean updateUser(User u) {

        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE users SET " +
                " birthday=?, zalo_name=?, " +
                " zalo_phone_number=?, full_name=?, " +
                " phone_number=?, address=? " +
                " WHERE user_id = ?";

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, u.getBirthday());
            ps.setString(2, u.getZaloName());
            ps.setString(3, u.getZaloPhoneNumber());
            ps.setString(4, u.getFullName());
            ps.setString(5, u.getPhoneNumber());
            ps.setString(6, u.getAddress());
            ps.setLong(7, u.getUserID());

            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean updatePassword(User u) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE users SET " +
                " password=? " +
                " WHERE user_id = ?";

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, u.getPassword());
            ps.setLong(2, u.getUserID());

            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean activeAccount(User u) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "UPDATE users SET " +
                " is_active = ? " +
                " WHERE user_id = ?";

        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setString(1, u.getIsActive() ? "1" : "0");
            ps.setLong(2, u.getUserID());

            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(ProductRepo.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public User getUserByUserName(String username) {
        Connection con = DBConnect.getConnecttion();
        String sql = "select * from users where user_name=?";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) con.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserID(rs.getLong("user_id"));
                u.setUserName(rs.getString("user_name"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                u.setBirthday(rs.getString("biirthday"));
                u.setZaloName(rs.getString("zalo_name"));
                u.setZaloPhoneNumber(rs.getString("zalo_phone_number"));
                u.setFullName(rs.getString("full_name"));
                u.setPhoneNumber(rs.getString("phone_number"));
                u.setAddress(rs.getString("address"));
                u.setIsActive(rs.getInt("is_active") == 0 ? false : true);
                con.close();
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
