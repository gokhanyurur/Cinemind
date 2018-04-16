package com.cinemind.json;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.joda.time.Days;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.cinemind.objects.Country;
import com.cinemind.objects.cast;
import com.cinemind.objects.crew;
import com.cinemind.objects.genreObj;
import com.cinemind.objects.image;
import com.cinemind.objects.movieObj;
import com.cinemind.objects.video;


public class JsonProcess {
	
	public static List<movieObj> getMoviesFromUrl(String url) throws IOException, JSONException{
		
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		String resultsText = jsonObj.get("results").toString();
		JSONArray jsonResults = new JSONArray(resultsText);
		
		List<movieObj> tempMovieList = new ArrayList<>();
		
		for(int i=0;i<jsonResults.length();i++) {
			JSONObject tempObj = jsonResults.getJSONObject(i);
			
			int id = tempObj.getInt("id");
			String title = tempObj.getString("original_title");
			String release = tempObj.getString("release_date");
			String poster,backdrop;
			String imagePrefixPoster= "http://image.tmdb.org/t/p/w342";
			String imagePrefixBackdrop= "http://image.tmdb.org/t/p/w780";
			if(!tempObj.get("poster_path").getClass().equals(String.class)) {
				//poster="null";
				poster= "http://placehold.it/342x513";
			}else {
				poster = imagePrefixPoster + tempObj.getString("poster_path");
			}
			
			if(!tempObj.get("backdrop_path").getClass().equals(String.class)) {
				//backdrop="null";
				backdrop="http://placehold.it/780x439";
			}else {
				backdrop = imagePrefixBackdrop + tempObj.getString("backdrop_path");
			}
			movieObj tempMovie = new movieObj(id,title,release,poster);
			tempMovie.setBackdrop_path(backdrop);
			tempMovieList.add(tempMovie);
		}
		
		return tempMovieList;
	}
	
	public static List<movieObj> getUpcomingFromUrl(String url) throws JSONException, IOException{
				
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		String resultsText = jsonObj.get("results").toString();
		JSONArray jsonResults = new JSONArray(resultsText);
		
		List<movieObj> tempMovieList = new ArrayList<>();
		
		for(int i=0;i<jsonResults.length();i++) {
			JSONObject tempObj = jsonResults.getJSONObject(i);
			
			if(dayLeft(tempObj.getString("release_date"))>0) {
				int id = tempObj.getInt("id");
				String title = tempObj.getString("original_title");
				String release = tempObj.getString("release_date");
				String poster,backdrop;
				String imagePrefixPoster= "http://image.tmdb.org/t/p/w342";
				String imagePrefixBackdrop= "http://image.tmdb.org/t/p/w780";
				int dayLeft = dayLeft(release);
				
				if(!tempObj.get("poster_path").getClass().equals(String.class)) {
					//poster="null";
					poster= "http://placehold.it/342x513";
				}else {
					poster = imagePrefixPoster + tempObj.getString("poster_path");
				}
				
				if(!tempObj.get("backdrop_path").getClass().equals(String.class)) {
					//backdrop="null";
					backdrop="http://placehold.it/780x439";
				}else {
					backdrop = imagePrefixBackdrop + tempObj.getString("backdrop_path");
				}
				movieObj tempMovie = new movieObj(id,title,release,poster);
				tempMovie.setBackdrop_path(backdrop);
				tempMovie.setDayLeft(dayLeft);
				tempMovieList.add(tempMovie);
			}
		}
		
		return tempMovieList;
	}
	
	public static int dayLeft(String releaseDate) {
		
		String[] releaseDateArray = releaseDate.split("-");
		
        int year = Integer.parseInt(releaseDateArray[0]);
        int month = Integer.parseInt(releaseDateArray[1]);
        int day = Integer.parseInt(releaseDateArray[2]);

        Date today = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(today);

        Calendar cal2 = Calendar.getInstance();
        cal2.set(year, month - 1, day, 0, 0);

        long msDiff =cal2.getTimeInMillis()-  cal.getInstance().getTimeInMillis();
        long daysDiff = TimeUnit.MILLISECONDS.toDays(msDiff);
        
        return (int)daysDiff;
		
	}
	
	public static List<genreObj> getGenresFromUrl(String url) throws JSONException, IOException{
		
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		String resultText = jsonObj.get("genres").toString();
		JSONArray jsonResults = new JSONArray(resultText);
		
		List<genreObj> tempGenreList = new ArrayList<>();
		
		for(int i=0;i<jsonResults.length();i++) {
			JSONObject tempObj = jsonResults.getJSONObject(i);
			
			int id= tempObj.getInt("id");
			String title=tempObj.getString("name");
			
			genreObj tempGenre = new genreObj(id,title);
			tempGenreList.add(tempGenre);
		}
		
		return tempGenreList;	
		
	}

