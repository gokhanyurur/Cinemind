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
import org.springframework.web.bind.annotation.RequestParam;

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
import com.cinemind.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	public UserService userService;
	
	@GetMapping("/profile")
	public String userProfile(HttpSession loginSession, Model theModel, 
			@RequestParam(required=false, value="movieId") String movieId,
			@RequestParam(required=false, value="removeList") String list,
			@RequestParam(required=false, value="reviewId") String reviewId) throws JSONException, IOException {
		if(loginSession.getAttribute("loginedUser") !=null) {
			
			//GENRE LIST
			List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
			theModel.addAttribute("genreList", genreList);
			
			Users loginedUser = (Users) loginSession.getAttribute("loginedUser");	
			Users tempUser = userService.getUser(loginedUser.getId());
			
			
			//REMOVE FROM LIST
			if(list != null && movieId != null) {
				MovieObj tempMovie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+movieId+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(list.equals("watchlist")) {
					userService.removeWatchlist(new Watchlist(tempUser,Integer.parseInt(movieId)));
					userService.saveActivity(new User_activities(tempUser,"removed from the watchlist "+tempMovie.getTitle()));
				}else if(list.equals("reminderlist")) {
					userService.removeReminder(new Reminder_list(tempUser,Integer.parseInt(movieId)));
					userService.saveActivity(new User_activities(tempUser,"removed from the reminder list "+tempMovie.getTitle()));
				}else if(list.equals("favorites")) {
					userService.removeFavorites(new Favorites_list(tempUser,Integer.parseInt(movieId)));
					userService.saveActivity(new User_activities(tempUser,"removed from the favorites "+tempMovie.getTitle()));
				}
				return "redirect:/profile";
			}
			
			//REMOVE REVIEW()
			if(reviewId != null && movieId != null) {
				MovieObj tempMovie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+movieId+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				userService.removeReview(Integer.parseInt(reviewId), tempUser.getId());
				userService.saveActivity(new User_activities(tempUser,"removed your review for "+tempMovie.getTitle()));
				
				return "redirect:/profile";
			}
			
						
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			theModel.addAttribute("reminderList",tempRemList);
			
			//WATCHLIST
			List<MovieObj> tempWatchlist = new ArrayList<MovieObj>();
			for(Watchlist list_obj:tempUser.getWatchlistMovies()) {
				tempWatchlist.add(JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images"));
			}
			theModel.addAttribute("watchList",tempWatchlist);
			
			//FAVORITE LIST
			List<MovieObj> tempFavList = new ArrayList<MovieObj>();
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
			
			//REVIEW LIST
			List<Movie_reviews> tempUserReviews = new ArrayList<Movie_reviews>();
			List<MovieObj> reviewMovieTitles = new ArrayList<MovieObj>();
			for(Movie_reviews list_obj:tempUser.getMovie_reviews()) {
				tempUserReviews.add(list_obj);
				//reviewMovieTitles.add(JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getMovie_id()+"?;api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images"));
			}
			theModel.addAttribute("userReviewList",tempUserReviews);
			//theModel.addAttribute("reviewMovieTitles",reviewMovieTitles);
						
			//USER REGISTER TIME
			theModel.addAttribute("userRegTime",tempUser.getCreatedAt().toString());
			
			//loginSession.setAttribute("loginedUser", tempUser);
			
			List<Notification> notifications = pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
								
			return "profile";
		}
		else {
			return "redirect:/login";
		}
	
	}
	
	public List<Notification> pushNotifications(List<MovieObj> tempRemList) {
		List<Notification> tempList = new ArrayList<>();
		
		for(MovieObj movie:tempRemList) {
			if(movie.getDayLeft() < 8) {
				if(movie.getDayLeft()>1) {
					tempList.add(new Notification(movie.getId(),movie.getTitle()," will release in ",movie.getDayLeft()+" days."));
				}else if(movie.getDayLeft() == 1) {
					tempList.add(new Notification(movie.getId(),movie.getTitle()," will release tomorrow."));
				}else if(movie.getDayLeft() == 0) {
					tempList.add(new Notification(movie.getId(),movie.getTitle()," is releasing today."));
				}				
			}
		}
		
		return tempList;
	}

	@GetMapping("/profile/edit-profile")
	public String editProfile(HttpSession loginSession,Model theModel, @RequestParam(name="editMessage",required = false) String message) throws JSONException, IOException {
		if(loginSession.getAttribute("loginedUser") != null) {
			
			List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
			theModel.addAttribute("genreList", genreList);
			
			Users loginedUser = (Users) loginSession.getAttribute("loginedUser");	
			Users tempUser = userService.getUser(loginedUser.getId());
			
			theModel.addAttribute("editMessage", message);
			
			//USER REGISTER TIME
			theModel.addAttribute("userRegTime",tempUser.getCreatedAt().toString());
			
			theModel.addAttribute("user",tempUser);
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
						
			return "edit-profile";
		}else {
			return "redirect:/profile";
		}
	}
	
	@PostMapping("/profile/editUser")
	public String editUser(@ModelAttribute("user") Users theUser,Model theModel,HttpSession loginSession) {
		
		Users loginedUser = (Users) loginSession.getAttribute("loginedUser");
		Users userInDB = userService.getUser(loginedUser.getUsername());

		if(!loginedUser.getUsername().equals(theUser.getUsername()) && userService.checkUsername(theUser.getUsername())){
			theModel.addAttribute("editMessage", "Username is already exist.");
		}else {
			userInDB.setUsername(theUser.getUsername());
		}
		
		if(!loginedUser.getEmail().equals(theUser.getEmail())) {
			userInDB.setEmail(theUser.getEmail());
			}
		if(theUser.getFirstName() !=null) {
			userInDB.setFirstName(theUser.getFirstName());
		}
		if(theUser.getLastName() != null) {
			userInDB.setLastName(theUser.getLastName());
		}
		if(theUser.getLocation() != null) {
			userInDB.setLocation(theUser.getLocation());
		}
		userService.saveUser(userInDB);
		loginSession.setAttribute("loginedUser", userInDB);
		userService.saveActivity(new User_activities(userInDB,"updated your profile."));
		
		
		return "redirect:/profile/edit-profile";
	}
	
	@GetMapping("/profile/password")
	public String changePassword(HttpSession loginSession,Model theModel, @RequestParam(name="changePassMsgPositive",required = false) String positiveMsg, @RequestParam(name="changePassMsgNegative",required = false) String negativeMsg) throws JSONException, IOException {
		if(loginSession.getAttribute("loginedUser") != null) {
			
			List<GenreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
			theModel.addAttribute("genreList", genreList);
			
			Users loginedUser = (Users) loginSession.getAttribute("loginedUser");	
			Users tempUser = userService.getUser(loginedUser.getId());
			
			theModel.addAttribute("changePassMsgPositive", positiveMsg);
			theModel.addAttribute("changePassMsgNegative", negativeMsg);
			
			//USER REGISTER TIME
			theModel.addAttribute("userRegTime",tempUser.getCreatedAt().toString());
			
			theModel.addAttribute("user",tempUser);
			
			//REMINDER LIST
			List<MovieObj> tempRemList = new ArrayList<MovieObj>();
			for(Reminder_list list_obj:tempUser.getReminderMovies()) {
				MovieObj movie = JsonProcess.getMovieFromUrl("https://api.themoviedb.org/3/movie/"+list_obj.getShow_id()+"?api_key=a092bd16da64915723b2521295da3254&append_to_response=credits,videos,images");
				if(movie.getDayLeft()>=0) {
					tempRemList.add(movie);
				}
			}
			List<Notification> notifications = pushNotifications(tempRemList);			
			theModel.addAttribute("notifications",notifications);
						
			return "edit-password";
		}else {
			return "redirect:/profile";
		}
	}
	
	@PostMapping("/profile/changePass")
	public String changePass(@ModelAttribute("user") Users theUser,Model theModel,HttpSession loginSession) {
		
		Users loginedUser = (Users) loginSession.getAttribute("loginedUser");
		Users userInDB = userService.getUser(loginedUser.getUsername());
		
		boolean oldPassMatch = (userInDB.getPassword().equals(theUser.getPasswordConf()));
		boolean newPassMatch = (theUser.getNewPass().equals(theUser.getNewPassConf()));

		//check if everything OK change pass
		if(oldPassMatch && newPassMatch) {
			userInDB.setPassword(theUser.getNewPass());
			userService.saveUser(userInDB);
			loginSession.setAttribute("loginedUser", userInDB);
			userService.saveActivity(new User_activities(userInDB,"updated your password."));
			theModel.addAttribute("changePassMsgPositive", "You have changed your password successfully.");
		}else {
			theModel.addAttribute("changePassMsgNegative", "Passwords are not matching.");
		}
				
		return "redirect:/profile/password";
	}
	
	@PostMapping("/registerUser")
	public String registerUser(@ModelAttribute("user") Users theUser,Model theModel) {
		if((String.valueOf(theUser.getPassword()).equals(String.valueOf(theUser.getPasswordConf()))) && !userService.checkUsername(theUser.getUsername())) {
			userService.saveUser(theUser);
			Users tempUser = userService.getUser(userService.getUserIdByLogin(theUser.getEmail(), theUser.getPassword()));
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
