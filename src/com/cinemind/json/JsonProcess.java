package com.cinemind.json;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.cinemind.objects.genreObj;
import com.cinemind.objects.movieObj;

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
			String poster;
			String imagePrefix= "http://image.tmdb.org/t/p/w185";
			if(!tempObj.get("poster_path").getClass().equals(String.class)) {
				poster="null";
			}else {
				poster = imagePrefix + tempObj.getString("poster_path");
			}
			movieObj tempMovie = new movieObj(id,title,release,poster);
			tempMovie.setBackdrop_path("http://image.tmdb.org/t/p/w300"+tempObj.getString("backdrop_path"));
			tempMovieList.add(tempMovie);
		}
		
		return tempMovieList;
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

}
