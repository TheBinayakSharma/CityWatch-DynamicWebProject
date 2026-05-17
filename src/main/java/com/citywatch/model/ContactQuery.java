package com.citywatch.model;

import java.sql.Timestamp;

public class ContactQuery {
    private int id;
    private String name;
    private String phoneNumber;
    private String queryText;
    private String status;
    private Timestamp createdAt;

    public ContactQuery() {
    }

    public ContactQuery(String name, String phoneNumber, String queryText) {
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.queryText = queryText;
        this.status = "PENDING";
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

    public String getQueryText() { return queryText; }
    public void setQueryText(String queryText) { this.queryText = queryText; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
