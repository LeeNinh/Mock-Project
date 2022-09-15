package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.Newsletter;
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
public class NewsletterGet {
    @Autowired
    private DriverManagerDataSource dataSource;
    
    public ArrayList<Newsletter> getListNewsletter() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM newsletter";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Newsletter> list = new ArrayList<>();
        while (rs.next()) {
            Newsletter newsletter = new Newsletter();
           newsletter.setNewsletterID(rs.getLong("newsletter_id"));
           newsletter.setNewsletterName(rs.getString("newsletter_email"));       
           newsletter.setDate(rs.getTimestamp("date"));
           list.add(newsletter);
        }
        return list;
    }
   
    
    public boolean insertNewsletter(Newsletter c) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO newsletter VALUES(?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
         ps.setLong(1, c.getNewsletterID());    
         ps.setString(2, c.getNewsletterName());
         ps.setTimestamp(3, c.getDate());
         
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(NewsletterGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    
}
