package com.cinemind.objects;

public class image {
    private float aspect_ratio;
    private String filePath;
    private int height,width;


    public image(){

    }
    public image(float aspect_ratio, String file_path,int width,int height){
        this.aspect_ratio=aspect_ratio;
        this.filePath = file_path;
        this.width =width;
        this.height =height;
    }
    public image(String file_path){
        this.filePath = file_path;
    }

    public float getAspectRatio(){
        return aspect_ratio;
    }
    public void setAspectRatio(float aspect_ratio){
        this.aspect_ratio=aspect_ratio;
    }
    
    public String getFilePath(){
        return filePath;
    }
    public void setFilePath(String filePath){
        this.filePath = filePath;
    }

    public int getWidth(){
        return width;
    }
    public void setWidth(int width){
        this.width = width;
    }

    public int getHeight(){
        return height;
    }
    public void setHeight(int height){
        this.height = height;
    }


}
