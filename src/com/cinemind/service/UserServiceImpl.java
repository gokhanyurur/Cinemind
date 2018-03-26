package com.cinemind.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cinemind.dao.UserDAO;
import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserDAO userDAO;

	@Override
	@Transactional
	public void saveUser(Users theUser) {
		userDAO.saveUser(theUser);	
	}

	@Override
	@Transactional
	public Users getUser(int theId) {
		return userDAO.getUser(theId);
	}

	@Override
	@Transactional
	public void deleteUser(int theId) {
		userDAO.deleteUser(theId);
	}

	@Override
	@Transactional
	public boolean checkLogin(String email, String password) {
		return userDAO.checkLogin(email,password);
	}
	
	@Override
	@Transactional
	public boolean checkUsername(String username) {
		return userDAO.checkUsername(username);
	}

	@Override
	@Transactional
	public int getUserIdByLogin(String email, String password) {
		return userDAO.getUserIdByLogin(email,password);
	}

	@Override
	@Transactional
	public String getUsernameByLogin(String email, String password) {
		return userDAO.getUsernameByLogin(email,password);
	}

	@Override
	@Transactional
	public void saveActivity(User_activities activity) {
		userDAO.saveActivity(activity);
	}
}
