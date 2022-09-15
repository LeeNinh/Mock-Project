package com.tainguyen.demo.model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class Contact {
    private long contactID;
    private String contactName;
    private String contactTitle;
    private String contactMessage;
    private Timestamp date;
    
    public Contact(){
        
    }

    public Contact(long contactID, String contactName, String contactTitle, String contactMessage, Timestamp date) {
        this.contactID = contactID;
        this.contactName = contactName;
        this.contactTitle = contactTitle;
        this.contactMessage = contactMessage;
        this.date = date;
    }

}
