<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       	<title>Profile</title>
       	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/texts.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/buttons.css">
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/images.css">
		
		<link href="https://use.fontawesome.com/releases/v5.0.9/css/all.css" rel="stylesheet">
		
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	    
	    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slider.css">
		<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/verticalmovie.css">
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tables.css">
		<script src="${pageContext.request.contextPath}/resources/js/movieListTables.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/starRating.css">
		
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
                            <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="Logo" style="width: 30px; height: 30px; margin-top: -5px; display: inline-block;">
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
		    			<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="Logo" class="profilepage-logo"/>
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
						<a href="/cinemind/profile" class="profileNavBtn profileActivePage">PROFILE</a>
						<a href="/cinemind/profile/edit-profile" class="profileNavBtn">EDIT PROFILE</a>
						<a href="/cinemind//profile/password" class="profileNavBtn">PASSWORD</a>
						<a href="#" onclick="window.location.href='logout'; return false;" class="profileNavBtn">LOGOUT</a>
					</nav>
				</div>
			</div>
			<div class="row">
				<div class="container" style="padding: 30px; background-color: white; margin-top: 30px; min-height: 400px;">
					<div class="col-md-2" style="margin-left: 0px;">
						<div class="row">
				    		<h4 class="primaryColor" style="font-weight: 600;">Navigation</h4>
				    	</div>
						<ul class="nav nav-pills nav-stacked" role="tablist" style="margin-left: -15px;">
							<li class="active"><a href=".reminder-list" role="tab" data-toggle="tab" class="profileSideNav"><span class="glyphicon glyphicon-chevron-right"></span> Reminder</a></li>
							<li><a href=".watchlist" role="tab" data-toggle="tab" class="profileSideNav"><span class="glyphicon glyphicon-chevron-right"></span> Watchlist</a></li>
							<li><a href=".favorites" role="tab" data-toggle="tab" class="profileSideNav"><span class="glyphicon glyphicon-chevron-right"></span> Favorites</a></li>
							<li><a href=".reviews" role="tab" data-toggle="tab" class="profileSideNav"><span class="glyphicon glyphicon-chevron-right"></span> Reviews</a></li>
							<li><a href=".activities" role="tab" data-toggle="tab" class="profileSideNav"><span class="glyphicon glyphicon-chevron-right"></span> Activities</a></li>
						</ul>
					</div>
					<div class="col-md-10" style="margin-top: 0px; margin-left: -10px;">
						<div class="col-md-12">
							<div class="tab-content">
								<div class="tab-pane active reminder-list">
								  	<div class="panel panel-danger filterable">
							            <div class="panel-heading">
							                <h3 class="panel-title">Reminder List</h3>
							                <div class="pull-right">
							                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
							                </div>
							            </div>
							            <table class="table">
							                <thead>
							                    <tr class="filters">
							                        <th><input type="text" class="form-control" placeholder="Movie Id" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Title" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Release Date" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <c:forEach var="movie" items="${reminderList}">
							                    	<c:if test="${fn:length(reminderList)>0}">
								                    	<tr>
									                        <td>${movie.id}</td>
									                        <td><a class="filterText" href="/cinemind/movies/viewMovie?movieId=${movie.id}">${movie.title}</a></td>
									                        <td>${movie.release_date}</td>
									                        <td class="text-center"><a href="/cinemind/profile?removeList=reminderlist&movieId=${movie.id}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span>Del</a></td>
								                    	</tr>
								                    </c:if>
							                    </c:forEach>
							                </tbody>
							            </table>
						        	</div>
							  	</div>
							 	<div class="tab-pane watchlist">
							  		<div class="panel panel-danger filterable">
							            <div class="panel-heading">
							                <h3 class="panel-title">Watchlist</h3>
							                <div class="pull-right">
							                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
							                </div>
							            </div>
							            <table class="table">
							                <thead>
							                    <tr class="filters">
							                        <th><input type="text" class="form-control" placeholder="Movie Id" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Title" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Release Date" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <c:forEach var="movie" items="${watchList}">
							                    	<c:if test="${fn:length(watchList)>0}">
								                    	<tr>
									                        <td>${movie.id}</td>
									                        <td><a class="filterText" href="/cinemind/movies/viewMovie?movieId=${movie.id}">${movie.title}</a></td>
									                        <td>${movie.release_date}</td>
									                        <td class="text-center"><a href="/cinemind/profile?removeList=watchlist&movieId=${movie.id}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span>Del</a></td>
								                    	</tr>
								                    </c:if>
							                    </c:forEach>
							                </tbody>
							            </table>
					        		</div>
							 	</div>
								<div class="tab-pane favorites">
									<div class="panel panel-danger filterable">
							            <div class="panel-heading">
							                <h3 class="panel-title">Favorites</h3>
							                <div class="pull-right">
							                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
							                </div>
							            </div>
							            <table class="table">
							                <thead>
							                    <tr class="filters">
							                        <th><input type="text" class="form-control" placeholder="Movie Id" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Title" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Release Date" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <c:forEach var="movie" items="${favoritesList}">
							                    	<c:if test="${fn:length(favoritesList)>0}">
								                    	<tr>
									                        <td>${movie.id}</td>
									                        <td><a class="filterText" href="/cinemind/movies/viewMovie?movieId=${movie.id}">${movie.title}</a></td>
									                        <td>${movie.release_date}</td>
									                        <td class="text-center"><a href="/cinemind/profile?removeList=favorites&movieId=${movie.id}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span>Del</a></td>
								                    	</tr>
								                    </c:if>
							                    </c:forEach>
							                </tbody>
							            </table>
					        		</div>
								</div>
								<div class="tab-pane reviews">
									<div class="panel panel-danger filterable">
							            <div class="panel-heading">
							                <h3 class="panel-title">Reviews</h3>
							                <div class="pull-right">
							                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
							                </div>
							            </div>
							            <table class="table">
							                <thead>
							                    <tr class="filters">
							                        <th><input type="text" class="form-control" placeholder="Movie Id" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Review" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Reviewed At" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <c:forEach var="review" items="${userReviewList}">
							                    	<c:if test="${fn:length(userReviewList)>0}">
								                    	<tr>
								                    		<td>${review.movie_id}</td>
									                        <td><a class="filterText" href="/cinemind/movies/viewMovie?movieId=${review.movie_id}">${review.review}</a></td>
									                        <td>${review.reviewed_at}</td>
									                        <td class="text-center"><a href="/cinemind/profile?reviewId=${review.id}&movieId=${review.movie_id}" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span>Del</a></td>
								                    	</tr>
								                    </c:if>
							                    </c:forEach>
							                </tbody>
							            </table>
					        		</div>
								</div>
								<div class="tab-pane activities">
									<div class="panel panel-danger filterable">
							            <div class="panel-heading">
							                <h3 class="panel-title">Activities</h3>
							                <div class="pull-right">
							                    <button class="btn btn-default btn-xs btn-filter"><span class="glyphicon glyphicon-filter"></span> Filter</button>
							                </div>
							            </div>
							            <table class="table">
							                <thead>
							                    <tr class="filters">
							                        <th><input type="text" class="form-control" placeholder="#" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Activity" disabled></th>
							                        <th>Happened At</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <c:forEach varStatus="theCount" var="activity" items="${userActivityList}">
							                    	<c:if test="${fn:length(userActivityList)>0}">
								                    	<tr>
									                        <td>${theCount.count}</td>
									                        <td>You ${activity.activity}</td>
									                        <td>${activity.createdAt}</td>
								                    	</tr>
								                    </c:if>
							                    </c:forEach>
							                </tbody>
							            </table>
					        		</div>
								</div>
							</div>
						</div>	
					</div>
				</div>
			</div>
		</div>
		<jsp:include page="footer.jsp"/>
    </body>
</html>