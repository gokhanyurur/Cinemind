package com.cinemind.json;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Reader;
import java.net.URL;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.cinemind.objects.movieObj;

public class JsonReader {

  private static String readAll(Reader rd) throws IOException {
    StringBuilder sb = new StringBuilder();
    int cp;
    while ((cp = rd.read()) != -1) {
      sb.append((char) cp);
    }
    return sb.toString();
  }

  public static JSONObject readJsonObjFromUrl(String url) throws IOException, JSONException {
    InputStream is = new URL(url).openStream();
    try {
      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
      String jsonText = readAll(rd);
      JSONObject json = new JSONObject(jsonText);
      return json;
    } finally {
      is.close();
    }
  }
  
  public static JSONArray readJsonArrayFromUrl(String url) throws IOException, JSONException {
	    InputStream is = new URL(url).openStream();
	    try {
	      BufferedReader rd = new BufferedReader(new InputStreamReader(is, Charset.forName("UTF-8")));
	      String jsonText = readAll(rd);
	      JSONArray jsonArray = new JSONArray(jsonText);
	      return jsonArray;
	    } finally {
	      is.close();
	    }
  }
  
  public static List<movieObj> jsonArrayToList(JSONArray jsonArray) throws IOException, JSONException {
		List<movieObj> tempList = new ArrayList<>();
		
		for(int i=0;i<jsonArray.length();i++) {
			JSONObject tempObj = jsonArray.getJSONObject(i);
			
			int id = tempObj.getInt("id");
			String title = tempObj.getString("original_title");
			String release = tempObj.getString("release_date");
			String poster;
			if(!tempObj.get("poster_path").getClass().equals(String.class)) {
				poster="null";
			}else {
				poster = tempObj.getString("poster_path");
			}
			
			tempList.add(new movieObj(id,title,release,poster));
		}
		
		return tempList;
  }

  public static void main(String[] args) throws IOException, JSONException {
	/*JSONObject jsonObj = readJsonObjFromUrl("https://api.themoviedb.org/3/movie/upcoming?api_key=a092bd16da64915723b2521295da3254&sort_by=release_date.asc&page=2");
	
	String resultsText = jsonObj.get("results").toString();
	JSONArray jsonResults = new JSONArray(resultsText);
	
	List<movieObj> testList = new ArrayList<>();
	
	for(int i=0;i<jsonResults.length();i++) {
		JSONObject tempObj = jsonResults.getJSONObject(i);
		
		int id = tempObj.getInt("id");
		String title = tempObj.getString("original_title");
		String release = tempObj.getString("release_date");
		String poster;
		if(!tempObj.get("poster_path").getClass().equals(String.class)) {
			poster="null";
		}else {
			poster = tempObj.getString("poster_path");
		}
		
		testList.add(new movieObj(id,title,release,poster));
	}
	
	for(movieObj movie : testList) {
		System.out.println(movie.getId()+" - "+movie.getTitle()+" - "+movie.getRelease_date()+" - "+movie.getPoster_path());
	}*/


  }
}