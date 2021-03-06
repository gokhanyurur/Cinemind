package com.cinemind.objects;

import java.util.ArrayList;
import java.util.List;

import com.cinemind.entity.Favorites_list;
import com.cinemind.entity.Reminder_list;
import com.cinemind.entity.Watchlist;

public class MovieObj {
    private int vote_count,id,length,dayLeft;
    private double popularity,vote_average;
    private String title,poster_path,original_language,original_title,backdrop_path,overview;
    private String release_date;
    private boolean adult,video;
    private List<GenreObj> genres=new ArrayList<>();
    private List<Cast> castList=new ArrayList<>();
    private List<Crew> crewList=new ArrayList<>();
    private List<VideoObj> videoList=new ArrayList<>();
    private List<ImageObj> imageList=new ArrayList<>();
    private String status;
	private String tagline;
	private long budget;
	private long revenue;
	
	private String director;
	private String writer;
	private String music;
	private List<Country> countries;
	private String countryString;
	private String imdb_id;
	private String homepage;
	
	private List<MovieObj> recommendedMovies = new ArrayList<>();

    public MovieObj(){

    }

    public MovieObj(int id,String title,String release_date,String poster_path){
        this.id=id;
        this.title=title;
        this.release_date=release_date;
        this.poster_path=poster_path;
    }


    public MovieObj(int id,String title,String release_date,int dayLeft ,String poster_path, String backdrop_path, String overview, double vote_average){
        this.id=id;
        this.title=title;
        this.release_date=release_date;
        this.poster_path=poster_path;
        this.backdrop_path=backdrop_path;
        this.overview=overview;
        this.vote_average=vote_average;
        this.dayLeft=dayLeft;
    }

    public MovieObj(int id,String title,String release_date,String poster_path, String backdrop_path, String overview, double vote_average){
        this.id=id;
        this.title=title;
        this.release_date=release_date;
        this.poster_path=poster_path;
        this.backdrop_path=backdrop_path;
        this.overview=overview;
        this.vote_average=vote_average;
    }


    public MovieObj(int vote_count, int id, boolean video,double vote_average, String title, double popularity, String poster_path, String original_language, String original_title,List<GenreObj> genres,String backdrop_path, boolean adult,String overview,String release_date){
        this.vote_count=vote_count;
        this.id=id;
        this.video=video;
        this.vote_average=vote_average;
        this.title=title;
        this.popularity=popularity;
        this.poster_path=poster_path;
        this.original_language=original_language;
        this.original_title=original_title;
        this.genres=genres;
        this.backdrop_path=backdrop_path;
        this.adult=adult;
        this.overview=overview;
        this.release_date=release_date;
    }

    public int getVote_count(){
        return vote_count;
    }
    public void setVote_count(int vote_count){
        this.vote_count=vote_count;
    }

    public int getId(){
        return id;
    }
    public void setId(int id){
        this.id=id;
    }

    public boolean getVideo(){
        return video;
    }
    public void setVideo(boolean video){
        this.video=video;
    }

    public double getVote_average(){
        return vote_average;
    }
    public void setVote_average(double vote_average){
        this.vote_average=vote_average;
    }

    public String getTitle(){
        return title;
    }
    public void setTitle(String title){
        this.title=title;
    }

    public double getPopularity(){
        return popularity;
    }
    public void setPopularity(double popularity){
        this.popularity=popularity;
    }

    public String getPoster_path(){
        return poster_path;
    }
    public void setPoster_path(String poster_path){
        this.poster_path=poster_path;
    }

    public String getOriginal_language(){
        return original_language;
    }
    public void setOriginal_language(String original_language){
        this.original_language=original_language;
    }

    public String getOriginal_title(){
        return original_title;
    }
    public void setOriginal_title(String original_title){
        this.original_title=original_title;
    }

    public List<GenreObj> getGenres(){
        return genres;
    }
    public void setGenres(List<GenreObj> genres){
        this.genres=genres;
    }

    public String getBackdrop_path(){
        return backdrop_path;
    }
    public void setBackdrop_path(String backdrop_path){
        this.backdrop_path=backdrop_path;
    }

    public boolean getAdult(){
        return adult;
    }
    public void setAdult(boolean adult){
        this.adult=adult;
    }

    public String getOverview(){
        return overview;
    }
    public void setOverview(String overview){
        this.overview=overview;
    }

    public String getRelease_date(){
        return release_date;
    }
    public void setRelease_date(String release_date){
        this.release_date=release_date;
    }

    public int getLength(){
        return length;
    }
    public void setLength(int length){
        this.length=length;
    }

    public List<Cast> getCastList(){
        return castList;
    }
    public void setCastList(List<Cast> castList){
        this.castList=castList;
    }

    public List<Crew> getCrewList()    {
        return crewList;
    }
    public void setCrewList(List<Crew> crewList){
        this.crewList=crewList;
    }

    public List<VideoObj> getVideoList(){
        return videoList;
    }
    public void setVideoList(List<VideoObj> videoList){
        this.videoList=videoList;
    }

    public List<ImageObj> getImageList(){
        return imageList;
    }
    public void setImageList(List<ImageObj> imageList){
        this.imageList=imageList;
    }

    public void setDayLeft(int dayLeft){
        this.dayLeft=dayLeft;
    }
    public int getDayLeft(){
        return dayLeft;
    }

    public String getStatus(){
        return status;
    }
    public void setStatus(String status){
        this.status=status;
    }

	public void setTagline(String tagline) {
		this.tagline=tagline;
	}
	
	public String getTagline() {
		return tagline;
	}

	public void setBudget(long budget) {
		this.budget=budget;		
	}
	
	public long getBudget() {
		return budget;
	}

	public void setRevenue(long revenue) {
		this.revenue=revenue;
	}
	public long getRevenue() {
		return revenue;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getMusic() {
		return music;
	}

	public void setMusic(String music) {
		this.music = music;
	}

	public List<Country> getCountries() {
		return countries;
	}

	public void setCountries(List<Country> countries) {
		this.countries = countries;
	}

	public String getCountryString() {
		return countryString;
	}

	public void setCountryString(String countryString) {
		this.countryString = countryString;
	}

	public List<MovieObj> getRecommendedMovies() {
		return recommendedMovies;
	}

	public void setRecommendedMovies(List<MovieObj> recommendedMovies) {
		this.recommendedMovies = recommendedMovies;
	}
	
    public static MovieObj getMovieByID(List<MovieObj> movies, int id){
        for(int i=0;i<movies.size();i++){
            if(movies.get(i).getId()==id){
                return movies.get(i);
            }
        }
        return null;
    }

	public String getImdb_id() {
		return imdb_id;
	}

	public void setImdb_id(String imdb_id) {
		this.imdb_id = imdb_id;
	}

	public String getHomepage() {
		return homepage;
	}

	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
    
    
    
}

