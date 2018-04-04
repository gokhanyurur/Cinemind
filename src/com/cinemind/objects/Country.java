package com.cinemind.objects;

public class Country {

	private String iso,name;
	
	public Country() {
		
	}
	
	public Country(String iso, String name) {
		this.setIso(iso);
		this.setName(name);
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getIso() {
		return iso;
	}

	public void setIso(String iso) {
		this.iso = iso;
	}
}
