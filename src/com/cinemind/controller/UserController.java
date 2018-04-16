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

import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;
import com.cinemind.json.JsonProcess;
import com.cinemind.objects.genreObj;
import com.cinemind.service.UserService;

@Controller
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping("/profile")
	public String userProfile(HttpSession loginSession, Model theModel) throws JSONException, IOException {
		if(loginSession.getAttribute("loginedUser") !=null) {			
			List<genreObj> genreList = JsonProcess.getGenresFromUrl("https://api.themoviedb.org/3/genre/movie/list?api_key=a092bd16da64915723b2521295da3254&language=en-US");
			theModel.addAttribute("genreList", genreList);
			
			Users loginedUser = (Users) loginSession.getAttribute("loginedUser");	
			Users tempUser = userService.getUser(loginedUser.getId());
			theModel.addAttribute("userRegTime", tempUser.getCreatedAt().toString());
			
			return "profile";
		}else {
			return "redirect:/login";
		}
	
	}
	
	@PostMapping("/registerUser")
	public String registerUser(@ModelAttribute("user") Users theUser,Model theModel) {
		if((String.valueOf(theUser.getPassword()).equals(String.valueOf(theUser.getPasswordConf()))) && !userService.checkUsername(theUser.getUsername())) {
			userService.saveUser(theUser);
			userService.saveActivity(new User_activities(userService.getUserIdByLogin(theUser.getEmail(), theUser.getPassword())," joined to cinemind"));
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

}
