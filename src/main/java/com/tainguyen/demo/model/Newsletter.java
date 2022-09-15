package com.tainguyen.demo.model;

import java.sql.Timestamp;

public class Newsletter {
    private long newsletterID;
    private String newsletterName;
    private Timestamp date;
    
    public Newsletter(){
        
    }

    public Newsletter(long newsletterID, String newsletterName, Timestamp date) {
        this.newsletterID = newsletterID;
        this.newsletterName = newsletterName;
        this.date = date;
    }

    public long getNewsletterID() {
        return newsletterID;
    }

    public void setNewsletterID(long newsletterID) {
        this.newsletterID = newsletterID;
    }

    public String getNewsletterName() {
        return newsletterName;
    }

    public void setNewsletterName(String newsletterName) {
        this.newsletterName = newsletterName;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }
    
}
