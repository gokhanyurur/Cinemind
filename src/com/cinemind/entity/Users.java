package com.cinemind.entity;

import java.io.IOException;
import java.util.ArrayList;
/*import java.text.ParseException;
import java.text.SimpleDateFormat;*/
import java.util.Date;
import java.util.List;
import java.util.Iterator;

import javax.persistence.*;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.json.JSONException;

import com.cinemind.json.JsonProcess;
import com.cinemind.objects.MovieObj;

@Entity
@Table(name="users")
public class Users {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="username")
	private String username;
	
	@Column(name="password")
	private String password;

	@Transient
	private String passwordConf;
	
	@Transient
	private String newPass;
	
	@Transient
	private String newPassConf;	
	
	@Column(name="email")
	private String email;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	@Column(name="location")
	private String location;
	
	@Column(name="bio")
	private String bio;
	
	@Column(name="created_at")
	@CreationTimestamp
	protected Date createdAt;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private List<User_activities> activities;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private List<Favorites_list> favoriteMovies;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private List<Reminder_list> reminderMovies;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private List<Watchlist> watchlistMovies;
	
	@LazyCollection(LazyCollectionOption.FALSE)
	@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
	private List<Movie_reviews> movie_reviews;

	public Users() {
		
	}
	
	public Users(String username, String password, String email) {
		this.username = username;
		this.password = password;
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}
	
	public String getPasswordConf() {
		return passwordConf;
	}

	public void setPasswordConf(String passwordConf) {
		this.passwordConf = passwordConf;
	}
	
	public List<User_activities> getActivities() {
		return activities;
	}

	public void setActivities(List<User_activities> activities) {
		this.activities = activities;
	}
	
	public void addActivitiy(User_activities activity) {
		if(activities == null) {
			activities = new ArrayList<>();
		}
		activities.add(activity);
		
		activity.setUser(this);	
	}
	
	
	public List<Favorites_list> getFavoriteMovies() {
		return favoriteMovies;
	}

	public void setFavoriteMovies(List<Favorites_list> favoriteMovies) {
		this.favoriteMovies = favoriteMovies;
	}
	
	public void addToFavorites(Favorites_list favorite) {
		if(favoriteMovies == null) {
			favoriteMovies = new ArrayList<>();
		}
		favoriteMovies.add(favorite);
		
		favorite.setUser(this);	
	}
	
	public void removeFromFavorites(Favorites_list favoriteMovie) {	
		
		Iterator<Favorites_list> iter = favoriteMovies.iterator();
		while(iter.hasNext()) {
			Favorites_list currentObj = iter.next();
			if(currentObj.getShow_id() == favoriteMovie.getShow_id()) {
				iter.remove();
			}
		}
			
	}
	
	public List<Reminder_list> getReminderMovies() {
		return reminderMovies;
	}

	public void setReminderMovies(List<Reminder_list> reminderMovies) {
		this.reminderMovies = reminderMovies;
	}
	
	public void addToReminder(Reminder_list reminderMovie) {
		if(reminderMovies == null) {
			reminderMovies = new ArrayList<>();
		}
		reminderMovies.add(reminderMovie);
		
		reminderMovie.setUser(this);	
	}
	
	public void removeFromReminder(Reminder_list reminderMovie) {	
		
		Iterator<Reminder_list> iter = reminderMovies.iterator();
		while(iter.hasNext()) {
			Reminder_list currentObj = iter.next();
			if(currentObj.getShow_id() == reminderMovie.getShow_id()) {
				iter.remove();
			}
		}
			
	}

	public List<Watchlist> getWatchlistMovies() {
		return watchlistMovies;
	}

	public void setWatchlistMovies(List<Watchlist> watchlistMovies) {
		this.watchlistMovies = watchlistMovies;
	}
	
	public void addToWatchlist(Watchlist watchlistMovie){
		if(watchlistMovies == null) {
			watchlistMovies = new ArrayList<>();
		}
		watchlistMovies.add(watchlistMovie);		
		watchlistMovie.setUser(this);	
	}
		
	public void removeFromWatchlist(Watchlist watchlistMovie) {	
		
		Iterator<Watchlist> iter = watchlistMovies.iterator();
		while(iter.hasNext()) {
			Watchlist currentObj = iter.next();
			if(currentObj.getShow_id() == watchlistMovie.getShow_id()) {
				iter.remove();
			}
		}
			
	}
		
	public List<Movie_reviews> getMovie_reviews() {
		return movie_reviews;
	}

	public void setMovie_reviews(List<Movie_reviews> movie_reviews) {
		this.movie_reviews = movie_reviews;
	}
	
	public void addToReviews(Movie_reviews review) {
		if(movie_reviews == null) {
			movie_reviews = new ArrayList<>();
		}
		movie_reviews.add(review);		
		review.setUser(this);
	}
	
	public void removeReview(int reviewId) {
		Iterator<Movie_reviews> iter = movie_reviews.iterator();
		while(iter.hasNext()) {
			Movie_reviews currentObj = iter.next();
			if(currentObj.getId() == reviewId) {
				iter.remove();
			}
		}
	}

	public boolean watchlistContain(int movieId) {
		boolean result = false;
		
		for(Watchlist item : watchlistMovies) {
			if(item.getId() == movieId) {
				result=true;
			}
		}		
		return result;
	}
	
	

	public String getNewPass() {
		return newPass;
	}

	public void setNewPass(String newPass) {
		this.newPass = newPass;
	}

	public String getNewPassConf() {
		return newPassConf;
	}

	public void setNewPassConf(String newPassConf) {
		this.newPassConf = newPassConf;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", email=" + email
				+ ", firstName=" + firstName + ", lastName=" + lastName + ", location=" + location + ", bio=" + bio
				+ ", createdAt=" + createdAt + "]";
	}

		
}
