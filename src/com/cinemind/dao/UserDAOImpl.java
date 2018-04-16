package com.cinemind.dao;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Projections;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cinemind.entity.User_activities;
import com.cinemind.entity.Users;

@Repository
public class UserDAOImpl implements UserDAO{

	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public void saveUser(Users theUser) {	
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(theUser);
	}

	@Override
	public Users getUser(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		Users tempUser = currentSession.get(Users.class, theId);
		return tempUser;
	}
	
	@Override
	public Users getUser(String userName) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("from Users where username=:userName");
		theQuery.setParameter("userName", userName);
		Users tempUser = (Users) theQuery.uniqueResult();
		System.out.println("Found user "+tempUser.getUsername());
		return tempUser;
	}

	@Override
	public void deleteUser(int theId) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("delete from Users where id=:userId");
		theQuery.setParameter("userId", theId);
		theQuery.executeUpdate();	
	}

	@Override
	public boolean checkLogin(String email, String password) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select 1 from Users where email=:userEmail AND password=:userPass");
		theQuery.setParameter("userEmail", email);
		theQuery.setParameter("userPass", password);
		return (theQuery.uniqueResult() != null);
	}

	@Override
	public boolean checkUsername(String username) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select 1 from Users where username=:userName");
		theQuery.setParameter("userName", username);
		return (theQuery.uniqueResult() != null);
	}

	@Override
	public int getUserIdByLogin(String email, String password) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select id from Users where email=:userEmail AND password=:userPass");
		theQuery.setParameter("userEmail", email);
		theQuery.setParameter("userPass", password);
		int id = (int) theQuery.uniqueResult();
		System.out.println("User id is "+id);
		return id;
	}
	
	@Override
	public String getUsernameByLogin(String email, String password) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		Query theQuery=currentSession.createQuery("Select username from Users where email=:userEmail AND password=:userPass");
		theQuery.setParameter("userEmail", email);
		theQuery.setParameter("userPass", password);
		String username = (String) theQuery.uniqueResult();
		System.out.println("Username is "+username);
		return username;

	}

	@Override
	public void saveActivity(User_activities activity) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.save(activity);
		
	}

}
