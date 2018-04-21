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
@Table(name="reminder_list")
public class Reminder_list {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@ManyToOne(cascade= {CascadeType.DETACH,CascadeType.MERGE,CascadeType.PERSIST,CascadeType.REFRESH})
	@JoinColumn(name="user_id")
	private Users user;
	
	@Column(name="show_id")
	private int show_id;
	
	@Column(name="added_at")
	@CreationTimestamp
	protected Date added_at;
	
	public Reminder_list() {
		
	}
	
	public Reminder_list(int show_id) {
		this.show_id=show_id;
	}
	
	public Reminder_list(Users user, int show_id) {
		this.user=user;
		this.show_id=show_id;
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

	public int getShow_id() {
		return show_id;
	}

	public void setShow_id(int show_id) {
		this.show_id = show_id;
	}

	public Date getAdded_at() {
		return added_at;
	}

	public void setAdded_at(Date added_at) {
		this.added_at = added_at;
	}

	@Override
	public String toString() {
		return "Reminder_list [id=" + id + ", user_id=" + user.getId() + ", show_id=" + show_id + ", added_at=" + added_at + "]";
	}
	
	
}
