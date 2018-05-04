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

	@Override
	public double getVoteAverage(int movieId) {
		Session currentSession = userDAOImpl.sessionFactory.getCurrentSession();
		
		Query query = currentSession.createQuery("select avg(review.vote) FROM Movie_reviews review where review.movie_id=:movieID");
		query.setParameter("movieID", movieId);
		Double avg = (Double) query.uniqueResult();
		if(avg == null) {
			avg = 0.0;
		}
		return avg;
	}

	@Override
	public Long getVoteCount(int movieId) {
		Session currentSession = userDAOImpl.sessionFactory.getCurrentSession();
		
		Query query = currentSession.createQuery("select count(*) from Movie_reviews review where review.movie_id=:movieID");
		query.setParameter("movieID", movieId);
		Long count = (Long)query.uniqueResult();
		if(count == null) {
			count = Long.parseLong(String.valueOf(0));
		}
		return count;
	}
	
	

}
