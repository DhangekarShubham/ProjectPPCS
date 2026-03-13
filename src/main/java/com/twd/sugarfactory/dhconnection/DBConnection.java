package com.twd.sugarfactory.dhconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    // 1. Database Credentials and URL
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver"; 
    private static final String DB_URL = "jdbc:mysql://localhost:3306/sugar_plant_erp";
    private static final String DB_USER = "root";       // replace with your username
    private static final String DB_PASSWORD = "Shubham@1234";   // replace with your password

    /**
     * Establishes and returns a new database connection.
     */
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // 2. Load the JDBC Driver
            Class.forName(DB_DRIVER);
            
            // 3. Establish the Connection
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connected successfully!");
            
        } catch (ClassNotFoundException e) {
            System.err.println("Database Driver not found! Ensure the JAR is in WEB-INF/lib or pom.xml");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Failed to connect to the database!");
            e.printStackTrace();
        }
        return connection;
    }
}