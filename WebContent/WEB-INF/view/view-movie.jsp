<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>${movie.title}</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/images.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/buttons.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/texts.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/divs.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/videos.css" />
	
	<link href="https://use.fontawesome.com/releases/v5.0.9/css/all.css" rel="stylesheet">
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    

	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/movieImagesSlider.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/starRating2.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reviews.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recommendedmovies.css" />
	
	<script src="${pageContext.request.contextPath}/resources/js/movieImagesSlider.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/starRating2.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/recommendedmovies.jsp"></script>	
	<script src="${pageContext.request.contextPath}/resources/js/movieAddList.jsp"></script>
</head>
<body>
<!-- navigation -->
	<div class="row" style="margin-top: -20px;">
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
         					<li><a href="/cinemind/profile"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> <c:out value = "${loginedUser.username}"/></a></li>
                        	<li><a href="/cinemind/logout"><span class="glyphicon glyphicon-log-out" style="color: #ff4d4d"></span> Logout</a></li>
     					</c:if>
                    </ul>
                </div>
            </nav>
	</div>
	<!-- image backdrop header -->
	<div class="row" style="margin-top: -20px; background-color: black;">
	    <div class="col-md-12">
			<img src="${movie.backdrop_path}" class="movie-backdrop-header transparent"/>
	    </div>
	</div>
	<!-- content -->
	<div class=row style="background-color: #e5e5e5;">
		<div class="container" style="background-color: white;">
			<div class="row" style="margin-top: 20px;">
				<div class="col-md-9">
					<div class="col-md-4" style="padding-bottom: 45px;">
						<div class="col-md-12 hidden-xs hidden-sm">
							<img src="${movie.poster_path}" alt="${movie.title}" class="img-responsive"/>
						</div>
						<c:if test = "${loginedUser.username != null}">
							<div class="col-md-12">
								<!-- Favorite Button  -->
								<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin: 0; padding: 0;">
									<c:set var="contains" value="false" />
									<c:forEach var="item" items="${userFavList}">
										<c:if test="${item.show_id eq movie.id}">
											<c:set var="contains" value="true" />
									  	</c:if>
									</c:forEach>
									<c:if test="${contains == true}">
										<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=removeFavorites">
											<button type="submit" class="addListBt-active" name="addList" value="favorites"><i class="fa fa-heart fa-2x"></i></button>
										</a>
									</c:if>
									<c:if test="${contains == false}">
										<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=favorites">
											<button type="submit" class="addListBt" name="addList" value="favorites"><i class="fa fa-heart fa-2x"></i></button>
										</a>
									</c:if>	
								</div>
								<!-- Watchlist Button  -->
								<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin: 0; padding: 0;">
									<c:set var="contains" value="false" />
									<c:forEach var="item" items="${userWatchList}">
										<c:if test="${item.show_id eq movie.id}">
											<c:set var="contains" value="true" />
									  	</c:if>
									</c:forEach>
									<c:if test="${contains == true}">
										<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=removeWatchlist">
											<button type="submit" class="addListBt-active" name="addList" value="watchlist"><i class="fa fa-eye fa-2x"></i></button>
										</a>
									</c:if>
									<c:if test="${contains == false}">
										<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=watchlist">
											<button type="submit" class="addListBt" name="addList" value="watchlist"><i class="fa fa-eye fa-2x"></i></button>
										</a>
									</c:if>		
								</div>
								<!-- Reminder Button  -->
								<c:if test="${movie.dayLeft > 0}">
									<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin: 0; padding: 0;">
										<c:set var="contains" value="false" />
										<c:forEach var="item" items="${userReminderList}">
											<c:if test="${item.show_id eq movie.id}">
												<c:set var="contains" value="true" />
										  	</c:if>
										</c:forEach>
										<c:if test="${contains == true}">
											<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=removeReminder">
												<button type="submit" class="addListBt-active" name="addList" value="reminder"><i class="fa fa-bell fa-2x"></i></button>
											</a>
										</c:if>
										<c:if test="${contains == false}">
											<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=reminder">
												<button type="submit" class="addListBt" name="addList" value="reminder"><i class="fa fa-bell fa-2x"></i></button>
											</a>
										</c:if>		
									</div>
								</c:if>
								<c:if test="${movie.dayLeft <=0 }">
									<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin: 0; padding: 0;">
										<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=reminder">
											<button type="submit" class="addListBt" name="addList" value="reminder" disabled="disable"><i class="fa fa-bell fa-2x"></i></button>
										</a>	
									</div>
								</c:if>										
							</div>
						</c:if>
						<c:if test = "${loginedUser.username == null}">
							<div class="col-md-12">
								<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin: 0; padding: 0;">
									<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=favorites">
										<button type="submit" class="addListBt" name="addList" value="favorites" disabled="disabled"><i class="fa fa-heart fa-2x"></i></button>
									</a>
								</div>
								<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin: 0; padding: 0;">
									<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=watchlist">
										<button type="submit" class="addListBt" name="addList" value="watchlist" disabled="disabled"><i class="fa fa-eye fa-2x"></i></button>
									</a>
								</div>
								<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin: 0; padding: 0;">
									<a href="/cinemind/movies/viewMovie?movieId=${movie.id}&addList=reminder">
										<button type="submit" class="addListBt" name="addList" value="reminder" disabled="disabled"><i class="fa fa-bell fa-2x"></i></button>
									</a>
								</div>													
							</div>
						</c:if>
					</div>
					<div class="col-md-8" style="margin-top: -20px; margin-left: -20px;">
						<div class="col-md-12">
							<h3 class="primaryColor">${movie.title}</h3>
						</div>
						<div class="col-md-12" style="margin-top: -20px;">
							<h3 class="movieTagLine">${movie.tagline}</h3>
						</div>
						<div class="col-md-12">
							<c:forEach var="genre" items="${movie.genres}">
							<!-- >
								<c:url var="genreLink" value="/movies/genre">
					            	<c:param name="genreId" value="${genre.id}" />
					            </c:url>
					    		<a href="${genreLink}" style="text-decoration:none;">
									<button class="movieGenreBt"><c:out value="${genre.title}"/></button>
								 </a>
								 -->
								 <a href="/cinemind/movies/genre/${fn:replace(fn:toLowerCase(genre.title),' ', '')}" style="text-decoration:none;">
									<button class="movieGenreBt"><c:out value="${genre.title}"/></button>
								 </a>
							</c:forEach>
						</div>
						<div class="col-md-12">
							<h3 class="movieTagLine">${movie.overview}</h3>
						</div>
					</div>
					<div class="col-md-12" style="padding-bottom: 20px;">
						<div class="col-md-12 hidden-xs hidden-sm" style="margin-top: -40px;">
							<h3 class="page-header primaryColor">Cast</h3>
						</div>
						<div class="col-xs-12 hidden-md hidden-lg" style="margin-top: -10px;">
							<h3 class="page-header primaryColor">Cast</h3>
						</div>
						<div class="cast-container">
							<c:forEach var="actor" items="${movie.castList}">
								<c:if test="${actor.imagePath != null}">
									<div class="col-md-6 col-xs-6 actor-container">
										<div class="col-md-3 col-xs-5">
											<img src="${actor.imagePath}" style="width: 60px; height: auto;"/>
										</div>
										<div class="col-md-9 col-xs-7">
											<div class="col-md-12 col-xs-12">
												<h5 class="bold">${actor.name}</h5>
											</div>
											<div class="col-md-12 col-xs-12">
												<h6>${actor.character}</h6>
											</div>
										</div>
									</div>
								</c:if>
							</c:forEach>
						</div>
						<!-- Trailer -->
						<div class="col-md-12">
							<h3 class="page-header primaryColor">Videos</h3>
							<c:forEach var="trailer" items="${movie.videoList}">
								<div class="col-md-4" style="margin-bottom: 20px;">
									<div class="vid">
						                <iframe width="560" height="315" src="//www.youtube.com/embed/${trailer.key}" allowfullscreen=""></iframe>
						            </div>
								</div>	
							</c:forEach>
						</div>
						<div class="col-md-12">
							<h3 class="page-header primaryColor">Images</h3>
							<div class="col-md-12">
								<div id="myCarousel" class="carousel slide" data-ride="carousel">
							        <div class="carousel-inner">
							            <c:forEach var="image" items="${movie.imageList}" varStatus = "status">
							            	<c:if test="${status.first}">
							            		<div class="item active">
							               			<img src="${image.filePath}" alt="" style="width:100%;">
							            		</div>
							            	</c:if>
							            	<c:if test="${!status.first}">
							            		<div class="item">
							               			<img src="${image.filePath}" alt="" style="width:100%;">
							            		</div>
							            	</c:if>
							            </c:forEach>
							        </div>
							        
							        <a class="left carousel-control" href="#myCarousel" data-slide="prev">
							            <span class="glyphicon glyphicon-chevron-left" style="color:red;"></span>
							            <span class="sr-only">Previous</span>
							        </a>
							        <a class="right carousel-control" href="#myCarousel" data-slide="next">
							            <span class="glyphicon glyphicon-chevron-right" style="color:red;"></span>
							            <span class="sr-only">Next</span>
							        </a>
							    </div>
							</div>
						</div>
						<c:if test = "${loginedUser.username != null}">
							<div class="row">
								<c:if test="${movie.dayLeft < 1}">
									<div class="col-md-12">
										<div class="col-md-12">
											<h3 class="page-header primaryColor">Write a review</h3>
											<div class="col-md-12" style="margin-top: -30px; margin-left: -15px;">
												<div class="widget-area no-padding blank">
													<div class="status-upload" style="padding-bottom: 10px;">
														<form:form action="writeReview" modelAttribute="userReview" method="POST">
															<form:input path="vote" id="input-1" name="input-1" class="rating rating-loading" data-min="0" data-max="5" data-step="1" value="0" />
															<input id="movie_id" name="movie_id" type="hidden" value="${movie.id}"/>
															<form:hidden path="movie_id"/>
															<form:textarea path="review" placeholder="What do you think about the movie?" required="required"/>
															<button type="submit" class="btn btn-danger"><i class="fa fa-share"></i>Share</button>
														</form:form>
													</div>
												</div>
											</div>
										</div>
									</div>
								</c:if>
								<c:if test="${movie.dayLeft > 0}">
									<div class="col-md-12">
										<div class="col-md-12">
											<h3 class="page-header primaryColor">Write a review</h3>
										</div>
										<div class="col-md-12">
											<h4>You can not write review before movie release.</h4>
										</div>
									</div>
								</c:if>
							</div>
						</c:if>
						<c:if test = "${loginedUser.username == null}">
							<div class="col-md-12">
								<h3 class="page-header primaryColor">Write a review</h3>
							</div>
							<div class="col-md-12">
								<h4>You need to login to write a review.</h4>
							</div>
						</c:if>
					</div>
				</div>
				<div class="col-md-3">
					<div class="col-md-6 col-xs-6">
						<div class="col-md-8 col-xs-4">
							<img style="width: 40px; height: auto;" src="${pageContext.request.contextPath}/resources/img/tmdb-logo.png" alt="TMDB Logo"/>
						</div>
						<div class="col-md-4 col-xs-8" style="margin-top: -15px; margin-left: -15px;">
							<h3 class="voteText">${movie.vote_average}</h3>
						</div>
						<div class="col-md-12 col-xs-12">
							<h6 class="voteText">${movie.vote_count} VOTES</h6>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="col-md-8 col-xs-4">
							<img style="width: 40px; height: auto;" src="${pageContext.request.contextPath}/resources/img/logo.png" alt="TMDB Logo"/>
						</div>
						<div class="col-md-4 col-xs-8" style="margin-top: -15px; margin-left: -15px;">
							<h3 class="voteText">${voteAvg}</h3>
						</div>
						<div class="col-md-12 col-xs-12">
							<h6 class="voteText">${voteCount} VOTES</h6>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<h3 class="primaryColor">Details</h3>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="far fa-calendar-alt fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12">
								<label class="bold">Release Date:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								${movie.release_date}
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="far fa-clock fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12 col-xs-12">
								<label class="bold">Runtime:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								${movie.length} Min.
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="fas fa-video fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12 col-xs-12">
								<label class="bold">Director:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								${movie.director}
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="fas fa-pencil-alt fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12 col-xs-12">
								<label class="bold">Writer:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								${movie.writer}
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="fas fa-music fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12 col-xs-12">
								<label class="bold">Music:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								${movie.music}
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="fas fa-globe fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12 col-xs-12">
								<label class="bold">Country:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								${movie.countryString}
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="fas fa-piggy-bank fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12 col-xs-12">
								<label class="bold">Budget:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								<fmt:formatNumber value = "${movie.budget}" type = "currency"/>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-2 col-xs-2">
							<i class="fas fa-hand-holding-usd fa-3x"></i>
						</div>
						<div class="col-md-10 col-xs-10">
							<div class="col-md-12 col-xs-12">
								<label class="bold">Revenue:</label>
							</div>
							<div class="col-md-12 col-xs-12">
								<fmt:formatNumber value = "${movie.revenue}" type = "currency"/>
							</div>
						</div>
					</div>
					<div class="col-md-12 col-xs-12" style="padding-bottom: 10px;">
						<div class="col-md-12">
							<h5 class="primaryColor bold">External Links:</h5>
							<div class="col-md-12">
								<a href="#" class="filterText">IMDb</a><br>
								<a href="#" class="filterText">TheMovieDb</a><br>
								<a href="#" class="filterText">Official Website</a>
							</div>
						</div>
					</div>
				</div>
			</div>
				<div class="col-md-12">
					<div class="col-md-12"><h3 class="page-header primaryColor">Reviews</h3></div>
					<c:if test="${fn:length(reviewList)>0}">
						<div class="col-md-1"></div>
						<div class="col-md-10" style="margin-left: 10px; margin-right: 10px;">
								<div class="carousel-reviews broun-block">
						            <div id="carousel-reviews" class="carousel slide" data-ride="carousel">           
						                <div class="carousel-inner">
						                <c:forEach varStatus="status" var="i" begin="0" end="${fn:length(reviewList)}" step="3">
							            	<c:if test="${i==0}">
							            		<div class="item active">
							                	    <div class="col-md-4 col-sm-6">
											        	<article class="row">
												            <div class="col-md-10 col-sm-10">
												              <div class="panel panel-default arrow left">
												                <div class="panel-body" style="min-height: 140px;">
												                  <header class="text-left">
												                    <div class="comment-user"><i class="fa fa-user"></i> <label style="bold">${reviewList[i].user.username} - Rated:${reviewList[i].vote}</label></div>
												                    <time class="comment-date" datetime="16-12-2014 01:05"><i class="fa fa-clock-o"></i> <fmt:formatDate type = "both" dateStyle = "medium" timeStyle = "medium" value = "${reviewList[i].reviewed_at}" /></time>
												                  </header>
												                  <div class="comment-post">
													                  <p>
																		<label style="bold">${reviewList[i].review}</label>
													                  </p>
												                  </div>
												                </div>
												              </div>
												            </div>
											        	</article>
													</div>
							            			<c:if test="${fn:length(reviewList) > 1}">
							            				<div class="col-md-4 col-sm-6 hidden-xs">
												        	<article class="row">
													            <div class="col-md-10 col-sm-10">
													              <div class="panel panel-default arrow left">
													                <div class="panel-body" style="min-height: 140px;">
													                  <header class="text-left">
													                    <div class="comment-user"><i class="fa fa-user"></i> <label style="bold">${reviewList[i+1].user.username} - Rated:${reviewList[i+1].vote}</label></div>
													                    <time class="comment-date" datetime="16-12-2014 01:05"><i class="fa fa-clock-o"></i> <fmt:formatDate type = "both" dateStyle = "medium" timeStyle = "medium" value = "${reviewList[i+1].reviewed_at}" /></time>
													                  </header>
													                  <div class="comment-post">
														                  <p>
																			<label style="bold">${reviewList[i+1].review}</label>
														                  </p>
													                  </div>
													                </div>
													              </div>
													            </div>
												        	</article>
														</div>
							            			</c:if>
													<c:if test="${fn:length(reviewList) > 2}">
							            				<div class="col-md-4 col-sm-6 hidden-xs">
												        	<article class="row">
													            <div class="col-md-10 col-sm-10">
													              <div class="panel panel-default arrow left">
													                <div class="panel-body" style="min-height: 140px;">
													                  <header class="text-left">
													                    <div class="comment-user"><i class="fa fa-user"></i> <label style="bold">${reviewList[i+2].user.username} - Rated:${reviewList[i+2].vote}</label></div>
													                    <time class="comment-date" datetime="16-12-2014 01:05"><i class="fa fa-clock-o"></i> <fmt:formatDate type = "both" dateStyle = "medium" timeStyle = "medium" value = "${reviewList[i+2].reviewed_at}" /></time>
													                  </header>
													                  <div class="comment-post">
														                  <p>
																			<label style="bold">${reviewList[i+2].review}</label>
														                  </p>
													                  </div>
													                </div>
													              </div>
													            </div>
												        	</article>
														</div>
							            			</c:if>
							                    </div>
							            	</c:if>
							            	<c:if test="${i > 0 && i<fn:length(reviewList) }">
							                    <div class="item">
							                    	<div class="col-md-4 col-sm-6">
											        	<article class="row">
												            <div class="col-md-10 col-sm-10">
												              <div class="panel panel-default arrow left">
												                <div class="panel-body" style="min-height: 140px;">
												                  <header class="text-left">
												                    <div class="comment-user"><i class="fa fa-user"></i> <label style="bold">${reviewList[i].user.username} - Rated:${reviewList[i].vote}</label></div>
												                    <time class="comment-date" datetime="16-12-2014 01:05"><i class="fa fa-clock-o"></i> <fmt:formatDate type = "both" dateStyle = "medium" timeStyle = "medium" value = "${reviewList[i].reviewed_at}" /></time>
												                  </header>
												                  <div class="comment-post">
													                  <p>
																		<label style="bold">${reviewList[i].review}</label>
													                  </p>
												                  </div>
												                </div>
												              </div>
												            </div>
											        	</article>
													</div>
							            			<c:if test="${fn:length(reviewList) > i+1}">
							            				<div class="col-md-4 col-sm-6 hidden-xs">
												        	<article class="row">
													            <div class="col-md-10 col-sm-10">
													              <div class="panel panel-default arrow left">
													                <div class="panel-body" style="min-height: 140px;">
													                  <header class="text-left">
													                    <div class="comment-user"><i class="fa fa-user"></i> <label style="bold">${reviewList[i+1].user.username} - Rated:${reviewList[i+1].vote}</label></div>
													                    <time class="comment-date" datetime="16-12-2014 01:05"><i class="fa fa-clock-o"></i> <fmt:formatDate type = "both" dateStyle = "medium" timeStyle = "medium" value = "${reviewList[i+1].reviewed_at}" /></time>
													                  </header>
													                  <div class="comment-post">
														                  <p>
																			<label style="bold">${reviewList[i+1].review}</label>
														                  </p>
													                  </div>
													                </div>
													              </div>
													            </div>
												        	</article>
														</div>
							            			</c:if>
													<c:if test="${fn:length(reviewList) > i+2}">
							            				<div class="col-md-4 col-sm-6 hidden-xs">
												        	<article class="row">
													            <div class="col-md-10 col-sm-10">
													              <div class="panel panel-default arrow left">
													                <div class="panel-body" style="min-height: 140px;">
													                  <header class="text-left">
													                    <div class="comment-user"><i class="fa fa-user"></i> <label style="bold">${reviewList[i+2].user.username} - Rated:${reviewList[i+2].vote}</label></div>
													                    <time class="comment-date" datetime="16-12-2014 01:05"><i class="fa fa-clock-o"></i> <fmt:formatDate type = "both" dateStyle = "medium" timeStyle = "medium" value = "${reviewList[i+2].reviewed_at}" /></time>
													                  </header>
													                  <div class="comment-post">
														                  <p>
																			<label style="bold">${reviewList[i+2].review}</label>
														                  </p>
													                  </div>
													                </div>
													              </div>
													            </div>
												        	</article>
														</div>
							            			</c:if>
							                	</div>
							                </c:if>
							            </c:forEach>                                  
						             </div>
						             <a class="left carousel-control" href="#carousel-reviews" role="button" data-slide="prev">
						             	<span class="glyphicon glyphicon-chevron-left"></span>
						             </a>
						             <a class="right carousel-control" href="#carousel-reviews" role="button" data-slide="next">
						             	<span class="glyphicon glyphicon-chevron-right"></span>
						             </a>
						    	</div>
							</div>	
						</div>
					</c:if>
					<c:if test="${fn:length(reviewList)<1}">
						<div class="col-md-12" style="padding-bottom: 50px;">
							<h4>There is not review for this movie. Would you like to write one?</h4>
						</div>
					</c:if>
				</div>
			<div class="col-md-1"></div>
			<c:if test="${fn:length(movie.recommendedMovies) > 0}">
				<div class="col-md-12 hidden-sm hidden-xs">
					<div class="col-md-12">
						<h3 class="page-header primaryColor">Recommended Movies</h3>
					</div>
					<div class="col-md-12" style="margin-left: -20px;">
						<div class="carousel slide" id="myCarouselrec">
							<div class="carousel-inner">
						    	<c:forEach varStatus="status" var="i" begin="0" end="${fn:length(movie.recommendedMovies)}" step="4">
									<c:if test="${i == 0}">
										<div class="item active">
							            	<ul class="thumbnails">
							                	<li class="col-sm-3">
							    					<div class="fff">
														<div class="thumbnail">
															<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i].id}"><img src="${movie.recommendedMovies[i].poster_path}" alt=""></a>
														</div>
							                       	</div>
							                    </li>
							                    <li class="col-sm-3">
													<div class="fff">
														<div class="thumbnail">
															<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i+1].id}"><img src="${movie.recommendedMovies[i+1].poster_path}" alt=""></a>
														</div>
							                        </div>
							                    </li>
							                    <li class="col-sm-3">
													<div class="fff">
														<div class="thumbnail">
															<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i+2].id}"><img src="${movie.recommendedMovies[i+2].poster_path}" alt=""></a>
														</div>
							                        </div>
							                    </li>
							                    <li class="col-sm-3">
													<div class="fff">
														<div class="thumbnail">
															<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i+3].id}"><img src="${movie.recommendedMovies[i+3].poster_path}" alt=""></a>
														</div>
							                        </div>
							                    </li>
							             	</ul>
							              </div>
									  	</c:if>
									  	<c:if test="${i > 0 && i < fn:length(movie.recommendedMovies)}">
									  		<div class="item">
							                    <ul class="thumbnails">
							                        <li class="col-sm-3">
							    						<div class="fff">
															<div class="thumbnail">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i].id}"><img src="${movie.recommendedMovies[i].poster_path}" alt=""></a>
															</div>
							                            </div>
							                        </li>
							                        <li class="col-sm-3">
														<div class="fff">
															<div class="thumbnail">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i+1].id}"><img src="${movie.recommendedMovies[i+1].poster_path}" alt=""></a>
															</div>
							                            </div>
							                        </li>
							                        <li class="col-sm-3">
														<div class="fff">
															<div class="thumbnail">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i+2].id}"><img src="${movie.recommendedMovies[i+2].poster_path}" alt=""></a>
															</div>
							                            </div>
							                        </li>
							                        <li class="col-sm-3">
														<div class="fff">
															<div class="thumbnail">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${movie.recommendedMovies[i+3].id}"><img src="${movie.recommendedMovies[i+3].poster_path}" alt=""></a>
															</div>
							                            </div>
							                        </li>
							                    </ul>
							              </div>
									  	</c:if>
									</c:forEach>			            
						        </div>			                              
						    </div>
					</div>
					<nav>
						<ul class="control-box pager" style="margin-left: -10px; margin-top: -15px; margin-left: -10px; margin-bottom: 80px;">
							<li><a data-slide="prev" href="#myCarouselrec" class=""><i class="glyphicon glyphicon-chevron-left" style="color:#FF4D4D;"></i></a></li>
							<li><a data-slide="next" href="#myCarouselrec" class=""><i class="glyphicon glyphicon-chevron-right" style="color:#FF4D4D;"></i></li>
						</ul>
					</nav>
				</div>
			</c:if>
		</div>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>