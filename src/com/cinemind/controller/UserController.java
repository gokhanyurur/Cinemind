package com.cinemind.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cinemind.entity.Favorites_list;
import com.cinemind.entity.Reminder_list;
import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;
import com.cinemind.entity.Watchlist;
import com.cinemind.json.JsonProcess;
import com.cinemind.objects.genreObj;
import com.cinemind.objects.movieObj;
import com.cinemind.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/profile")
	public String userProfile(HttpSession loginSession, Model theModel) throws JSONException, IOException {
		if(loginSession.getAttribute("loginedUser") !=null) {
			
			//GENRE LIST
			List<genreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
			theModel.addAttribute("genreList", genreList);
			
			Users loginedUser = (Users) loginSession.getAttribute("loginedUser");	
			Users tempUser = userService.getUser(loginedUser.getId());
			
			//USER REGISTER TIME
			theModel.addAttribute("userRegTime",tempUser.getCreatedAt().toString());
			
			//REMINDER LIST
			List<movieObj> tempRemList = new ArrayList<movieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				tempRemList.add(JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images"));
			}
			theModel.addAttribute("reminderList",tempRemList);
			
			//WATCHLIST
			List<movieObj> tempWatchlist = new ArrayList<movieObj>();
			for(Watchlist list_obj:tempUser.getWatchlistMovies()) {
				tempWatchlist.add(JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images"));
			}
			theModel.addAttribute("watchList",tempWatchlist);
			
			//FAVORITE LIST
			List<movieObj> tempFavList = new ArrayList<movieObj>();
			for(Favorites_list list_obj:tempUser.getFavoriteMovies()) {
				tempFavList.add(JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images"));
			}
			theModel.addAttribute("favoritesList",tempFavList);
			
			//ACTIVITY LIST
			List<User_activities> tempActivityList = new ArrayList<User_activities>();
			for(User_activities list_obj:tempUser.getActivities()) {
				tempActivityList.add(list_obj);
			}
			theModel.addAttribute("userActivityList",tempActivityList);
								
			return "profile";
		}
		else {
			return "redirect:/login";
		}
	
	}
	
	@PostMapping("/registerUser")
	public String registerUser(@ModelAttribute("user") Users theUser,Model theModel) {
		if((String.valueOf(theUser.getPassword()).equals(String.valueOf(theUser.getPasswordConf()))) && !userService.checkUsername(theUser.getUsername())) {
			userService.saveUser(theUser);
			//userService.saveActivity(new User_activities(userService.getUserIdByLogin(theUser.getEmail(), theUser.getPassword()))," joined to cinemind"));
			Users tempUser = userService.getUser(userService.getUserIdByLogin(theUser.getEmail(), theUser.getPassword()));
			//System.out.println("TEST THE ID is "+ tempUser.getId());
			userService.saveActivity(new User_activities(tempUser,"joined to Cinemind"));
			return "redirect:/";
		}else {
			System.out.println("Username is already exist or passwords are not matching.");
			theModel.addAttribute("registerMessage", "Username is already exist or passwords are not matching.");
			return "redirect:/signup";
		}

	}
	
	@PostMapping("/loginUser")
	public String loginUser(HttpSession loginSession,@ModelAttribute("user") Users theUser,Model theModel) {
		if(userService.checkLogin(theUser.getEmail(),theUser.getPassword())) {
			System.out.println("User Exist");
			theUser.setId(userService.getUserIdByLogin(theUser.getEmail(),theUser.getPassword()));
			theUser.setUsername(userService.getUsernameByLogin(theUser.getEmail(),theUser.getPassword()));
			loginSession.setAttribute("loginedUser", theUser);
			return "redirect:/";
		}else {
			System.out.println("Login failed. Try again.");
			theModel.addAttribute("loginMessage", "Login failed. Try again.");
			return "redirect:/login";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession loginSession) {
		loginSession.invalidate();
		return "redirect:/login";
	}
	
	@GetMapping("movies/viewMovie")
	public String viewMovie(@RequestParam("movieId")int movieId, Model theModel, HttpSession loginSession,
			@RequestParam(required=false, value="addList") String addList) throws JSONException, IOException {
		
		//MOVIE WILL BE SHOWN
		movieObj tempMovie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+movieId+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
		theModel.addAttribute("movie",tempMovie);
		
		System.out.println("Day Left "+tempMovie.getDayLeft());
		
		//GENRE LIST
		List<genreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		Users loginedUser = new Users();;
		Users tempUser = new Users();
		
		if(loginSession.getAttribute("loginedUser") !=null) {
			loginedUser = (Users) loginSession.getAttribute("loginedUser");		
			tempUser = userService.getUser(loginedUser.getId());
		}		
		
		
		//ADD REMOVE TO THE LIST
		if(addList !=null) {
			if(addList.equals("favorites") && !isFavoritesListContain(tempUser, movieId)) {
				userService.addFavorites(new Favorites_list(tempUser,movieId));
				userService.saveActivity(new User_activities(tempUser,"added to the favorites "+tempMovie.getTitle()));
			}
			if(addList.equals("watchlist") && !isWatchlistContain(tempUser, movieId)) {
				userService.addWatchlist(new Watchlist(tempUser,movieId));
				userService.saveActivity(new User_activities(tempUser,"added to the watchlist "+tempMovie.getTitle()));
			}
			if(addList.equals("reminder") && !isReminderListContain(tempUser, movieId)) {
				userService.addReminder(new Reminder_list(tempUser,movieId));
				userService.saveActivity(new User_activities(tempUser,"added to the reminder list "+tempMovie.getTitle()));
			}
			
			if(addList.equals("removeFavorites")) {
				userService.removeFavorites(new Favorites_list(tempUser,movieId));
				userService.saveActivity(new User_activities(tempUser,"removed from the favorites "+tempMovie.getTitle()));
			}
			if(addList.equals("removeWatchlist")) {
				userService.removeWatchlist(new Watchlist(tempUser,movieId));
				userService.saveActivity(new User_activities(tempUser,"removed from the watchlist "+tempMovie.getTitle()));
			}
			if(addList.equals("removeReminder")) {
				userService.removeReminder(new Reminder_list(tempUser,movieId));
				userService.saveActivity(new User_activities(tempUser,"removed from the reminder list "+tempMovie.getTitle()));
			}
			return "redirect:/movies/viewMovie?movieId="+tempMovie.getId();
		}
		
		theModel.addAttribute("userWatchList",tempUser.getWatchlistMovies());
		theModel.addAttribute("userFavList",tempUser.getFavoriteMovies());
		theModel.addAttribute("userReminderList",tempUser.getReminderMovies());
		
		return "view-movie";
	}
	
	public boolean isWatchlistContain(Users user,int movieId) {
		boolean contain = false;
		
		for(Watchlist obj : user.getWatchlistMovies()) {
			if(obj.getShow_id() == movieId) {
				contain = true;
			}
		}
		
		if(contain) {
			System.out.println("You already have this movie in your watchlist.");
		}
		
		return contain;
	}
	
	public boolean isReminderListContain(Users user,int movieId) {
		boolean contain = false;
		
		for(Reminder_list obj : user.getReminderMovies()) {
			if(obj.getShow_id() == movieId) {
				contain = true;
			}
		}
		
		if(contain) {
			System.out.println("You already have this movie in your reminder list.");
		}
		
		return contain;
	}
	
	public boolean isFavoritesListContain(Users user,int movieId) {
		boolean contain = false;
		
		for(Favorites_list obj : user.getFavoriteMovies()) {
			if(obj.getShow_id() == movieId) {
				contain = true;
			}
		}
		
		if(contain) {
			System.out.println("You already have this movie in your favorites list.");
		}
		
		return contain;
	}
}
