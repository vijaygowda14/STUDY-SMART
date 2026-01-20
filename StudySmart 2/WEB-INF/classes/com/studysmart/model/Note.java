package com.studysmart.model;

import java.io.Serializable;

public class Note implements Serializable {
    private String id;
    private String title;
    private String content;
    private String createdAt;
    private String imagePath; // Relative path related to webapp root

    public Note() {
    }

    public Note(String id, String title, String content, String createdAt, String imagePath) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
        this.imagePath = imagePath;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
