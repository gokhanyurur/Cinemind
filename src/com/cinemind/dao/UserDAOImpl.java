package com.cinemind.dao;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cinemind.entity.Favorites_list;
import com.cinemind.entity.Movie_reviews;
import com.cinemind.entity.Reminder_list;
import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;
import com.cinemind.entity.Watchlist;

@Repository
public class UserDAOImpl implements UserDAO{

	//it was private
	@Autowired
	public SessionFactory sessionFactory;
	
	@Override
	public void saveUser(Users theUser) {	
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(theUser);
	}

	@Override
	public Users getUser(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users tempUser = currentSession.get(Users.class, theId);
		return tempUser;
	}
	
	@Override
	public Users getUser(String userName) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("from Users where username=:userName");
		theQuery.setParameter("userName", userName);
		Users tempUser = (Users) theQuery.uniqueResult();
		System.out.println("Found user "+tempUser.getUsername());
		return tempUser;
	}

	@Override
	public void deleteUser(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("delete from Users where id=:userId");
		theQuery.setParameter("userId", theId);
		theQuery.executeUpdate();	
	}

	@Override
	public boolean checkLogin(String email, String password) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select 1 from Users where email=:userEmail AND password=:userPass");
		theQuery.setParameter("userEmail", email);
		theQuery.setParameter("userPass", password);
		return (theQuery.uniqueResult() != null);
	}

	@Override
	public boolean checkUsername(String username) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select 1 from Users where username=:userName");
		theQuery.setParameter("userName", username);
		return (theQuery.uniqueResult() != null);
	}

	@Override
	public int getUserIdByLogin(String email, String password) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select id from Users where email=:userEmail AND password=:userPass");
		theQuery.setParameter("userEmail", email);
		theQuery.setParameter("userPass", password);
		int id = (int) theQuery.uniqueResult();
		System.out.println("User id is "+id);
		return id;
	}
	
	@Override
	public String getUsernameByLogin(String email, String password) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select username from Users where email=:userEmail AND password=:userPass");
		theQuery.setParameter("userEmail", email);
		theQuery.setParameter("userPass", password);
		String username = (String) theQuery.uniqueResult();
		System.out.println("Username is "+username);
		return username;

	}

	@Override
	public void saveActivity(User_activities activity) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users tempUser = currentSession.get(Users.class, activity.getUser().getId());
		tempUser.addActivitiy(activity);
		currentSession.saveOrUpdate(tempUser);
		
	}

	@Override
	public void addFavorites(Favorites_list movie) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users tempUser = currentSession.get(Users.class, movie.getUser().getId());
		tempUser.addToFavorites(movie);
		currentSession.saveOrUpdate(tempUser);
	}
	@Override
	public void removeFavorites(Favorites_list movie) {
		Session currentSession = sessionFactory.getCurrentSession();
				
		Users tempUser = currentSession.get(Users.class, movie.getUser().getId());		
		Favorites_list orgListObj = getFavoritesListObj(tempUser.getFavoriteMovies(),movie.getShow_id());
		
		tempUser.removeFromFavorites(movie);	
		currentSession.remove(orgListObj);

	}
	private Favorites_list getFavoritesListObj(List<Favorites_list> list,int show_id) {
		for(Favorites_list obj: list) {
			if(obj.getShow_id()==show_id) {
				return obj;
			}
		}
		return null;
	}

	@Override
	public void addReminder(Reminder_list movie) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users tempUser = currentSession.get(Users.class, movie.getUser().getId());
		tempUser.addToReminder(movie);
		currentSession.saveOrUpdate(tempUser);
	}
	@Override
	public void removeReminder(Reminder_list movie) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		/*Users tempUser = currentSession.get(Users.class, movie.getUser().getId());
		tempUser.removeFromReminder(movie);
		Query theQuery=currentSession.createQuery("delete from Reminder_list where user_id=:userID AND show_id=:showID");
		theQuery.setParameter("userID", tempUser.getId());
		theQuery.setParameter("showID", movie.getShow_id());
		theQuery.executeUpdate();*/
		
		Users tempUser = currentSession.get(Users.class, movie.getUser().getId());		
		Reminder_list orgListObj = getReminderListObj(tempUser.getReminderMovies(),movie.getShow_id());
		tempUser.removeFromReminder(movie);	
		currentSession.remove(orgListObj);

	}

	private Reminder_list getReminderListObj(List<Reminder_list> list,int show_id) {
		for(Reminder_list obj: list) {
			if(obj.getShow_id()==show_id) {
				return obj;
			}
		}
		return null;
	}

	@Override
	public void addWatchlist(Watchlist movie) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users tempUser = currentSession.get(Users.class, movie.getUser().getId());
		tempUser.addToWatchlist(movie);
		currentSession.saveOrUpdate(tempUser);
	}
	@Override
	public void removeWatchlist(Watchlist movie) {
		Session currentSession = sessionFactory.getCurrentSession();
				
		Users tempUser = currentSession.get(Users.class, movie.getUser().getId());		
		Watchlist orgListObj = getWatchlistObj(tempUser.getWatchlistMovies(),movie.getShow_id());
		
		tempUser.removeFromWatchlist(movie);	
		currentSession.remove(orgListObj);

	}
	private Watchlist getWatchlistObj(List<Watchlist> list,int show_id) {
		for(Watchlist obj: list) {
			if(obj.getShow_id()==show_id) {
				return obj;
			}
		}
		return null;
	}

	@Override
	public void addReview(Movie_reviews review) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users tempUser = currentSession.get(Users.class, review.getUser().getId());
		tempUser.addToReviews(review);
		currentSession.saveOrUpdate(tempUser);
	}

	@Override
	public void removeReview(Movie_reviews review) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Users tempUser = currentSession.get(Users.class, review.getUser().getId());		
		Movie_reviews orgListObj = getReviewObj(tempUser.getMovie_reviews(),review.getMovie_id());
		
		tempUser.removeReview(review);
		currentSession.remove(orgListObj);
	}
	private Movie_reviews getReviewObj(List<Movie_reviews> list,int movie_id) {
		for(Movie_reviews obj: list) {
			if(obj.getMovie_id()==movie_id) {
				return obj;
			}
		}
		return null;
	}

}
