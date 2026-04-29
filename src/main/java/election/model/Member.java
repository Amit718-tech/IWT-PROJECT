package com.election.model;

public class Member {
    private String sicNumber;
    private String password;
    private String name;
    private String role;

    public Member() {}
    
    public Member(String sicNumber, String password, String name, String role) {
        this.sicNumber = sicNumber;
        this.password = password;
        this.name = name;
        this.role = role;
    }

    public String getSicNumber() { return sicNumber; }
    public void setSicNumber(String sicNumber) { this.sicNumber = sicNumber; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}