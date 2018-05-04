package com.cinemind.dao;

import com.cinemind.entity.Favorites_list;
import com.cinemind.entity.Movie_reviews;
import com.cinemind.entity.Reminder_list;
import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;
import com.cinemind.entity.Watchlist;

public interface UserDAO {
	
	public void saveUser(Users theUser);

	public Users getUser(int theId);
	
	public Users getUser(String userName);

	public void deleteUser(int theId);

	public boolean checkLogin(String email, String password);

	public boolean checkUsername(String username);

	public int getUserIdByLogin(String email, String password);

	public String getUsernameByLogin(String email, String password);

	public void saveActivity(User_activities activity);

	public void addFavorites(Favorites_list movie);
	public void removeFavorites(Favorites_list movie);

	public void addReminder(Reminder_list movie);
	public void removeReminder(Reminder_list movie);

	public void addWatchlist(Watchlist movie);
	public void removeWatchlist(Watchlist movie);

	public void addReview(Movie_reviews review);
	public void removeReview(Movie_reviews review);

}
