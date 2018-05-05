package com.cinemind.controller;

import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cinemind.entity.Favorites_list;
import com.cinemind.entity.Movie_reviews;
import com.cinemind.entity.Reminder_list;
import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;
import com.cinemind.entity.Watchlist;
import com.cinemind.json.JsonProcess;
import com.cinemind.objects.GenreObj;
import com.cinemind.objects.MovieObj;
import com.cinemind.objects.Notification;
import com.cinemind.service.MovieService;
import com.cinemind.service.UserService;

import org.springframework.ui.Model;

@Controller
public class MoviesController {
	
	@Autowired
	private UserController userController;
	
	@Autowired
	private MovieService movieService;
	
	@GetMapping("/movies")
	public String movies(Model theModel, HttpSession loginSession,@RequestParam(required=false, value="page") String page) throws IOException, JSONException {
		
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
		
		if(loginSession.getAttribute("loginedUser") != null) {
			Users loginedUser = (Users)loginSession.getAttribute("loginedUser");
			Users tempUser = userController.userService.getUser(loginedUser.getId());
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = userController.pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
		}
		
		return "movies";
	}
	
	@GetMapping("movies/viewMovie")
	public String viewMovie(@RequestParam("movieId")int movieId, Model theModel, HttpSession loginSession,
			@RequestParam(required=false, value="addList") String addList) throws JSONException, IOException {
		
		//MOVIE WILL BE SHOWN
		MovieObj tempMovie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+movieId+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
		theModel.addAttribute("movie",tempMovie);
		
		System.out.println("Day Left "+tempMovie.getDayLeft());
		
		//GENRE LIST
		List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		Users loginedUser = new Users();;
		Users tempUser = new Users();
		
		Movie_reviews review = new Movie_reviews();
		
		if(loginSession.getAttribute("loginedUser") !=null) {
			loginedUser = (Users) loginSession.getAttribute("loginedUser");		
			tempUser = userController.userService.getUser(loginedUser.getId());
			
			//ADD REMOVE TO THE LIST
			if(addList !=null) {
				if(addList.equals("favorites") && !userController.isFavoritesListContain(tempUser, movieId)) {
					userController.userService.addFavorites(new Favorites_list(tempUser,movieId));
					userController.userService.saveActivity(new User_activities(tempUser,"added to the favorites "+tempMovie.getTitle()));
				}
				if(addList.equals("watchlist") && !userController.isWatchlistContain(tempUser, movieId)) {
					userController.userService.addWatchlist(new Watchlist(tempUser,movieId));
					userController.userService.saveActivity(new User_activities(tempUser,"added to the watchlist "+tempMovie.getTitle()));
				}
				if(addList.equals("reminder") && !userController.isReminderListContain(tempUser, movieId)) {
					userController.userService.addReminder(new Reminder_list(tempUser,movieId));
					userController.userService.saveActivity(new User_activities(tempUser,"added to the reminder list "+tempMovie.getTitle()));
				}
				
				if(addList.equals("removeFavorites")) {
					userController.userService.removeFavorites(new Favorites_list(tempUser,movieId));
					userController.userService.saveActivity(new User_activities(tempUser,"removed from the favorites "+tempMovie.getTitle()));
				}
				if(addList.equals("removeWatchlist")) {
					userController.userService.removeWatchlist(new Watchlist(tempUser,movieId));
					userController.userService.saveActivity(new User_activities(tempUser,"removed from the watchlist "+tempMovie.getTitle()));
				}
				if(addList.equals("removeReminder")) {
					userController.userService.removeReminder(new Reminder_list(tempUser,movieId));
					userController.userService.saveActivity(new User_activities(tempUser,"removed from the reminder list "+tempMovie.getTitle()));
				}
				return "redirect:/movies/viewMovie?movieId="+tempMovie.getId();
			}
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = userController.pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
			
			theModel.addAttribute("userWatchList",tempUser.getWatchlistMovies());
			theModel.addAttribute("userFavList",tempUser.getFavoriteMovies());
			theModel.addAttribute("userReminderList",tempUser.getReminderMovies());
						
			review.setVote(5);
			review.setMovie_id(movieId);
			
			theModel.addAttribute("userReview", review);
		}
		
		List<Movie_reviews> tempReviews= movieService.getMovieReviews(movieId);
		theModel.addAttribute("reviewList",tempReviews);
		
		Long voteCount = movieService.getVoteCount(movieId);
		theModel.addAttribute("voteCount",voteCount);
		
		double voteAvg = movieService.getVoteAverage(movieId);
		voteAvg =Double.parseDouble(new DecimalFormat("##.#").format(voteAvg));
		theModel.addAttribute("voteAvg", voteAvg);
						
		return "view-movie";
	}
	
	@PostMapping("movies/writeReview")
	public String writeReview(HttpSession loginSession,@ModelAttribute("userReview") Movie_reviews review,Model theModel) throws JSONException, IOException {

		Users loginedUser = (Users)loginSession.getAttribute("loginedUser");
		Users tempUser = userController.userService.getUser(loginedUser.getId());
		
		MovieObj tempMovie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+review.getMovie_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");

		
		review.setUser(tempUser);
		
		userController.userService.addReview(review);
		userController.userService.saveActivity(new User_activities(tempUser,"wrote a review for "+tempMovie.getTitle()));
		return "redirect:/movies/viewMovie?movieId="+review.getMovie_id();
	}
	
