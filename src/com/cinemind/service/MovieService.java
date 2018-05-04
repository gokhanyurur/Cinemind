package com.cinemind.service;

import java.util.List;

import com.cinemind.entity.Movie_reviews;

public interface MovieService {

	public List<Movie_reviews> getMovieReviews(int movieId);
	
	public double getVoteAverage(int movieId);
	
	public Long getVoteCount(int movieId);
}
