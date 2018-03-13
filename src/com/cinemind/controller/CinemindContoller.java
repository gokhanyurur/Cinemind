package com.cinemind.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cinemind.entity.Users;
import com.cinemind.service.UserService;


@Controller
@RequestMapping("/")
public class CinemindContoller {

	@Autowired
	private UserService userService;
	
	@GetMapping("/signup")
	public String showFormForSignup(Model theModel,@RequestParam(name="registerMessage",required = false) String message) {
		Users theUser = new Users();
		theModel.addAttribute("user",theUser);
		theModel.addAttribute("registerMessage",message);
		return "signup";		
	}
	
	@PostMapping("/registerUser")
	public String registerUser(@ModelAttribute("user") Users theUser,Model theModel) {
		if((String.valueOf(theUser.getPassword()).equals(String.valueOf(theUser.getPasswordConf()))) && !userService.checkUsername(theUser.getUsername())) {
			userService.saveUser(theUser);
			return "redirect:/";
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
