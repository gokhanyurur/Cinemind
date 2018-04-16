package com.cinemind.service;

import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;

public interface UserService {
	
	public void saveUser(Users theUser);

	public Users getUser(int theId);
	
	public Users getUser(String userName);

	public void deleteUser(int theId);

	public boolean checkLogin(String email, String password);

	boolean checkUsername(String username);

	public int getUserIdByLogin(String email, String password);

	public String getUsernameByLogin(String email, String password);

	public void saveActivity(User_activities activity);
	
}
