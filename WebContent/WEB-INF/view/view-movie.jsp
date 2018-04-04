<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
	<script src="${pageContext.request.contextPath}/resources/js/movieImagesSlider.js"></script>

	</head>
<body>
<!-- navigation -->
	<div class="row" style="margin-top: -20px;">
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
                        <li><a href="#">Genres</a></li>
                        <li><a href="#" onclick="window.location.href='movies'; return false;">Movies</a></li>  
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
         					<li><a href="#" onclick="window.location.href='info'; return false;"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> <c:out value = "${loginedUser.username}"/></a></li>
                        	<li><a href="#" onclick="window.location.href='logout'; return false;"><span class="glyphicon glyphicon-log-out" style="color: #ff4d4d"></span> Logout</a></li>
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
						<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin-left: 15px;">
							<a href="#">
								<button class="addListBt"><i class="fa fa-heart fa-2x"></i></button>
							</a>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin-left: -15px;">
							<a href="#">
								<button class="addListBt"><i class="fa fa-eye fa-2x"></i></button>
							</a>
						</div>
						<div class="col-md-4 col-sm-4 col-xs-4" style="background-color: #ff4d4d; margin-left: -15px;">
							<a href="#">
								<button class="addListBt"><i class="fa fa-bell fa-2x"></i></button>
							</a>
						</div>
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
								<c:url var="genreLink" value="/movies/genre">
					            	<c:param name="genreId" value="${genre.id}" />
					            </c:url>
					    		<a href="${genreLink}" style="text-decoration:none;">
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
										<div class="col-md-3 col-xs-3">
											<img src="${actor.imagePath}" style="width: 60px; height: auto;"/>
										</div>
										<div class="col-md-9 col-xs-9">
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
							<h3 class="page-header primaryColor">Trailer</h3>
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
							            <span class="glyphicon glyphicon-chevron-left"></span>
							            <span class="sr-only">Previous</span>
							        </a>
							        <a class="right carousel-control" href="#myCarousel" data-slide="next">
							            <span class="glyphicon glyphicon-chevron-right"></span>
							            <span class="sr-only">Next</span>
							        </a>
							    </div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="col-md-6 col-xs-6">
						<div class="col-md-6 col-xs-6">
							<img style="width: 40px; height: auto;" src="${pageContext.request.contextPath}/resources/img/tmdb-logo.png" alt="TMDB Logo"/>
						</div>
						<div class="col-md-6 col-xs-6" style="margin-top: -15px;">
							<h3 class="voteText">${movie.vote_average}</h3>
						</div>
						<div class="col-md-12 col-xs-12">
							<h6 class="voteText">${movie.vote_count} VOTES</h6>
						</div>
					</div>
					<div class="col-md-6 col-xs-6">
						<div class="col-md-6 col-xs-6">
							<img style="width: 40px; height: auto;" src="${pageContext.request.contextPath}/resources/img/logo.png" alt="TMDB Logo"/>
						</div>
						<div class="col-md-6 col-xs-6" style="margin-top: -15px;">
							<h3 class="voteText">X.X</h3>
						</div>
						<div class="col-md-12 col-xs-12">
							<h6 class="voteText">XXX VOTES</h6>
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
							<img src="${pageContext.request.contextPath}/resources/img/icons/director-logo.png" style="width: 30px; height: auto; margin-left: 6px;"/>
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
								<a href="#" class="filterText">TheMovieDb</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</body>
</html>