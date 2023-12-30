package com.example.dalvhikkirecordsapp.Objects;

public class Bands {
    private int band_id;
    private String band_name;
    private String band_genre;
    private String band_location;
    private int band_year_of_creation;
    private String band_logo;

    public Bands(String band_name, String band_genre, String band_location, int band_year_of_creation, String band_logo) {
        this.band_name = band_name;
        this.band_genre = band_genre;
        this.band_location = band_location;
        this.band_year_of_creation = band_year_of_creation;
        this.band_logo = band_logo;
    }

    public Bands(int band_id, String band_name, String band_location, String band_genre, int band_year_of_creation, String band_logo) {
        this.band_id = band_id;
        this.band_name = band_name;
        this.band_genre = band_genre;
        this.band_location = band_location;
        this.band_year_of_creation = band_year_of_creation;
        this.band_logo = band_logo;
    }

    public int getBand_id() {
        return band_id;
    }

    public void setBand_id(int band_id) {
        this.band_id = band_id;
    }

    public String getBand_name() {
        return band_name;
    }

    public void setBand_name(String band_name) {
        this.band_name = band_name;
    }

    public String getBand_location() {
        return band_location;
    }

    public void setBand_location(String band_location) {
        this.band_location = band_location;
    }

    public int getBand_year_of_creation() {
        return band_year_of_creation;
    }

    public void setBand_year_of_creation(int band_year_of_creation) {
        this.band_year_of_creation = band_year_of_creation;
    }

    public String getBand_genre() {
        return band_genre;
    }

    public void setBand_genre(String band_genre) {
        this.band_genre = band_genre;
    }

    public Bands() {
    }

    public String getBand_logo() {
        return band_logo;
    }

    public void setBand_logo(String band_logo) {
        this.band_logo = band_logo;
    }
}
