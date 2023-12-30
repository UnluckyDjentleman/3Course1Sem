package com.example.dalvhikkirecordsapp.Objects;

public class LikedSongs {
    private int user_id;
    private int liked_song_id;

    public LikedSongs(int user_id, int liked_song_id) {
        this.user_id = user_id;
        this.liked_song_id = liked_song_id;
    }

    public LikedSongs() {
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getLiked_song_id() {
        return liked_song_id;
    }

    public void setLiked_album_id(int liked_song_id) {
        this.liked_song_id = liked_song_id;
    }
}
