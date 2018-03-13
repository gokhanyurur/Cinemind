package com.cinemind.testdb;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.*;

/**
 * Servlet implementation class TestDBServlet
 */
@WebServlet("/TestDBServlet")
public class TestDBServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String user = "cinemind";
		String pass = "cinemind";
		
		String jdbcUrl = "jdbc:mysql://localhost:3306/cinemind_db?useSSL=false";
		String driver = "com.mysql.jdbc.Driver";
		
		//get connection to database
		try {
			PrintWriter out = response.getWriter();
			
			out.println("Connecting to DB: "+jdbcUrl);
			
			Class.forName(driver);
			
			Connection myCon = DriverManager.getConnection(jdbcUrl,user,pass);
			
			out.print("Connection Successful.");
			
			myCon.close();
		}catch(Exception exc) {
			exc.printStackTrace();
			throw new ServletException(exc);
		}
	}

}
