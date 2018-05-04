package com.cinemind.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cinemind.dao.MovieDAO;
import com.cinemind.entity.Movie_reviews;

@Service
public class MovieServiceImpl implements MovieService{

	@Autowired
	private MovieDAO movieDAO;
	
	@Override
	@Transactional
	public List<Movie_reviews> getMovieReviews(int movieId) {
		return movieDAO.getMovieReviews(movieId);
	}

	@Override
	@Transactional
	public double getVoteAverage(int movieId) {
		return movieDAO.getVoteAverage(movieId);
	}

	@Override
	@Transactional
	public Long getVoteCount(int movieId) {
		return movieDAO.getVoteCount(movieId);
	}

}
