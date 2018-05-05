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
import com.cinemind.objects.Cast;
import com.cinemind.objects.Crew;
import com.cinemind.objects.GenreObj;
import com.cinemind.objects.ImageObj;
import com.cinemind.objects.MovieObj;
import com.cinemind.objects.VideoObj;


public class JsonProcess {
	
	public static List<MovieObj> getMoviesFromUrl(String url) throws IOException, JSONException{
		
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		String resultsText = jsonObj.get("results").toString();
		JSONArray jsonResults = new JSONArray(resultsText);
		
		List<MovieObj> tempMovieList = new ArrayList<>();
		
		for(int i=0;i<jsonResults.length();i++) {
			JSONObject tempObj = jsonResults.getJSONObject(i);
			
			int id = tempObj.getInt("id");
			String title = tempObj.getString("original_title");
			String release;
			if(tempObj.get("release_date").getClass().equals(String.class)) {
				release = tempObj.getString("release_date");
			}else {
				release = "unknown";
			}
			String poster,backdrop;
			String imagePrefixPoster= "http://image.tmdb.org/t/p/w342";
			String imagePrefixBackdrop= "http://image.tmdb.org/t/p/w780";
			if(tempObj.get("poster_path").getClass().equals(String.class)) {
				poster = imagePrefixPoster + tempObj.getString("poster_path");
			}else {
				poster= "http://oi63.tinypic.com/2w1yuma.jpg";
			}
			
			if(tempObj.get("backdrop_path").getClass().equals(String.class)) {
				backdrop = imagePrefixBackdrop + tempObj.getString("backdrop_path");
			}else {			
				backdrop="http://oi66.tinypic.com/rgx7pd.jpg";
			}
			MovieObj tempMovie = new MovieObj(id,title,release,poster);
			tempMovie.setBackdrop_path(backdrop);
			tempMovieList.add(tempMovie);
		}
		
		return tempMovieList;
	}
	
	public static int getTotalPage(String url) throws IOException, JSONException {
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		return jsonObj.getInt("total_pages");
		
	}
	
	public static List<MovieObj> getUpcomingFromUrl(String url) throws JSONException, IOException{
				
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		String resultsText = jsonObj.get("results").toString();
		JSONArray jsonResults = new JSONArray(resultsText);
		
		List<MovieObj> tempMovieList = new ArrayList<>();
		
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
				
				if(tempObj.get("poster_path").getClass().equals(String.class)) {
					poster = imagePrefixPoster + tempObj.getString("poster_path");
				}else {
					poster= "http://oi63.tinypic.com/2w1yuma.jpg";
				}
				
				if(tempObj.get("backdrop_path").getClass().equals(String.class)) {
					backdrop = imagePrefixBackdrop + tempObj.getString("backdrop_path");
				}else {
					backdrop="http://oi66.tinypic.com/rgx7pd.jpg";

				}
				MovieObj tempMovie = new MovieObj(id,title,release,poster);
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
        
        return (int)daysDiff+1;
		
	}
	
	public static List<GenreObj> getGenresFromUrl(String url) throws JSONException, IOException{
		
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		String resultText = jsonObj.get("genres").toString();
		JSONArray jsonResults = new JSONArray(resultText);
		
		List<GenreObj> tempGenreList = new ArrayList<>();
		
		for(int i=0;i<jsonResults.length();i++) {
			JSONObject tempObj = jsonResults.getJSONObject(i);
			
			int id= tempObj.getInt("id");
			String title=tempObj.getString("name");
			
			GenreObj tempGenre = new GenreObj(id,title);
			tempGenreList.add(tempGenre);
		}
		
		return tempGenreList;	
		
	}

