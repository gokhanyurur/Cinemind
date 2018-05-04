package com.cinemind.entity;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

@Entity
@Table(name="movie_reviews")
public class Movie_reviews {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@ManyToOne(cascade= {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinColumn(name="user_id")
	private Users user;
	
	@Column(name="movie_id")
	private int movie_id;
	
	@Column(name="review")
	private String review;
	
	@Column(name="vote")
	private int vote;
	
	@Column(name="reviewed_at")
	@CreationTimestamp
	protected Date reviewed_at;
	
	public Movie_reviews() {
		
	}

	public Movie_reviews(Users user, int movie_id, String review, int vote) {
		this.user = user;
		this.movie_id = movie_id;
		this.review = review;
		this.vote = vote;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

	public int getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}

	public String getReview() {
		return review;
	}

	public void setReview(String review) {
		this.review = review;
	}

	public int getVote() {
		return vote;
	}

	public void setVote(int vote) {
		this.vote = vote;
	}

	public Date getReviewed_at() {
		return reviewed_at;
	}

	public void setReviewed_at(Date reviewed_at) {
		this.reviewed_at = reviewed_at;
	}

	@Override
	public String toString() {
		return "Movie_reviews [id=" + id + ", user=" + user + ", movie_id=" + movie_id + ", review=" + review
				+ ", vote=" + vote + ", reviewed_at=" + reviewed_at + "]";
	}
	
	
	
	
	
	

}
