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

import com.cinemind.objects.Country;
import com.cinemind.objects.cast;
import com.cinemind.objects.crew;
import com.cinemind.objects.genreObj;
import com.cinemind.objects.image;
import com.cinemind.objects.movieObj;
import com.cinemind.objects.video;

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
  
  public static genreObj parseGenresArray(String response) throws JSONException{
      JSONObject object=new JSONObject(response);
      genreObj genre= new genreObj();

      genre.setId(object.getInt("id"));
      genre.setTitle(object.getString("name"));

      return genre;
  }

  public static crew parseCrewArray(String response) throws  JSONException{
      JSONObject object=new JSONObject(response);
      crew person= new crew();
      
	String imagePrefixProfile= "http://image.tmdb.org/t/p/w185";

      person.setId(object.optInt("id"));
      person.setName(object.getString("name"));
      person.setJob(object.getString("job"));
      //person.setImagePath(imagePrefixProfile+object.getString("profile_path"));

      return person;

  }

	public static JSONArray getJsonCrew(String credits) throws JSONException{
	    JSONObject creditsObj=new JSONObject(credits);
	    JSONArray crewArray=creditsObj.getJSONArray("crew");
	    return crewArray;
	}

	public static String getDirector(List<crew> crewList) {
		String director="";
		for(crew person : crewList) {
            if(person.getJob().equals("Director") && director==""){
                director=person.getName();
            }
            else if(person.getJob().equals("Director") && director!=""){
                director+=", "+person.getName();
            }
		}
		
		if(director.equals("")) {
			director= "unknown";
		}
		return director;
	}
	
	public static String getWriter(List<crew> crewList) {
		String writer="";
		for(crew person : crewList) {
            if(person.getJob().equals("Screenplay") && writer==""){
            	writer=person.getName();
            }
            else if(person.getJob().equals("Screenplay") && writer!=""){
            	writer+=", "+person.getName();
            }
		}	
		if(writer.equals("")) {
			writer= "unknown";
		}
		return writer;
	}
	
	public static String getMusic(List<crew> crewList) {
		String music="";
		for(crew person : crewList) {
            if(person.getJob().equals("Music") && music==""){
            	music=person.getName();
            }
            else if(person.getJob().equals("Music") && music!=""){
            	music+=", "+person.getName();
            }
		}	
		if(music.equals("")) {
			music= "unknown";
		}
		return music;
	}

	public static Country parseCountryArray(JSONObject object) throws JSONException {
		String iso = object.getString("iso_3166_1");
		String name = object.getString("name");
		Country country = new Country(iso,name);
		
		return country;
	}

	public static String getAllCountries(List<Country> countries) {
		String countriesString= "";
		for(Country country : countries) {
            if(countriesString==""){
            	countriesString=country.getName();
            }
            else if(countriesString!=""){
            	countriesString+=", "+country.getName();
            }
		}	
		if(countriesString.equals("")) {
			countriesString= "unknown";
		}
		
		return countriesString;
	}

	public static cast parseCastArray(JSONObject object) throws JSONException {
	    cast person= new cast();
	      
		String imagePrefixProfile= "http://image.tmdb.org/t/p/w185";

	    person.setId(object.optInt("id"));
	    person.setCharacter(object.getString("character"));
	    person.setName(object.getString("name"));
	    
	    if(object.get("profile_path").getClass().equals(String.class)) {
	    	person.setImagePath(imagePrefixProfile+object.getString("profile_path"));
	    }

	    return person;
	}

	public static JSONArray getJsonCast(String credits) throws JSONException {
	    JSONObject creditsObj=new JSONObject(credits);
	    JSONArray castArray=creditsObj.getJSONArray("cast");
	    return castArray;
	}

	public static JSONArray getJsonImage(String images) throws JSONException {
	    JSONObject imagesObj=new JSONObject(images);
	    JSONArray imagesArray=imagesObj.getJSONArray("backdrops");
	    return imagesArray;
	}

	public static image parseImageArray(JSONObject jsonobject) throws JSONException {
		image tempImg = new image();
		
		String imagePrefixBackdrop= "http://image.tmdb.org/t/p/w780";
		
		tempImg.setFilePath(imagePrefixBackdrop+jsonobject.getString("file_path"));
				
		return tempImg;
		
	}

	public static JSONArray getJsonVideo(String videos) throws JSONException {
	    JSONObject videosObj=new JSONObject(videos);
	    JSONArray videosArray=videosObj.getJSONArray("results");
	    return videosArray;
	}

	public static video parseVideoArray(JSONObject object) throws JSONException {
        video movieVideo= new video();

        movieVideo.setId(object.getString("id"));
        movieVideo.setKey(object.getString("key"));
        movieVideo.setName(object.getString("name"));
        movieVideo.setSite(object.getString("site"));
        movieVideo.setSize(object.optInt("size"));
        movieVideo.setType(object.getString("type"));

        return movieVideo;
	}
  

}