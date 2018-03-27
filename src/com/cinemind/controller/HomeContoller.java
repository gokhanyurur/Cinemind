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
public class HomeContoller {

	@Autowired
	private UserService userService;
	
	
	@GetMapping("/")
	public String showIndexPage(Model theModel) throws IOException, JSONException {
		
		List<movieObj> popularList = JsonProcess.getMoviesFromUrl("https://api.themoviedb.org/3/movie/popular?api_key=a092bd16da64915723b2521295da3254");
		theModel.addAttribute("popularList", popularList);
		
		List<genreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
		theModel.addAttribute("genreList", genreList);
		return "index";
	}
	
	@GetMapping("/signup")
	public String showFormForSignup(Model theModel,@RequestParam(name="registerMessage",required = false) String message) {
		Users theUser = new Users();
		theModel.addAttribute("user",theUser);
		theModel.addAttribute("registerMessage",message);
		return "signup";	
		//show sign up page
	}
	
	@PostMapping("/registerUser")
	public String registerUser(@ModelAttribute("user") Users theUser,Model theModel) {
		if((String.valueOf(theUser.getPassword()).equals(String.valueOf(theUser.getPasswordConf()))) && !userService.checkUsername(theUser.getUsername())) {
			userService.saveUser(theUser);
			userService.saveActivity(new User_activities(userService.getUserIdByLogin(theUser.getEmail(), theUser.getPassword())," joined to cinemind"));
			return "redirect:/";
			//redirect home
		}else {
			System.out.println("Username is already exist or passwords are not matching.");
			theModel.addAttribute("registerMessage", "Username is already exist or passwords are not matching.");
			return "redirect:/signup";
		}

	}
	
	@RequestMapping("/login")
	public String login(Model theModel,@RequestParam(name="loginMessage",required = false) String message) {
		Users theUser = new Users();
		theModel.addAttribute("user",theUser);
		theModel.addAttribute("loginMessage",message);
		return "login";
		//show login form
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
	
	@GetMapping("/info")
    public String userInfo(HttpSession session) {
		//session.getAttribute("loginedUser");
	return "profile";
	}
}