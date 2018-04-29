<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Results</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/texts.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/buttons.css" />
	
	<link href="https://use.fontawesome.com/releases/v5.0.9/css/all.css" rel="stylesheet">
	
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slider.css" />
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/verticalmovie.css" />
	<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/recommendedmovies.css" />
	<script src="${pageContext.request.contextPath}/resources/js/recommendedmovies.jsp"></script>
	
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/starRating.css" />
	
	
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
                        <li class="active"><a href="/cinemind/movies">Movies</a></li>  
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
                        	<li><a href="/cinemind/logout" onclick="window.location.href='logout'; return false;"><span class="glyphicon glyphicon-log-out" style="color: #ff4d4d"></span> Logout</a></li>
     					</c:if>
                    </ul>
                </div>
            </nav>
	</div>
	<div class="row" style="margin-top: -40px; background-color: #e5e5e5">
		<div class="container" style="padding: 30px; background-color: white">
        	<div class="row">
            	<div class="col-md-12" style="margin-top: -20px;">
            		<div class="col-md-12">
            			<div class="page-header" style="padding-bottom: 0px;">
							<h3 style="color: #FF4D4D; font-weight: normal;">Results found: ${param.q}</h3>
						</div>
            		</div>
            		<c:if test="${fn:length(searchResultList) < 1}">
            			<div class="col-md-12" style="min-height: 630px;">
            				<h3>We are sorry we could not find any result for : ${param.q}</h3>
            			</div>	
            		</c:if>
					<div class="col-md-12 hidden-xs hidden-sm" style="min-height: 630px;">
            			<ul class="thumbnails" style="margin-left: -50px;"> 
	            			<c:forEach var="tempMovie" items="${searchResultList}">
			                	<c:url var="movieLink" value="/movies/viewMovie">
			                    	<c:param name="movieId" value="${tempMovie.id}" />
			                    </c:url>
								<li class="col-sm-2" style="height: 290px;">
									<div class="fff">
										<a class="rec-image" href="${movieLink}"><img src="${tempMovie.poster_path}" alt=""></a>
								    	<h5 style="text-align: center; width: 100%;">${tempMovie.title}</h5>
									</div>
								</li>
			                </c:forEach>
			        	</ul>
            		</div>
					<div class="col-xs-12 hidden-md hidden-lg">
			        	<c:forEach var="tempMovie" items="${searchResultList}">
							<c:url var="movieLink" value="/movies/viewMovie">
				            	<c:param name="movieId" value="${tempMovie.id}"></c:param>
				            </c:url>
									<div class="col-md-3" style="padding-bottom: 20px;">
										<a href="${movieLink}">
											<img src="${tempMovie.poster_path}" alt="${tempMovie.title}" class="img-responsive">
										</a>
										<div class="ss-item-text" style="text-align: center;">
											<h5>${tempMovie.title}</h5>
									    </div>			    
									</div>
						</c:forEach>
					</div>
            	</div>
			</div>
			<c:if test="${(fn:length(searchResultList) > 0) and (totalPages > 1)}">
				<div class="row">
					<div class="col-md-12" align="center">
						<a href="/cinemind/search?page=1&q=${param.q}" class="pageText" style="margin-right: 5px;">1</a>
						<c:if test="${param.page > 5}">
							<label class="pageTextNoLink" style="margin-right: 5px;">...</label>
						</c:if>
				    	<c:forEach var="i" begin="2" end="${totalPages}" step="1">
							<c:url var="pageLink" value="/search?q=${param.q}">
					        	<c:param name="page" value="${i}"></c:param>
					        </c:url>
							<c:if test="${(i>param.page-3) and (i < param.page+3)}">
								<c:if test="${i == param.page}">
									<a href="${pageLink}" class="pageText-active" style="margin-right: 5px;">${i}</a>
								</c:if>
								<c:if test="${(i != param.page) and (i<totalPages)}">
									<a href="${pageLink}" class="pageText" style="margin-right: 5px;">${i}</a>
								</c:if>
							</c:if>
							<c:if test="${i == param.page+5}">
								<label class="pageTextNoLink" style="margin-right: 5px;">...</label>
							</c:if>
						</c:forEach>
						<c:if test="${param.page != totalPages}">
							<a href="/cinemind/search?page=${totalPages}&q=${param.q}" class="pageText" style="margin-right: 5px;">${totalPages}</a>
						</c:if>	
					</div>
				</div>
			</c:if>
		</div>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>