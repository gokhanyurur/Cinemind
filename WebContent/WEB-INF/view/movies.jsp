<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Movies</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieimg.css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css\texts.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    

	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>

	</head>
<body>
	<div class="row">
            <nav class="navbar navbar-inverse navbar-static-top">
			<!-- container-fluid -->
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
					    			<c:url var="genreLink" value="/movies/genre">
					                 	<c:param name="genreId" value="${genre.id}" />
					                </c:url>
				    				<li><a href="${genreLink}">${genre.title}</a></li>
				    			</c:forEach>
							</ul>
						</li>
                        <li class="active"><a href="#" onclick="window.location.href='movies'; return false;">Movies</a></li>  
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
                        <li style="padding-left: 5px; padding-right: 5px;">
                            <form class="navbar-form" role="search">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Search" name="q">
                                    <div class="input-group-btn">
                                        <button class="btn btn-danger" type="submit" style="height: 34px; background: #ff4d4d"><i class="glyphicon glyphicon-search"></i></button>
                                    </div>
                                </div>
                            </form>
                        </li>
                        <c:if test = "${loginedUser.username == null}">
         					<li><a href="#" onclick="window.location.href='signup'; return false;"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> Sign up</a></li>
                        	<li><a href="#" onclick="window.location.href='login'; return false;"><span class="glyphicon glyphicon-log-in" style="color: #ff4d4d"></span> Login</a></li>
     					</c:if>
                        <c:if test = "${loginedUser.username != null}">
                        	<li class="dropdown">
								<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-fw fa-bell-o"></i> Notifications <span class="badge">15</span></a>
								<ul class="dropdown-menu" role="menu">
									<li><a href="#"><i class="fa fa-fw fa-tag"></i> <span class="badge">Music</span> page <span class="badge">Video</span> sayfasinda etiketlendi.</a></li>
									<li><a href="#"><i class="fa fa-fw fa-thumbs-o-up"></i> <span class="badge">Music</span> sayfasinda iletiniz begenildi.</a></li>
								</ul>
							</li>
         					<li><a href="#" onclick="window.location.href='profile'; return false;"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> <c:out value = "${loginedUser.username}"/></a></li>
                        	<li><a href="#" onclick="window.location.href='logout'; return false;"><span class="glyphicon glyphicon-log-out" style="color: #ff4d4d"></span> Logout</a></li>
     					</c:if>
                    </ul>
                </div>
            </nav>
	</div>
    <div class="row" style="margin-top: -40px; background-color: #e5e5e5"">
        <div class="container" style="padding: 30px; background-color: white">
        	<div class="row">
            	<div class="page-header">
				  <h3 style="color: #FF4D4D; font-weight: normal;">Soon</h3>
				</div>
                <c:forEach var="tempMovie" items="${movieList}">
                	<c:url var="movieLink" value="/movies/viewMovie">
                    	<c:param name="movieId" value="${tempMovie.id}" />
                    </c:url>
					<div class="col-md-3" style="padding: 0; margin: 0; margin-bottom: -40px;">
						<figure class="imghvr-reveal-up">
						  <img src="${tempMovie.backdrop_path}" class="img-responsive" style="padding: 0; margin: 0;">
						  <figcaption>
							<h5>${tempMovie.title}</h5>
							<p>${tempMovie.release_date}</p>
							<div class="btn-group">
							  <a class="btn btn-danger" href="${movieLink}">View Movie</a>
							</div>
						  </figcaption>
						</figure>
					</div>
                 </c:forEach>
             </div>
    	</div>
	</div>
</body>
</html>