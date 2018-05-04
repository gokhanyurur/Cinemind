package com.cinemind.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cinemind.controller.UserController;
import com.cinemind.entity.Movie_reviews;

@Service
public class MovieDAOImpl implements MovieDAO{
	
	@Autowired
	private UserDAOImpl userDAOImpl;
	
	@Override
	public List<Movie_reviews> getMovieReviews(int movieId) {
		Session currentSession = userDAOImpl.sessionFactory.getCurrentSession();
		
		Query<Movie_reviews> theQuery=currentSession.createQuery("from Movie_reviews where movie_id=:movieId");
		theQuery.setParameter("movieId", movieId);
		
		List<Movie_reviews> tempList = theQuery.list();
		
		return tempList;
	}
	
	

}
