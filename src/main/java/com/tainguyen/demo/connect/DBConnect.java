package com.tainguyen.demo.connect;

import java.sql.Connection;
import java.sql.DriverManager;


public class DBConnect {
    
     public static Connection getConnecttion() {
        Connection cons = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cons = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/duonglien?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC&characterEncoding=UTF-8", "root", "29031996dN");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cons;
    }
}
