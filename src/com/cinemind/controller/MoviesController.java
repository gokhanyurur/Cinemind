package com.cinemind.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cinemind.entity.Users;
import com.cinemind.json.JsonProcess;
import com.cinemind.objects.GenreObj;
import com.cinemind.objects.MovieObj;

import org.springframework.ui.Model;

@Controller
public class MoviesController {
	
	@GetMapping("/movies")
	public String movies(Model theModel, @RequestParam(required=false, value="page") String page) throws IOException, JSONException {
		
		List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		if(page !=null) {
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254&sort_by=release_date.asc&page="+page);
			theModel.addAttribute("movieList", movieList);
		}else {
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254&sort_by=release_date.asc&page=1");
			theModel.addAttribute("movieList", movieList);
		}
		
		int totalPages = JsonProcess.getTotalPage("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254&sort_by=release_date.asc");
		theModel.addAttribute("totalPages",totalPages);
		
		return "movies";
	}
		
	@GetMapping("movies/genre/{genreName}")
	public String GenreMovies(Model theModel,@PathVariable String genreName, @RequestParam(required=false, value="page") String page) throws JSONException, IOException {
		
		int genreId = 0;
		String genreTitle = "";
		
		List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		for(GenreObj obj: genreList) {
			String tempTitle = obj.getTitle().toLowerCase().replace(" ", "");
			if(tempTitle.equals(genreName)) {
				genreId = obj.getId();
				genreTitle = obj.getTitle();
			}
		}
		
		if(page !=null) {
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/genre/"+genreId+"/movies?api_key=a092bd16da64915723b2521295da3254&page="+page);
			theModel.addAttribute("genreMoviesList", movieList);
		}else {
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/genre/"+genreId+"/movies?api_key=a092bd16da64915723b2521295da3254&page=1");
			theModel.addAttribute("genreMoviesList", movieList);
		}
		
		int totalPages = JsonProcess.getTotalPage("https://api.themoviedb.org/3/genre/"+genreId+"/movies?api_key=a092bd16da64915723b2521295da3254");
		theModel.addAttribute("totalPages",totalPages);		
		theModel.addAttribute("genreTitle",genreTitle);
		
		return "genre-movie";
		
	}
	
	@GetMapping("movies/release/{releaseYear}")
	public String releaseYearMovies(Model theModel,@PathVariable String releaseYear, @RequestParam(required=false, value="genreId") String genreId, @RequestParam(required=false, value="page") String page) throws JSONException, IOException {
		
		int	totalPages = 1;
		String currentLink = "";
		
		List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
				
		if(genreId !=null) {
			if(page != null) {
				//page - genre
				currentLink = "http://api.themoviedb.org/3/discover/movie?with_genres="+genreId+"&primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254&page="+page;
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}else {
				//no page - genre
				currentLink = "http://api.themoviedb.org/3/discover/movie?with_genres="+genreId+"&primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254";
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}
		}else {
			if(page != null) {
				//no genre - page
				currentLink = "http://api.themoviedb.org/3/discover/movie?primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254&page"+page;
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}else {
				//no genre - no page
				currentLink = "http://api.themoviedb.org/3/discover/movie?primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254";
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}
		}
		
		if(page != null ) {
			if(genreId != null) {
				//page - genre
				currentLink = "http://api.themoviedb.org/3/discover/movie?with_genres="+genreId+"&primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254&page="+page;
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}else {
				//page - no genre
				currentLink = "http://api.themoviedb.org/3/discover/movie?primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254&page="+page;
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}
		}else {
			if(genreId != null) {
				//no page - genre
				currentLink = "http://api.themoviedb.org/3/discover/movie?with_genres="+genreId+"&primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254";
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}else {
				//no page - no genre
				currentLink = "http://api.themoviedb.org/3/discover/movie?primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254";
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("releaseYearMovieList", movieList);
			}
		}
		
		totalPages = JsonProcess.getTotalPage(currentLink);
		theModel.addAttribute("totalPages",totalPages);
		
		theModel.addAttribute("releaseYear",releaseYear);
		
		return "releaseYear-movie";
		
	}


	
	
}