	@GetMapping("movies/actor/{actorId}")
	public String actorMovies(Model theModel, HttpSession loginSession,
			@PathVariable int actorId, @RequestParam(required=false, value="page") String page) throws JSONException, IOException {
		
		List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		if(page !=null) {
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl("http://api.themoviedb.org/3/discover/movie?with_cast="+actorId+"&api_key=a092bd16da64915723b2521295da3254&page="+page);
			theModel.addAttribute("actorMoviesList", movieList);
		}else {
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl("http://api.themoviedb.org/3/discover/movie?with_cast="+actorId+"&api_key=a092bd16da64915723b2521295da3254&page=1");
			theModel.addAttribute("actorMoviesList", movieList);
		}
		
		int totalPages = JsonProcess.getTotalPage("http://api.themoviedb.org/3/discover/movie?with_cast="+actorId+"&api_key=a092bd16da64915723b2521295da3254&page=1");
		theModel.addAttribute("totalPages",totalPages);
		
		String actorName = JsonProcess.getActorName("https://api.themoviedb.org/3/person/"+actorId+"?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("actorName", actorName);
		theModel.addAttribute("actorId", actorId);
		
		if(loginSession.getAttribute("loginedUser") != null) {
			Users loginedUser = (Users)loginSession.getAttribute("loginedUser");
			Users tempUser = userController.userService.getUser(loginedUser.getId());
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = userController.pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
		}
		
		return "actor-movies";
	}
		
	@GetMapping("movies/genre/{genreName}")
	public String GenreMovies(Model theModel, HttpSession loginSession,
			@PathVariable String genreName, @RequestParam(required=false, value="page") String page) throws JSONException, IOException {
		
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
		
		if(loginSession.getAttribute("loginedUser") != null) {
			Users loginedUser = (Users)loginSession.getAttribute("loginedUser");
			Users tempUser = userController.userService.getUser(loginedUser.getId());
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = userController.pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
		}
		
		return "genre-movie";
		
	}
	
	@GetMapping("movies/release/{releaseYear}")
	public String releaseYearMovies(Model theModel, HttpSession loginSession,
			@PathVariable String releaseYear, 
			@RequestParam(required=false, value="genreId") String genreId, 
			@RequestParam(required=false, value="page") String page,
			@RequestParam(required=false, value="sortBy") String sortBy) throws JSONException, IOException {
		
		int	totalPages = 1;
		String currentLink = "";
		
		List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		if(page == null ) {
			page = "1";
		}
		
		if(sortBy != null) {
			sortBy = "&sort_by="+sortBy;
		}
				
		if(genreId !=null) {
			currentLink = "http://api.themoviedb.org/3/discover/movie?with_genres="+genreId+"&primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254&page="+page+sortBy;
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
			theModel.addAttribute("releaseYearMovieList", movieList);
		}
		else{
			currentLink = "http://api.themoviedb.org/3/discover/movie?primary_release_year="+releaseYear+"&api_key=a092bd16da64915723b2521295da3254&page"+page+sortBy;
			List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
			theModel.addAttribute("releaseYearMovieList", movieList);
		}
				
		totalPages = JsonProcess.getTotalPage(currentLink);
		theModel.addAttribute("totalPages",totalPages);
		
		theModel.addAttribute("releaseYear",releaseYear);
		
		if(loginSession.getAttribute("loginedUser") != null) {
			Users loginedUser = (Users)loginSession.getAttribute("loginedUser");
			Users tempUser = userController.userService.getUser(loginedUser.getId());
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = userController.pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
		}
		
		return "releaseYear-movie";
		
	}
	
	@GetMapping("/search")
	public String searchMovie(Model theModel, HttpSession loginSession,
			@RequestParam(required=false, value="q") String query,
			@RequestParam(required=false, value="page") String page) throws IOException, JSONException {
		
		//https://api.themoviedb.org/3/search/movie?api_key=a092bd16da64915723b2521295da3254&query="+searchViewText+"&page="+page
		String currentLink;
		int totalPages = 0;
		
		List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		if(query != null) {
			query = query.replace(" ", "%2B");
			if(page != null) {
				currentLink = "https://api.themoviedb.org/3/search/movie?api_key=a092bd16da64915723b2521295da3254&query="+query+"&page="+page;
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("searchResultList", movieList);
			}else {
				currentLink = "https://api.themoviedb.org/3/search/movie?api_key=a092bd16da64915723b2521295da3254&query="+query;
				List<MovieObj> movieList = JsonProcess.getMoviesFromUrl(currentLink);
				theModel.addAttribute("searchResultList", movieList);
			}
			totalPages = JsonProcess.getTotalPage(currentLink);
			theModel.addAttribute("totalPages",totalPages);
		}		
		
		if(loginSession.getAttribute("loginedUser") != null) {
			Users loginedUser = (Users)loginSession.getAttribute("loginedUser");
			Users tempUser = userController.userService.getUser(loginedUser.getId());
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = userController.pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
		}
		
		return "search";
	}


	
	
}
