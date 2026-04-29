package com.election.model;

public class Student {
    private String sicNumber;
    private String email;
    private String section;
    private int year;
    private String password;

    public Student() {}
    
    public Student(String sicNumber, String email, String section, int year, String password) {
        this.sicNumber = sicNumber;
        this.email = email;
        this.section = section;
        this.year = year;
        this.password = password;
    }

    public String getSicNumber() { return sicNumber; }
    public void setSicNumber(String sicNumber) { this.sicNumber = sicNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }
    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}