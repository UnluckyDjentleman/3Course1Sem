package com.example.dalvhikkirecordsapp.Objects;

public class LikedAlbums {
    private int user_id;
    private int liked_album_id;

    public LikedAlbums() {
    }

    public LikedAlbums(int user_id, int liked_album_id) {
        this.user_id = user_id;
        this.liked_album_id = liked_album_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getLiked_album_id() {
        return liked_album_id;
    }

    public void setLiked_album_id(int liked_album_id) {
        this.liked_album_id = liked_album_id;
    }
}
