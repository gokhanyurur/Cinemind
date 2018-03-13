<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Cinemind</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<!--
<style>
body {
    background-color: #313131;
}
</style>
  -->
<body>
	<div class="row">
            <nav class="navbar navbar-inverse navbar-static-top">
			<!-- container-fluid -->
                <div class="container">
                    <div class="navbar-header"> 
                        <a class="navbar-brand" href="/cinemind" style="color: #ff4d4d; font-weight: bold; font-size: 20px;">
                            <img src="${pageContext.request.contextPath}/resources/img/logo.png" style="width: 30px; height: 30px; margin-top: -5px; display: inline-block;">
                            <span style="display: inline-block;">CINEMIND</span>
                        <!--<a class="navbar-brand" href="#" style="color: #ff4d4d; font-weight: bold; font-size: 20px;">CINEMIND</a>-->
                        </a>     
                    </div>
                    <ul class="nav navbar-nav">
                        <li class="active"><a href="#">HOME</a></li>
                        <li><a href="#">GENRES</a></li>
                        <li><a href="#">Page 2</a></li>
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li style="padding-left: 5px; padding-right: 5px;">
                            <form class="navbar-form" role="search">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="SEARCH" name="q">
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger" type="submit" style="height: 34px; background: #ff4d4d"><i class="glyphicon glyphicon-search"></i></button>
                                    </div>
                                </div>
                            </form>
                        </li>
                        <c:if test = "${loginedUser.username == null}">
         					<li><a href="#" onclick="window.location.href='signup'; return false;"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> SIGN UP</a></li>
                        	<li><a href="#" onclick="window.location.href='login'; return false;"><span class="glyphicon glyphicon-log-in" style="color: #ff4d4d"></span> LOGIN</a></li>
     					</c:if>
                        <c:if test = "${loginedUser.username != null}">
         					<li><a href="#" onclick="window.location.href='info'; return false;"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> <c:out value = "${fn:toUpperCase(loginedUser.username)}"/></a></li>
                        	<li><a href="#" onclick="window.location.href='logout'; return false;"><span class="glyphicon glyphicon-log-out" style="color: #ff4d4d"></span> LOGOUT</a></li>
     					</c:if>
                    </ul>
                </div>
            </nav>
	</div>
        <div class="row" style="margin-top: -20px">
            <!--<div class="container-fluid" style="background-color: darkslategrey"> -->
                <div class="container" style="background-color: darkgrey">
                    <div class="row">
                        <div class="col-md-3" style="background-color: deeppink" >
                            TEST1
                            <br>
                            TEST1
                            <br>
                            TEST1
                            <br>
                        </div>
                        <div class="col-md-9" style="background-color:darkorchid" >
                            TEST2
                        </div>
                    </div>
                </div>
            <!--</div>-->
        </div>
</body>
</html>