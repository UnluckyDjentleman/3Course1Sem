package com.example.dalvhikkirecordsapp.Objects;

import oracle.sql.DATE;

import java.sql.Date;

public class Songs {
    private int song_id;
    private int band_id;
    private int album_id;
    private String song_name;
    private Date song_release;
    private int song_likes_count;
    private String song_file;

    public int getSong_id() {
        return song_id;
    }

    public void setSong_id(int song_id) {
        this.song_id = song_id;
    }

    public Songs(int song_id, int band_id, int album_id, String song_name, Date song_release, int song_likes_count, String song_file) {
        this.song_id = song_id;
        this.band_id = band_id;
        this.album_id = album_id;
        this.song_name = song_name;
        this.song_release = song_release;
        this.song_likes_count = song_likes_count;
        this.song_file = song_file;
    }

    public Songs(int band_id, int album_id, String song_name, Date song_release, int song_likes_count, String song_file) {
        this.band_id = band_id;
        this.album_id = album_id;
        this.song_name = song_name;
        this.song_release = song_release;
        this.song_likes_count = song_likes_count;
        this.song_file = song_file;
    }

    public int getBand_id() {
        return band_id;
    }

    public void setBand_id(int band_id) {
        this.band_id = band_id;
    }

    public int getAlbum_id() {
        return album_id;
    }

    public void setAlbum_id(int album_id) {
        this.album_id = album_id;
    }

    public String getSong_name() {
        return song_name;
    }

    public void setSong_name(String song_name) {
        this.song_name = song_name;
    }

    public Date getSong_release() {
        return song_release;
    }

    public void setSong_release(Date song_release) {
        this.song_release = song_release;
    }

    public Songs() {
    }

    public int getSong_likes_count() {
        return song_likes_count;
    }

    public void setSong_likes_count(int song_likes_count) {
        this.song_likes_count = song_likes_count;
    }

    public String getSong_file() {
        return song_file;
    }

    public void setSong_file(String song_file) {
        this.song_file = song_file;
    }
}