	public static MovieObj getMovieFromUrl(String url) throws JSONException, IOException{
		
		JSONObject jsonMovie = JsonReader.readJsonObjFromUrl(url);
		
		MovieObj tempMovie = new MovieObj();
		
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
		
		if(jsonMovie.get("poster_path").getClass().equals(String.class)) {
			String poster_path = jsonMovie.getString("poster_path");
			tempMovie.setPoster_path(imagePrefixPoster+poster_path);
		}else {
			tempMovie.setPoster_path("http://oi63.tinypic.com/2w1yuma.jpg");
		}
		
		if(jsonMovie.get("backdrop_path").getClass().equals(String.class)) {
			String backdrop_path = jsonMovie.getString("backdrop_path");
			tempMovie.setBackdrop_path(imagePrefixBackdrop+backdrop_path);
		}else {
			tempMovie.setBackdrop_path("http://oi66.tinypic.com/rgx7pd.jpg");
		}
		
		
		String release_date = jsonMovie.getString("release_date");
		String[] parsedDate= release_date.split("-");
		release_date = parsedDate[2]+"-"+parsedDate[1]+"-"+parsedDate[0];
		tempMovie.setRelease_date(release_date);
		
		tempMovie.setDayLeft(dayLeft(jsonMovie.getString("release_date")));
		
		if(jsonMovie.get("runtime").getClass().equals(Integer.class)) {
			int length = jsonMovie.getInt("runtime");
			tempMovie.setLength(length);
		}else {
			tempMovie.setLength(0);
		}
		
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
		List<GenreObj> genreList= new ArrayList<>();
		for (int i = 0; i < genresJsonArray.length(); i++) {
			JSONObject jsonobject = genresJsonArray.getJSONObject(i);
            GenreObj postcp=JsonReader.parseGenresArray(jsonobject.toString());
            genreList.add(postcp);
		}
		tempMovie.setGenres(genreList);
		
		//get crew
        JSONArray crewJsonArray=JsonReader.getJsonCrew(jsonMovie.getJSONObject("credits").toString());
        List<Crew> crewList =new ArrayList<>();
        for (int i = 0; i < crewJsonArray.length(); i++) {
            JSONObject jsonobject = crewJsonArray.getJSONObject(i);
            Crew postcp=JsonReader.parseCrewArray(jsonobject.toString());
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
        List<Cast> castList =new ArrayList<>();
        for (int i = 0; i < castJsonArray.length(); i++) {
            JSONObject jsonobject = castJsonArray.getJSONObject(i);
            Cast postcp=JsonReader.parseCastArray(jsonobject);
            castList.add(postcp);
        }
        tempMovie.setCastList(castList);
        
		//get videos
        JSONArray videosJsonArray=JsonReader.getJsonVideo(jsonMovie.getJSONObject("videos").toString());
        List<VideoObj> videoList =new ArrayList<>();
        for (int i = 0; i < videosJsonArray.length(); i++) {
            JSONObject jsonobject = videosJsonArray.getJSONObject(i);
            VideoObj postcp=JsonReader.parseVideoArray(jsonobject);
            videoList.add(postcp);
        }
        tempMovie.setVideoList(videoList);
        
		//get images
        JSONArray imagesJsonArray=JsonReader.getJsonImage(jsonMovie.getJSONObject("images").toString());
        List<ImageObj> imageList =new ArrayList<>();
        for (int i = 0; i < imagesJsonArray.length(); i++) {
            JSONObject jsonobject = imagesJsonArray.getJSONObject(i);
            ImageObj postcp=JsonReader.parseImageArray(jsonobject);
            imageList.add(postcp);
        }
        tempMovie.setImageList(imageList);
        
        //get recommended movies
        List<MovieObj> recommendedArray = getMoviesFromUrl("https://api.themoviedb.org/3/movie/"+tempMovie.getId()+"/recommendations?api_key=a092bd16da64915723b2521295da3254&language=en-US");
        
        tempMovie.setRecommendedMovies(recommendedArray);
        
		return tempMovie;
			
	
	}

	public static String getActorName(String url) throws IOException, JSONException {
		JSONObject jsonObj = JsonReader.readJsonObjFromUrl(url);
		
		return jsonObj.getString("name");
		
	}
}
