<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
       	<title>Profile</title>
       	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/texts.css" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/buttons.css" />
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/images.css" />
		
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	    
	    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slider.css" />
		<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/verticalmovie.css" />
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
		
		<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/tables.css" />
		<script src="${pageContext.request.contextPath}/resources/js/movieListTables.js"></script>
		
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
					    			<c:url var="genreLink" value="/movies/genre">
					                 	<c:param name="genreId" value="${genre.id}" />
					                </c:url>
				    				<li><a href="${genreLink}">${genre.title}</a></li>
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
         					<li class="active"><a href="#" onclick="window.location.href='profile'; return false;"><span class="glyphicon glyphicon-user" style="color: #ff4d4d"></span> <c:out value = "${loginedUser.username}"/></a></li>
                        	<li><a href="#" onclick="window.location.href='logout'; return false;"><span class="glyphicon glyphicon-log-out" style="color: #ff4d4d"></span> Logout</a></li>
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
						<a href="#" class="profileNavBtn profileActivePage">PROFILE</a>
						<a href="#" class="profileNavBtn">EDIT PROFILE</a>
						<a href="#" class="profileNavBtn">PASSWORD</a>
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
							                        <th><input type="text" class="form-control" placeholder="#" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Title" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Release Date" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <tr>
							                        <td>299536</td>
							                        <td>Avengers: Infinity War</td>
							                        <td>25-04-2018</td>
							                        <td class="text-center"><a href="#" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span> Del</a></td>
							                    </tr>
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
							                        <th><input type="text" class="form-control" placeholder="#" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Title" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Release Date" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <tr>
							                        <td>299536</td>
							                        <td>Avengers: Infinity War</td>
							                        <td>25-04-2018</td>
							                        <td class="text-center"><a href="#" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span> Del</a></td>
							                    </tr>
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
							                        <th><input type="text" class="form-control" placeholder="#" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Title" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Release Date" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <tr>
							                        <td>299536</td>
							                        <td>Avengers: Infinity War</td>
							                        <td>25-04-2018</td>
							                        <td class="text-center"><a href="#" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span> Del</a></td>
							                    </tr>
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
							                        <th><input type="text" class="form-control" placeholder="Movie Title" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Review" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Reviewed At" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <tr>
							                        <td>Avengers: Civil War</td>
							                        <td>It was good.</td>
							                        <td>10-02-2018 10:12:48</td>
							                        <td class="text-center"><a href="#" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span> Del</a></td>
							                    </tr>
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
							                        <th><input type="text" class="form-control" placeholder="Activity" disabled></th>
							                        <th><input type="text" class="form-control" placeholder="Happened At" disabled></th>
							                        <th>Action</th>
							                    </tr>
							                </thead>
							                <tbody>
							                    <tr>
							                        <td>You reviewed Avengers: Infinity War.</td>
							                        <td>10-02-2018 10:12:48</td>
							                        <td class="text-center"><a href="#" class="btn btn-danger btn-xs"><span class="glyphicon glyphicon-remove"></span> Del</a></td>
							                    </tr>
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
    </body>
</html>