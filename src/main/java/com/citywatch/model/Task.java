// com/citywatch/model/Task.java
package com.citywatch.model;

import java.sql.Timestamp;

public class Task {
    private int id;
    private String title;
    private String description;
    private String status;          // AVAILABLE | IN_PROGRESS | COMPLETED
    private Integer assignedOrg;    // nullable
    private int createdBy;
    private Timestamp createdAt;
    private Timestamp completedAt;  // nullable

    // Joined field — org name for display
    private String assignedOrgName;

    public Task() {}

    public int getId()                           { return id; }
    public void setId(int id)                    { this.id = id; }

    public String getTitle()                     { return title; }
    public void setTitle(String title)           { this.title = title; }

    public String getDescription()               { return description; }
    public void setDescription(String d)         { this.description = d; }

    public String getStatus()                    { return status; }
    public void setStatus(String status)         { this.status = status; }

    public Integer getAssignedOrg()              { return assignedOrg; }
    public void setAssignedOrg(Integer org)      { this.assignedOrg = org; }

    public int getCreatedBy()                    { return createdBy; }
    public void setCreatedBy(int createdBy)      { this.createdBy = createdBy; }

    public Timestamp getCreatedAt()              { return createdAt; }
    public void setCreatedAt(Timestamp t)        { this.createdAt = t; }

    public Timestamp getCompletedAt()            { return completedAt; }
    public void setCompletedAt(Timestamp t)      { this.completedAt = t; }

    public String getAssignedOrgName()           { return assignedOrgName; }
    public void setAssignedOrgName(String name)  { this.assignedOrgName = name; }
}