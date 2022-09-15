package com.tainguyen.demo.model;

public class Category {
 
    private long categoryID;
    private String categoryName;
    private String categoryImage;

    public Category() {
    }
 
    public Category(long categoryID, String categoryName, String categoryImage) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.categoryImage = categoryImage;
    }

    public String getCategoryImage() {
        return categoryImage;
    }

    public void setCategoryImage(String categoryImage) {
        this.categoryImage = categoryImage;
    }

    public long getCategoryID() {
        return categoryID;
    }
 
    public void setCategoryID(long categoryID) {
        this.categoryID = categoryID;
    }
 
    public String getCategoryName() {
        return categoryName;
    }
 
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    
}
