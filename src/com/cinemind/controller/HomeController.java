package com.cinemind.controller;

import java.io.IOException;
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

import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;
import com.cinemind.json.JsonProcess;
import com.cinemind.objects.genreObj;
import com.cinemind.objects.movieObj;
import com.cinemind.service.UserService;


@Controller
//@RequestMapping("/")
public class HomeController {

	@GetMapping("/")
	public String showIndexPage(Model theModel) throws IOException, JSONException {
		
		//https://api.themoviedb.org/3/movie/popular?api_key=a092bd16da64915723b2521295da3254
		List<movieObj> nowPlayingList = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/movie/now_playing?api_key=a092bd16da64915723b2521295da3254&region=US");
		List<movieObj> nowPlayingSlider = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/movie/now_playing?api_key=a092bd16da64915723b2521295da3254&region=US&page=2");
		nowPlayingList.addAll(nowPlayingSlider);
		theModel.addAttribute("nowPlaying", nowPlayingList);
		
		List<genreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		
		List<movieObj> upcomingList = JsonProcess.getUpcomingFromUrl("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254");
		List<movieObj> upcomingListPg2=JsonProcess.getUpcomingFromUrl("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254&page=2");
		List<movieObj> upcomingListPg3=JsonProcess.getUpcomingFromUrl("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254&page=3");
		upcomingList.addAll(upcomingListPg2);
		upcomingList.addAll(upcomingListPg3);
		theModel.addAttribute("upcomingList",upcomingList);
		
		return "index";
	}
	
	@GetMapping("/signup")
	public String showFormForSignup(Model theModel,@RequestParam(name="registerMessage",required = false) String message, HttpSession loginSession) {
		if(loginSession.getAttribute("loginedUser") == null) {
			Users theUser = new Users();
			theModel.addAttribute("user",theUser);
			theModel.addAttribute("registerMessage",message);
			return "signup";	
		}else {
			return "redirect:/profile";
		}
	}
		
	@RequestMapping("/login")
	public String login(Model theModel,@RequestParam(name="loginMessage",required = false) String message, HttpSession loginSession) {
		if(loginSession.getAttribute("loginedUser") == null) {
			Users theUser = new Users();
			theModel.addAttribute("user",theUser);
			theModel.addAttribute("loginMessage",message);
			return "login";
		}else {
			return "redirect:/profile";
		}
	}
		
}
