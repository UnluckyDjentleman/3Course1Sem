package com.example.dalvhikkirecordsapp.Objects;

import oracle.sql.DATE;

import java.sql.Date;

public class Albums {
    private int album_id;
    private String album_name;
    private int band_id;
    private Date release_date;
    private int album_likes_count;
    private String album_photo;

    public Albums(String album_name, int band_id, Date release_date, int album_likes_count, String album_photo) {
        this.album_name = album_name;
        this.band_id = band_id;
        this.release_date = release_date;
        this.album_likes_count = album_likes_count;
        this.album_photo = album_photo;
    }

    public Albums(int album_id, String album_name, int band_id, Date release_date, int album_likes_count, String album_photo) {
        this.album_id = album_id;
        this.album_name = album_name;
        this.band_id = band_id;
        this.release_date = release_date;
        this.album_likes_count = album_likes_count;
        this.album_photo = album_photo;
    }

    public int getAlbum_id() {
        return album_id;
    }

    public void setAlbum_id(int album_id) {
        this.album_id = album_id;
    }

    public String getAlbum_name() {
        return album_name;
    }

    public void setAlbum_name(String album_name) {
        this.album_name = album_name;
    }

    public int getBand_id() {
        return band_id;
    }

    public Albums() {
    }

    public void setBand_id(int band_id) {
        this.band_id = band_id;
    }

    public Date getRelease_date() {
        return release_date;
    }

    public void setRelease_date(Date release_date) {
        this.release_date = release_date;
    }

    public int getAlbum_likes_count() {
        return album_likes_count;
    }

    public void setAlbum_likes_count(int album_likes_count) {
        this.album_likes_count = album_likes_count;
    }

    public String getAlbum_photo() {
        return album_photo;
    }

    public void setAlbum_photo(String album_photo) {
        this.album_photo = album_photo;
    }
}