	public static movieObj getMovieFromUrl(String url) throws JSONException, IOException{
		
		JSONObject jsonMovie = JsonReader.readJsonObjFromUrl(url);
		
		movieObj tempMovie = new movieObj();
		
		int id = jsonMovie.getInt("id");
		tempMovie.setId(id);
		
		String title = jsonMovie.getString("title");
		tempMovie.setTitle(title);
		
		String overview = jsonMovie.getString("overview");
		tempMovie.setOverview(overview);
		
		String status = jsonMovie.getString("status");
		tempMovie.setStatus(status);
		
		String tagline = jsonMovie.getString("tagline");
		tempMovie.setTagline(tagline);
				
		Double vote_average = jsonMovie.getDouble("vote_average");
		tempMovie.setVote_average(vote_average);
		
		int vote_count = jsonMovie.getInt("vote_count");
		tempMovie.setVote_count(vote_count);
		
		String imagePrefixPoster= "http://image.tmdb.org/t/p/w300";
		String imagePrefixBackdrop= "http://image.tmdb.org/t/p/w1280";
		
		if(!jsonMovie.get("poster_path").getClass().equals(String.class)) {
			//tempMovie.setPoster_path("null");
			tempMovie.setPoster_path("http://placehold.it/342x513");
		}else {
			String poster_path = jsonMovie.getString("poster_path");
			tempMovie.setPoster_path(imagePrefixPoster+poster_path);
		}
		
		if(!jsonMovie.get("backdrop_path").getClass().equals(String.class)) {
			//tempMovie.setBackdrop_path("null");
			tempMovie.setBackdrop_path("http://placehold.it/780x439");
		}else {
			String backdrop_path = jsonMovie.getString("backdrop_path");
			tempMovie.setBackdrop_path(imagePrefixBackdrop+backdrop_path);
		}
		
		
		String release_date = jsonMovie.getString("release_date");
		String[] parsedDate= release_date.split("-");
		release_date = parsedDate[2]+"-"+parsedDate[1]+"-"+parsedDate[0];
		tempMovie.setRelease_date(release_date);
		
		int length = jsonMovie.getInt("runtime");
		tempMovie.setLength(length);	
		
		long budget = jsonMovie.getLong("budget");
		tempMovie.setBudget(budget);
		
		long revenue = jsonMovie.getLong("revenue");
		tempMovie.setRevenue(revenue);
		
		//get countries
		JSONArray countriesJsonArray = jsonMovie.getJSONArray("production_countries");
		List<Country> countryList= new ArrayList<>();
		for (int i = 0; i < countriesJsonArray.length(); i++) {
			JSONObject jsonobject = countriesJsonArray.getJSONObject(i);
            Country postcp=JsonReader.parseCountryArray(jsonobject);
            countryList.add(postcp);
		}
		tempMovie.setCountries(countryList);
		tempMovie.setCountryString(JsonReader.getAllCountries(tempMovie.getCountries()));
		
		//get genres
		JSONArray genresJsonArray = jsonMovie.getJSONArray("genres");
		List<genreObj> genreList= new ArrayList<>();
		for (int i = 0; i < genresJsonArray.length(); i++) {
			JSONObject jsonobject = genresJsonArray.getJSONObject(i);
            genreObj postcp=JsonReader.parseGenresArray(jsonobject.toString());
            genreList.add(postcp);
		}
		tempMovie.setGenres(genreList);
		
		//get crew
        JSONArray crewJsonArray=JsonReader.getJsonCrew(jsonMovie.getJSONObject("credits").toString());
        List<crew> crewList =new ArrayList<>();
        for (int i = 0; i < crewJsonArray.length(); i++) {
            JSONObject jsonobject = crewJsonArray.getJSONObject(i);
            crew postcp=JsonReader.parseCrewArray(jsonobject.toString());
            crewList.add(postcp);
        }
        tempMovie.setCrewList(crewList);
        
        String director = JsonReader.getDirector(tempMovie.getCrewList());
        tempMovie.setDirector(director);
        
        String writer = JsonReader.getWriter(tempMovie.getCrewList());
        tempMovie.setWriter(writer);
        
        String music = JsonReader.getMusic(tempMovie.getCrewList());
        tempMovie.setMusic(music);
        
		//get cast
        JSONArray castJsonArray=JsonReader.getJsonCast(jsonMovie.getJSONObject("credits").toString());
        List<cast> castList =new ArrayList<>();
        for (int i = 0; i < castJsonArray.length(); i++) {
            JSONObject jsonobject = castJsonArray.getJSONObject(i);
            cast postcp=JsonReader.parseCastArray(jsonobject);
            castList.add(postcp);
        }
        tempMovie.setCastList(castList);
        
		//get videos
        JSONArray videosJsonArray=JsonReader.getJsonVideo(jsonMovie.getJSONObject("videos").toString());
        List<video> videoList =new ArrayList<>();
        for (int i = 0; i < videosJsonArray.length(); i++) {
            JSONObject jsonobject = videosJsonArray.getJSONObject(i);
            video postcp=JsonReader.parseVideoArray(jsonobject);
            videoList.add(postcp);
        }
        tempMovie.setVideoList(videoList);
        
		//get images
        JSONArray imagesJsonArray=JsonReader.getJsonImage(jsonMovie.getJSONObject("images").toString());
        List<image> imageList =new ArrayList<>();
        for (int i = 0; i < imagesJsonArray.length(); i++) {
            JSONObject jsonobject = imagesJsonArray.getJSONObject(i);
            image postcp=JsonReader.parseImageArray(jsonobject);
            imageList.add(postcp);
        }
        tempMovie.setImageList(imageList);
        
        //get recommended movies
        List<movieObj> recommendedArray = getMoviesFromUrl("https://api.themoviedb.org/3/movie/"+tempMovie.getId()+"/recommendations?api_key=a092bd16da64915723b2521295da3254&language=en-US");
        
        tempMovie.setRecommendedMovies(recommendedArray);
        
		return tempMovie;
			
	
	}
}
