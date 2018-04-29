package com.cinemind.objects;

public class Notification {

	private String movieTitle;
	private String bodyText;
	private String dayLeft;
	private int movieId;
	
	public Notification() {
		
	}
	
	
	public Notification(int movieId, String movieTitle, String bodyText, String dayLeft) {
		this.movieId = movieId;
		this.movieTitle = movieTitle;
		this.bodyText = bodyText;
		this.dayLeft = dayLeft;
	}
	
	public Notification(int movieId, String movieTitle, String bodyText) {
		this.movieId = movieId;
		this.movieTitle = movieTitle;
		this.bodyText = bodyText;
	}
	
	public Notification(String bodyText) {
		this.bodyText = bodyText;
	}

	public String getMovieTitle() {
		return movieTitle;
	}
	public void setMovieTitle(String movieTitle) {
		this.movieTitle = movieTitle;
	}
	public String getBodyText() {
		return bodyText;
	}
	public void setBodyText(String bodyText) {
		this.bodyText = bodyText;
	}
	public String getDayLeft() {
		return dayLeft;
	}
	public void setDayLeft(String dayLeft) {
		this.dayLeft = dayLeft;
	}

	public int getMovieId() {
		return movieId;
	}


	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}
	
	
	
	
}
