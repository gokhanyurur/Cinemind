<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Cinemind</title>
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/navbar.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/texts.css" />
	
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slider.css" />
	<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
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
                        <li class="active"><a href="/cinemind">Home</a></li>
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
					<div class="col-md-8">
						<div class="row">
							<div class='col-md-6'>						
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
							          <img src="https://image.tmdb.org/t/p/w500/dqaUwCBK2Omdy5RRzTk6oBrP18p.jpg" alt="...">
							          <div class="carousel-caption">
							            <h5>Movie Name</h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="http://placehold.it/500x281" alt="...">
							          <div class="carousel-caption">
							            <h5>Movie Name</h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="http://placehold.it/500x281" alt="...">
							          <div class="carousel-caption">
							            <h5>Movie Name</h5>
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
					    <div class='col-md-6'>						
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
							          <img src="http://placehold.it/500x281" alt="...">
							          <div class="carousel-caption">
							            <h5>Movie Name</h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="http://placehold.it/500x281" alt="...">
							          <div class="carousel-caption">
							            <h5>Movie Name</h5>
							          </div>
							        </div>
							        <div class="item">
							          <img src="http://placehold.it/500x281" alt="...">
							          <div class="carousel-caption">
							            <h5>Movie Name</h5>
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
						<div class="row" style="padding-left: 15px; padding-right: 15px;">
			            	<div class="page-header">
							  <h3 style="color: #FF4D4D; font-weight: normal;">Most Popular</h3>
							</div>
							
						</div>
					</div>
				    <div class="col-md-4">
				    	asdasd <br><br>
				    	asdasd <br><br>
				    	asdasd <br><br>
				    	asdasd <br><br>
				    	asdasd <br><br>
				    	asdasd <br><br>
				    	asdasd <br><br>
				    	asdasd <br><br>
				    </div>        		
           		</div>
                <div class="row">
                	<div class="col-md-3" style="background-color: deeppink" >
                    	Index Page
                        	<br>
                        Index Page
                        <br>
                        Index Page
                        <br>
                    </div>
                    <div class="col-md-9" style="background-color:darkorchid" >
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                            Index Page 2<br>
                    </div>
                </div>
            </div>
        </div>
</body>
</html>