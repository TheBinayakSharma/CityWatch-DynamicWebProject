// com/citywatch/model/Notice.java
package com.citywatch.model;

import java.sql.Timestamp;

public class Notice {
    private int id;
    private String title;
    private String description;
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Notice() {}

    public int getId()                          { return id; }
    public void setId(int id)                   { this.id = id; }

    public String getTitle()                    { return title; }
    public void setTitle(String title)          { this.title = title; }

    public String getDescription()              { return description; }
    public void setDescription(String d)        { this.description = d; }

    public int getCreatedBy()                   { return createdBy; }
    public void setCreatedBy(int createdBy)     { this.createdBy = createdBy; }

    public Timestamp getCreatedAt()             { return createdAt; }
    public void setCreatedAt(Timestamp t)       { this.createdAt = t; }

    public Timestamp getUpdatedAt()             { return updatedAt; }
    public void setUpdatedAt(Timestamp t)       { this.updatedAt = t; }
}