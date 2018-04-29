<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
       	<title>Edit Your Profile</title>
       	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/texts.css" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/buttons.css" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/images.css" />
		
		<link href="https://use.fontawesome.com/releases/v5.0.9/css/all.css" rel="stylesheet">
		
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	    
	    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slider.css" />
		<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/verticalmovie.css" />
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tables.css" />
		<script src="${pageContext.request.contextPath}/resources/js/movieListTables.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/starRating.css" />
		
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
		
		<script>
		     $(document).ready(function(){
		        $('.dropdown-toggle').dropdown()
		    });
		</script>
    </head>
    <body>
    	<div class="row">
            <nav class="navbar navbar-inverse navbar-static-top">
                <div class="container">
                    <div class="navbar-header"> 
                        <a class="navbar-brand" href="/cinemind" style="color: #ff4d4d; font-weight: bold; font-size: 20px;">
                            <img src="${pageContext.request.contextPath}/resources/img/logo.png" style="width: 30px; height: 30px; margin-top: -5px; display: inline-block;">
                            <span style="display: inline-block;">CINEMIND</span>
                        </a>     
                    </div>
                    <ul class="nav navbar-nav">
                        <li><a href="/cinemind">Home</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Genres <span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
								<c:forEach var="genre" items="${genreList}">
				    				<li><a href="/cinemind/movies/genre/${fn:replace(fn:toLowerCase(genre.title),' ', '')}">${genre.title}</a></li>
				    			</c:forEach>
							</ul>
						</li>
                        <li><a href="/cinemind/movies">Movies</a></li>  
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li style="padding-left: 5px; padding-right: 5px;">
                            <form:form action="/cinemind/search" modelAttribute="q" method="GET" class="navbar-form" role="search">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search" name="q" required>
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger" type="submit" style="height: 34px; background: #ff4d4d"><i class="glyphicon glyphicon-search"></i></button>
                                    </div>
                                </div>
                            </form:form>
                        </li>
                        <c:if test = "${loginedUser.username == null}">
         					<li><a href="/cinemind/signup"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> Sign up</a></li>
                        	<li><a href="/cinemind/login"><span class="glyphicon glyphicon-log-in" style="color: #ff4d4d"></span> Login</a></li>
     					</c:if>
                        <c:if test = "${loginedUser.username != null}">
                        	<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-fw fa-bell-o"></i> Notifications <span class="badge">${fn:length(notifications)}</span></a>
								<ul class="dropdown-menu" role="menu">
									<c:if test="${fn:length(notifications)>0}">
										<c:forEach var="notification" items="${notifications}">
											<li><a href="/cinemind/movies/viewMovie?movieId=${notification.movieId}"><i class="far fa-calendar-check"></i> <span class="badge">${notification.movieTitle}</span>${notification.bodyText}<span class="badge">${notification.dayLeft}</span></a></li>
										</c:forEach>
									</c:if>
									<c:if test="${fn:length(notifications)<1}">
										<li><a href="#">There is no notification.</a></li>
									</c:if>
								</ul>
							</li>
         					<li class="active"><a href="/cinemind/profile"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> <c:out value = "${loginedUser.username}"/></a></li>
                        	<li><a href="/cinemind/logout"><span class="glyphicon glyphicon-log-out" style="color: #ff4d4d"></span> Logout</a></li>
     					</c:if>
                    </ul>
                </div>
            </nav>
    	</div>
		<div class="row" style="margin-top: -20px; background-color: black;">
		    <div class="col-md-12 profilepage-header">
		    	<div class="container" align="center" style="padding-top: 40px;">
		    		<div class="col-md-12">
		    			<img src="${pageContext.request.contextPath}/resources/img/logo.png" class="profilepage-logo"/>
		    		</div>
		    		<div class="col-md-12">
		    			<h1>Hi, ${loginedUser.username}</h1>
		    		</div>
		    		<div class="col-md-12" style="margin-top: -5px;">
		    			<label style="font-size: 18px; font-weight: normal;">You are with us since ${userRegTime}</label>
		    		</div>
		    	</div>
		    </div>
		</div>
		<div class="row" style="background-color: #e5e5e5;">
			<div class="row" style="background-color: white;">
				<div class="container" align="center" style="padding-top: 10px; padding-bottom: 10px;">
					<nav>
						<a href="/cinemind/profile" class="profileNavBtn">PROFILE</a>
						<a href="/cinemind/profile/edit-profile" class="profileNavBtn profileActivePage">EDIT PROFILE</a>
						<a href="/cinemind//profile/password" class="profileNavBtn">PASSWORD</a>
						<a href="/cinemind/logout" class="profileNavBtn">LOGOUT</a>
					</nav>
				</div>
			</div>
			<div class="row">
				<div class="container" style="padding-left: 30px; background-color: white; margin-top: 30px; min-height: 400px;">
					<div class="col-md-12">
						<div class="page-header" style="padding-bottom: 0px;">
							<h3 style="color: #FF4D4D; font-weight: normal;">Edit Your Profile</h3>
						</div>
					</div>
					<div class="col-md-12">
						<form:form action="editUser" modelAttribute="user" method="POST">
		                    <div class="row">
		                        <div class="col-md-12 field-label-responsive" style="padding-bottom: 5px;">
		                            <label for="name">Username*</label>
		                        </div>
		                        <div class="col-md-12">
		                            <div class="form-group">
		                                <div class="input-group mb-2 mr-sm-2 mb-sm-0">
		                                    <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user"></i></div>
		                                    <form:input path="username" cssClass="form-control" cssStyle="width: 50vw; position: relative;" required="required"/>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-12">
		                        	<h5 style="color: #ff0000;">${editMessage}</h5>
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-md-12 field-label-responsive" style="padding-bottom: 5px;">
		                            <label for="name">Email*</label>
		                        </div>
		                        <div class="col-md-12">
		                            <div class="form-group">
		                                <div class="input-group mb-2 mr-sm-2 mb-sm-0">
		                                    <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-at"></i></div>
		                                    <form:input path="email" cssClass="form-control" cssStyle="width: 50vw; position: relative;" required="required"/>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-12">
		                        	<!-- error message -->
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-md-12 field-label-responsive" style="padding-bottom: 5px;">
		                            <label for="name">Firstname</label>
		                        </div>
		                        <div class="col-md-12">
		                            <div class="form-group">
		                                <div class="input-group mb-2 mr-sm-2 mb-sm-0">
		                                    <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user"></i></div>
		                                    <form:input path="firstName" cssClass="form-control" cssStyle="width: 50vw; position: relative;"/>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-12">
		                        	<!-- error message -->
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-md-12 field-label-responsive" style="padding-bottom: 5px;">
		                            <label for="name">Lastname</label>
		                        </div>
		                        <div class="col-md-12">
		                            <div class="form-group">
		                                <div class="input-group mb-2 mr-sm-2 mb-sm-0">
		                                    <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-user"></i></div>
		                                    <form:input path="lastName" cssClass="form-control" cssStyle="width: 50vw; position: relative;"/>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-12">
		                        	<!-- error message -->
		                        </div>
		                    </div>
		                    <div class="row">
		                        <div class="col-md-12 field-label-responsive" style="padding-bottom: 5px;">
		                            <label for="name">Location</label>
		                        </div>
		                        <div class="col-md-12">
		                            <div class="form-group">
		                                <div class="input-group mb-2 mr-sm-2 mb-sm-0">
		                                    <div class="input-group-addon" style="width: 2.6rem"><i class="fa fa-map-marker"></i></div>
		                                    <form:input path="location" cssClass="form-control" cssStyle="width: 50vw; position: relative;"/>
		                                </div>
		                            </div>
		                        </div>
		                        <div class="col-md-12">
		                        	<!-- error message -->
		                        </div>
		                    </div>
		                    <div class="row" style="margin-bottom: 50px;">
		                        <div class="col-md-6">
		                            <button type="submit" class="btn btn-danger"><i class="fa fa-save"></i> Save</button>
		                        </div>
		                    </div>
		                </form:form>
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp"/>
    </body>
</html>