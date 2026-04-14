// com/citywatch/model/Civilian.java
package com.citywatch.model;

public class Civilian {
    private int id;
    private int userId;
    private String address;
    private int wardNo;

    // For joined queries
    private String username;
    private String email;
    private String phone;
    private String fullName;

    public Civilian() {}

    public int getId()                      { return id; }
    public void setId(int id)               { this.id = id; }

    public int getUserId()                  { return userId; }
    public void setUserId(int userId)       { this.userId = userId; }

    public String getAddress()              { return address; }
    public void setAddress(String address)  { this.address = address; }

    public int getWardNo()                  { return wardNo; }
    public void setWardNo(int wardNo)       { this.wardNo = wardNo; }

    public String getUsername()             { return username; }
    public void setUsername(String u)       { this.username = u; }

    public String getEmail()                { return email; }
    public void setEmail(String e)          { this.email = e; }

    public String getPhone()                { return phone; }
    public void setPhone(String p)          { this.phone = p; }

    public String getFullName()             { return fullName; }
    public void setFullName(String n)       { this.fullName = n; }
}