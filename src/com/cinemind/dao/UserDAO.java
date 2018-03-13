package com.cinemind.dao;

import com.cinemind.entity.Users;

public interface UserDAO {
	
	public void saveUser(Users theUser);

	public Users getUser(int theId);

	public void deleteUser(int theId);

	public boolean checkLogin(String email, String password);

	public boolean checkUsername(String username);

	public int getUserIdByLogin(String email, String password);

	public String getUsernameByLogin(String email, String password);
}
