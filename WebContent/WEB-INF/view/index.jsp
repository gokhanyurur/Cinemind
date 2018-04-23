<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Cinemind</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/texts.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/buttons.css" />
	
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slider.css" />
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/verticalmovie.css" />
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recommendedmovies.css" />
	<script src="${pageContext.request.contextPath}/resources/js/recommendedmovies.jsp"></script>
	
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
                        <li class="active"><a href="/cinemind">Home</a></li>
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Genres <span class="caret"></span></a>
							<ul class="dropdown-menu" role="menu">
								<c:forEach var="genre" items="${genreList}">
								<!-- 
					    			<c:url var="genreLink" value="/movies/genre">
					                 	<c:param name="genreId" value="${genre.id}" />
					                </c:url>
				    				<li><a href="${genreLink}">${genre.title}</a></li>
				    				-->
				    				<li><a href="/cinemind/movies/genre/${fn:replace(fn:toLowerCase(genre.title),' ', '')}">${genre.title}</a></li>
				    			</c:forEach>
							</ul>
						</li>
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
        <div class="row" style="margin-top: -20px; background-color: #e5e5e5">
        	<div class="container" style="background-color: white">
           		<div class="row">
           			<div class="col-md-12" style="text-align: center;">
           				<div class="page-header" style="margin-top: 20px;">
           					<a href="#" class="indexAlphabet"> # </a>
           						<c:url var="movieStartLetter" value="/search">
			                    	<c:param name="movieStartWith" value="${9}"></c:param>
			                    </c:url>
	           				<a href="${movieStartLetter}" class="indexAlphabet"> 0-9 </a>
	           				<c:forEach var="i" begin="65" end="90">
	           					<c:url var="movieStartLetter" value="/search">
			                    	<c:param name="movieStartWith" value="${i}"></c:param>
			                    </c:url>
	           					<a href="${movieStartLetter}" class="indexAlphabet">
							    	<%=Character.toChars((Integer)pageContext.getAttribute("i"))%>
							    </a>
							</c:forEach>
           				</div>
           			</div>
           		</div>
           		<div class="row" style="padding-bottom: 10px;">
					<div class="col-md-9">
						<div class="row">
							<div class='col-md-6' style="padding-bottom: 10px;">						
							    <div id="carousel-example-generic1" class="carousel slide" data-ride="carousel">
							      <!-- Indicators -->
							      <ol class="carousel-indicators">
							        <li data-target="#carousel-example-generic1" data-slide-to="0" class="active"></li>
							        <li data-target="#carousel-example-generic1" data-slide-to="1"></li>
							        <li data-target="#carousel-example-generic1" data-slide-to="2"></li>
							      </ol>
							
							      <!-- Wrapper for slides -->
							      <div class="carousel-inner">
							        <div class="item active">
							          <img src="${nowPlaying[31].backdrop_path}" alt="...">
							          <div class="carousel-caption">
							            <h5><a href="/cinemind/movies/viewMovie?movieId=${nowPlaying[31].id}" class="movieTitleSmall">${nowPlaying[31].title}</a></h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="${nowPlaying[32].backdrop_path}" alt="...">
							          <div class="carousel-caption">
							            <h5><a href="/cinemind/movies/viewMovie?movieId=${nowPlaying[32].id}" class="movieTitleSmall">${nowPlaying[32].title}</a></h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="${nowPlaying[33].backdrop_path}" alt="...">
							          <div class="carousel-caption">
							            <h5><a href="/cinemind/movies/viewMovie?movieId=${nowPlaying[33].id}" class="movieTitleSmall">${nowPlaying[33].title}</a></h5>
							          </div>
							        </div>
							      </div>
							
							      <!-- Controls -->
							      <a class="left carousel-control" href="#carousel-example-generic1" data-slide="prev">
							        <span class="glyphicon glyphicon-chevron-left"></span>
							      </a>
							      <a class="right carousel-control" href="#carousel-example-generic1" data-slide="next">
							        <span class="glyphicon glyphicon-chevron-right"></span>
							      </a>
							    </div>    
					    	</div>
					    	<div class='col-md-6' style="padding-bottom: 10px;">						
							    <div id="carousel-example-generic2" class="carousel slide" data-ride="carousel">
							      <!-- Indicators -->
							      <ol class="carousel-indicators">
							        <li data-target="#carousel-example-generic2" data-slide-to="0" class="active"></li>
							        <li data-target="#carousel-example-generic2" data-slide-to="1"></li>
							        <li data-target="#carousel-example-generic2" data-slide-to="2"></li>
							      </ol>
							
							      <!-- Wrapper for slides -->
							      <div class="carousel-inner">
							        <div class="item active">
							          <img src="${nowPlaying[34].backdrop_path}" alt="...">
							          <div class="carousel-caption">
							            <h5><a href="/cinemind/movies/viewMovie?movieId=${nowPlaying[34].id}" class="movieTitleSmall">${nowPlaying[34].title}</a></h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="${nowPlaying[35].backdrop_path}" alt="...">
							          <div class="carousel-caption">
							            <h5><a href="/cinemind/movies/viewMovie?movieId=${nowPlaying[35].id}" class="movieTitleSmall">${nowPlaying[35].title}</a></h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="${nowPlaying[36].backdrop_path}" alt="...">
							          <div class="carousel-caption">
							            <h5><a href="/cinemind/movies/viewMovie?movieId=${nowPlaying[36].id}" class="movieTitleSmall">${nowPlaying[36].title}</a></h5>
							          </div>
							        </div>
							      </div>
							
							      <!-- Controls -->
							      <a class="left carousel-control" href="#carousel-example-generic2" data-slide="prev">
							        <span class="glyphicon glyphicon-chevron-left"></span>
							      </a>
							      <a class="right carousel-control" href="#carousel-example-generic2" data-slide="next">
							        <span class="glyphicon glyphicon-chevron-right"></span>
							      </a>
							    </div>    
					    	</div>
						</div>
						<div class="row" style="padding-left: 15px; padding-right: 15px; margin-top: -20px;">
							<!-- Now playing for desktop -->
							<div class="col-md-12 col-lg-12 hidden-xs hidden-sm" style="height: 450px;">
								<div class="page-header">
									<h3 style="color: #FF4D4D; font-weight: normal; padding-left: 5px; margin-bottom: 0px;">Now Playing</h3>
								</div>
									<ul class="control-box pager" style="margin-left: -10px; margin-top: -55px;">
										<li><a data-slide="prev" href="#myCarouselnowP" class=""><i class="glyphicon glyphicon-chevron-left" style="color:#FF4D4D;"></i></a></li>
										<li><a data-slide="next" href="#myCarouselnowP" class=""><i class="glyphicon glyphicon-chevron-right" style="color:#FF4D4D;"></i></li>
									</ul>
								</nav>	
								<div class="carousel slide" id="myCarouselnowP" style="margin-left: -45px; margin-top: 30px;">
									<div class="carousel-inner">
							    		<c:forEach varStatus="status" var="i" begin="0" end="${fn:length(nowPlaying)}" step="4">
											<c:if test="${i == 0}">
												<div class="item active">
								            		<ul class="thumbnails">
								                		<li class="col-sm-3">
								    						<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i].id}"><img src="${nowPlaying[i].poster_path}" alt=""></a>
																<h5 style="text-align: center; width: 100%;">${nowPlaying[i].title}</h5>
								                       		</div>
								                    	</li>
								                    	<li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i+1].id}"><img src="${nowPlaying[i+1].poster_path}" alt=""></a>
								                       			<h5 style="text-align: center; width: 100%;">${nowPlaying[i+1].title}</h5>
								                       		</div>
								                    	</li>
								                    	<li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i+2].id}"><img src="${nowPlaying[i+2].poster_path}" alt=""></a>
								                        		<h5 style="text-align: center; width: 100%;">${nowPlaying[i+2].title}</h5>
								                        	</div>
								                    	</li>
								                    	<li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i+3].id}"><img src="${nowPlaying[i+3].poster_path}" alt=""></a>
									                        	<h5 style="text-align: center; width: 100%;">${nowPlaying[i+3].title}</h5>
									                        </div>
								                    	</li>
								             		</ul>
								            	</div>
										  	</c:if>
										  	<c:if test="${i > 0 && i < fn:length(nowPlaying)-8}">
										  		<div class="item">
								                    <ul class="thumbnails">
								                        <li class="col-sm-3">
								    						<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i].id}"><img src="${nowPlaying[i].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${nowPlaying[i].title}</h5>
								                            </div>
								                        </li>
								                        <li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i+1].id}"><img src="${nowPlaying[i+1].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${nowPlaying[i+1].title}</h5>
								                            </div>
								                        </li>
								                        <li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i+2].id}"><img src="${nowPlaying[i+2].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${nowPlaying[i+2].title}</h5>
								                            </div>
								                        </li>
								                        <li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${nowPlaying[i+3].id}"><img src="${nowPlaying[i+3].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${nowPlaying[i+3].title}</h5>
								                            </div>
								                        </li>
								                    </ul>
								              	</div>
											</c:if>
										</c:forEach>			            
							        </div>		                              
							    </div>
							</div>
							<!-- Now playing for mobile -->
							<div class="col-xs-12 hidden-md hidden-lg">
								<div class="page-header">
								  <h3 style="color: #FF4D4D; font-weight: normal; padding-left: 5px; margin-bottom: 0px;">Now Playing</h3>
								</div>
								<c:forEach var="i" begin="0" end="${fn:length(nowPlaying)}">
									<c:url var="nowPlayingLink" value="/movies/viewMovie">
				                    	<c:param name="movieId" value="${nowPlaying[i].id}"></c:param>
				                    </c:url>
									<div class="col-md-3" style="padding-bottom: 20px;">
										<a href="${nowPlayingLink}">
											<img src="${nowPlaying[i].poster_path}" alt="${nowPlaying[i].title}" class="img-responsive">
										</a>
										<div class="ss-item-text" style="text-align: center;">
											<h5>${nowPlaying[i].title}</h5>
									    </div>			    
									</div>
								</c:forEach>
							</div>		
						</div>
						<div class="row" style="padding-left: 15px; padding-right: 15px;">
						<!-- Upcoming for desktop -->
							<div class="col-md-12 col-lg-12 hidden-xs hidden-sm" style="height: 450px; margin-top: -50px;">
								<div class="page-header">
									<h3 style="color: #FF4D4D; font-weight: normal; padding-left: 5px; margin-bottom: 0px;">Upcoming</h3>
								</div>
									<ul class="control-box pager" style="margin-left: -10px; margin-top: -55px;">
										<li><a data-slide="prev" href="#myCarouselupC" class=""><i class="glyphicon glyphicon-chevron-left" style="color:#FF4D4D;"></i></a></li>
										<li><a data-slide="next" href="#myCarouselupC" class=""><i class="glyphicon glyphicon-chevron-right" style="color:#FF4D4D;"></i></li>
									</ul>
								</nav>
								<div class="carousel slide" id="myCarouselupC" style="margin-left: -45px; margin-top: 30px;">
									<div class="carousel-inner">
							    		<c:forEach varStatus="status" var="i" begin="0" end="${fn:length(upcomingList)}" step="4">
											<c:if test="${i == 0}">
												<div class="item active">
								            		<ul class="thumbnails">
								                		<li class="col-sm-3">
								    						<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i].id}"><img src="${upcomingList[i].poster_path}" alt=""></a>
																<h5 style="text-align: center; width: 100%;">${upcomingList[i].title}</h5>
								                       		</div>
								                    	</li>
								                    	<li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i+1].id}"><img src="${upcomingList[i+1].poster_path}" alt=""></a>
								                       			<h5 style="text-align: center; width: 100%;">${upcomingList[i+1].title}</h5>
								                       		</div>
								                    	</li>
								                    	<li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i+2].id}"><img src="${upcomingList[i+2].poster_path}" alt=""></a>
								                        		<h5 style="text-align: center; width: 100%;">${upcomingList[i+2].title}</h5>
								                        	</div>
								                    	</li>
								                    	<li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i+3].id}"><img src="${upcomingList[i+3].poster_path}" alt=""></a>
									                        	<h5 style="text-align: center; width: 100%;">${upcomingList[i+3].title}</h5>
									                        </div>
								                    	</li>
								             		</ul>
								            	</div>
										  	</c:if>
										  	<c:if test="${i > 0 && i < fn:length(upcomingList)}">
										  		<div class="item">
								                    <ul class="thumbnails">
								                        <li class="col-sm-3">
								    						<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i].id}"><img src="${upcomingList[i].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${upcomingList[i].title}</h5>
								                            </div>
								                        </li>
								                        <li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i+1].id}"><img src="${upcomingList[i+1].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${upcomingList[i+1].title}</h5>
								                            </div>
								                        </li>
								                        <li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i+2].id}"><img src="${upcomingList[i+2].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${upcomingList[i+2].title}</h5>
								                            </div>
								                        </li>
								                        <li class="col-sm-3">
															<div class="fff">
																<a class="rec-image" href="/cinemind/movies/viewMovie?movieId=${upcomingList[i+3].id}"><img src="${upcomingList[i+3].poster_path}" alt=""></a>
								                            	<h5 style="text-align: center; width: 100%;">${upcomingList[i+3].title}</h5>
								                            </div>
								                        </li>
								                    </ul>
								              	</div>
											</c:if>
										</c:forEach>			            
							        </div>			                              
							    </div>
							</div>
						
						<!-- Upcoming for mobile -->
							<div class="col-xs-12 hidden-md hidden-lg">
						    	<div class="page-header">
									<h3 style="color: #FF4D4D; font-weight: normal; padding-left: 5px; margin-bottom: 0px;">Upcoming</h3>
								</div>
			                    <c:forEach var="i" begin="0" end="${fn:length(upcomingList)}">
									<c:url var="upcomingLink" value="/movies/viewMovie">
				                    	<c:param name="movieId" value="${upcomingList[i].id}"></c:param>
				                    </c:url>
									<div class="col-md-3" style="padding-bottom: 20px;">
										<a href="${upcomingLink}">
											<img src="${upcomingList[i].poster_path}" alt="${upcomingList[i].title}" class="img-responsive">
										</a>
										<!--  -->
										<div class="ss-item-text" style="text-align: center;">
											<h5>${upcomingList[i].title} - ${upcomingList[i].dayLeft} days left</h5>
									    </div>			    
									</div>
								</c:forEach>
							</div>
               			</div>
					</div>
				    <div class="col-md-3" style="padding-left: 20px;">
				    <!-- Filter -->
				    	<div class="col-md-12">
				    		<div class="row">
				    			<h5 class="filterTitle">Genres</h5>
				    		</div>
				    		<div class="row">
				    			<c:forEach var="genre" items="${genreList}">
				    				<div class="col-md-12" style="padding-bottom: 5px;">
				    				<!-- 
					    			<c:url var="genreLink" value="/movies/genre">
					                 	<c:param name="genreId" value="${genre.id}" />
					                </c:url>     
				    					<a href="${genreLink}" class="filterText">${genre.title}</a>-->
				    					<a href="/cinemind/movies/genre/${fn:replace(fn:toLowerCase(genre.title),' ', '')}" class="filterText">${genre.title}</a>
				    				</div>
				    			</c:forEach>
				    		</div>
				    	</div>
				    	<div class="col-md-12">
				    		<div class="row">
				    			<h5 class="filterTitle">Release Date</h5>
				    			<div class="col-md-12">
				    				<jsp:useBean id="now" class="java.util.Date" />
									<fmt:formatDate var="year" value="${now}" pattern="yyyy" />
				    				<c:forEach var="i" begin="0" end="26" step="1">
				    				<!--  
				    					<c:url var="yearLink" value="/movies/byYear">
					                    	<c:param name="year" value="${year-i}"></c:param>
					                    </c:url>
									   <a href="${yearLink}" style="text-decoration:none;">
									   		<button class="filterYearBt"><c:out value="${2018-i}"/></button>
									   </a>
									   -->
									   <a href="/cinemind/movies/release/${2018-i}" style="text-decoration:none;">
									   		<button class="filterYearBt"><c:out value="${2018-i}"/></button>
									   </a>
									</c:forEach>
				    			</div>
				    		</div>
				    	</div>
				    	<div class="col-md-12">
				    		<div class="row">
				    			<h5 class="filterTitle">Short By</h5>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Popularity Descending</a>
				    			</div>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Popularity Ascending</a>
				    			</div>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Rating Descending</a>
				    			</div>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Rating Ascending</a>
				    			</div>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Release Date Descending</a>
				    			</div>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Release Date Ascending</a>
				    			</div>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Title (A-Z)</a>
				    			</div>
				    		</div>
				    		<div class="row">
				    			<div class="col-md-12" style="padding-bottom: 5px;">
				    				<a href="#" class="filterText">Title (Z-A)</a>
				    			</div>
				    		</div>
				    	</div>
				    </div>        		
           		</div>
            </div>
        </div>
</body>
</html>