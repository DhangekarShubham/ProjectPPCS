package com.twd.sugarfactory.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.twd.sugarfactory.dhconnection.DBConnection;
import com.twd.sugarfactory.model.UserBean;

public class LoginDao {

    public boolean validate(UserBean user) {
        boolean status = false;
        String sql = "SELECT * FROM users WHERE username = ? AND password_hash = ?";
        
        // Using try-with-resources to automatically close DB connections and prevent leaks
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            
            try (ResultSet rs = ps.executeQuery()) {
                status = rs.next(); // True if a record is found
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return status;
    }
}