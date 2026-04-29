package com.election.model;

public class Candidate {
    private int id;
    private int electionId;
    private String sicNumber;
    private String name;
    private String description;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getElectionId() { return electionId; }
    public void setElectionId(int electionId) { this.electionId = electionId; }
    public String getSicNumber() { return sicNumber; }
    public void setSicNumber(String sicNumber) { this.sicNumber = sicNumber; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}