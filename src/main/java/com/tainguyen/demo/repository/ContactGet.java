package com.tainguyen.demo.repository;

import com.tainguyen.demo.connect.DBConnect;
import com.tainguyen.demo.model.Contact;
import org.springframework.stereotype.Component;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

@Component
public class ContactGet {

    public ArrayList<Contact> getListContact() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM contact";
        PreparedStatement ps = connection.prepareCall(sql);
        ResultSet rs = ps.executeQuery();
        ArrayList<Contact> list = new ArrayList<>();
        while (rs.next()) {
            Contact contact = new Contact();
            contact.setContactID(rs.getLong("contact_id"));
            contact.setContactName(rs.getString("contact_name"));
            contact.setContactTitle(rs.getString("contact_title"));
            contact.setContactMessage(rs.getString("contact_message"));
            contact.setDate(rs.getTimestamp("contact_date"));
            list.add(contact);
        }
        return list;
    }


    public boolean insertContact(Contact c) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO contact VALUES(?,?,?,?,?)";
        try {
            PreparedStatement ps = connection.prepareCall(sql);
            ps.setLong(1, c.getContactID());
            ps.setString(2, c.getContactName());
            ps.setString(3, c.getContactTitle());
            ps.setString(4, c.getContactMessage());
            ps.setTimestamp(5, c.getDate());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(ContactGet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

}
