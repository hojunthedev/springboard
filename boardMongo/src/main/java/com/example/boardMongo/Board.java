package com.example.boardMongo;

public class Board {
	private String id;
	private String title;
	private String contentes;
	private String date;
	private String fname;
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
	public String getContentes() {
		return contentes;
	}
	public void setContents(String contentes) {
		this.contentes = contentes;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	
}
