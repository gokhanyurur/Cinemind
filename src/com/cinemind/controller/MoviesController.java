package com.cinemind.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cinemind.json.JsonProcess;
import com.cinemind.objects.genreObj;
import com.cinemind.objects.movieObj;

import org.springframework.ui.Model;

@Controller
public class MoviesController {
	
	@GetMapping("/movies")
	public String movies(Model theModel) throws IOException, JSONException {
		
		List<movieObj> movieList = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254&sort_by=release_date.asc&page=1");
		theModel.addAttribute("movieList", movieList);
		
		List<genreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		return "movies";
	}
	
	@GetMapping("movies/genres")
	public String GenreMovies() {
		return "genre-movie";
	}
	
	@GetMapping("movies/viewMovie")
	public String viewMovie(@RequestParam("movieId")int movieId, Model theModel) throws JSONException, IOException {
		
		movieObj tempMovie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+movieId+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
		theModel.addAttribute("movie",tempMovie);
		
		List<genreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		return "view-movie";
	}
}
