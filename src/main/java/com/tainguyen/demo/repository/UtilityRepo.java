package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import static com.tainguyen.demo.controllers.utilities.Utility.UPLOAD_URL;

@Component
public class UtilityRepo {

    public String getUtilityByKey(String key) {
        if (UPLOAD_URL == null) {
            try {
                Connection connection = DBConnect.getConnecttion();
                String sql = "SELECT * FROM utility WHERE utility.key = '" + key + "'";
                PreparedStatement ps = connection.prepareCall(sql);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getString("content");
                }
            } catch (SQLException ex) {
                Logger.getLogger(UtilityRepo.class.getName()).log(Level.SEVERE, null, ex);
            }
            return null;
        }
        else {
            return UPLOAD_URL;
        }
    }
}
