package com.twd.sugarfactory.model;

public class UserBean {
    private String username;
    private String password;
    private String yearCode;

    // Default Constructor
    public UserBean() {}

    // Getters and Setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getYearCode() { return yearCode; }
    public void setYearCode(String yearCode) { this.yearCode = yearCode; }
}