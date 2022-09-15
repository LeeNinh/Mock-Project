package com.tainguyen.demo.model;

import lombok.Data;

@Data
public class User {
    private long userID;
    private String userName;
    private String password;
    private String role;
    private String birthday;
    private String zaloName;
    private String zaloPhoneNumber;
    private String fullName;
    private String phoneNumber;
    private String address;
    private Boolean isActive;

    public User(long userID, String userName, String password, String role, String phoneNumber) {
        this.userID = userID;
        this.userName = userName;
        this.password = password;
        this.role = role;
        this.phoneNumber = phoneNumber;
    }

    public User() {
    }
}
