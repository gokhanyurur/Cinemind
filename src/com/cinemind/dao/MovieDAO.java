package com.cinemind.dao;

import java.util.List;

import com.cinemind.entity.Movie_reviews;

public interface MovieDAO {

	public List<Movie_reviews> getMovieReviews(int movieId);
	
}
