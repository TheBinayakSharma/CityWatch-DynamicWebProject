// com/citywatch/model/Organization.java
package com.citywatch.model;

public class Organization {
    private int id;
    private int userId;
    private String orgName;
    private String orgType;
    private String address;

    // For joined queries — not stored in organizations table
    private String username;
    private String email;
    private String phone;
    private String fullName;

    public Organization() {}

    // Getters & Setters
    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }

    public int getUserId()                  { return userId; }
    public void setUserId(int userId)       { this.userId = userId; }

    public String getOrgName()              { return orgName; }
    public void setOrgName(String orgName)  { this.orgName = orgName; }

    public String getOrgType()              { return orgType; }
    public void setOrgType(String orgType)  { this.orgType = orgType; }

    public String getAddress()              { return address; }
    public void setAddress(String address)  { this.address = address; }

    public String getUsername()             { return username; }
    public void setUsername(String u)       { this.username = u; }

    public String getEmail()                { return email; }
    public void setEmail(String e)          { this.email = e; }

    public String getPhone()                { return phone; }
    public void setPhone(String p)          { this.phone = p; }

    public String getFullName()             { return fullName; }
    public void setFullName(String n)       { this.fullName = n; }
}