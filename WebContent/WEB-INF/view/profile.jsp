<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored = "false" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
       <title>Profile</title>
    </head>
    <body>  
        <h4>User Email: ${loginedUser.email}</h4>
        <h4>Username: ${loginedUser.username}</h4>
        <a href="#" onclick="window.location.href='logout'; return false;">Log out</a><br>

    </body>
</html>