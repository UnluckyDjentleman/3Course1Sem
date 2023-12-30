package com.example.dalvhikkirecordsapp.Objects;

public class BandMembers {
    private int member_id;
    private int band_id;
    private String member_name;

    public BandMembers() {
    }

    private String member_instrument;

    public BandMembers(int band_id, String member_name, String member_instrument) {
        this.band_id = band_id;
        this.member_name = member_name;
        this.member_instrument = member_instrument;
    }

    public BandMembers(int member_id, int band_id, String member_name, String member_instrument) {
        this.member_id = member_id;
        this.band_id = band_id;
        this.member_name = member_name;
        this.member_instrument = member_instrument;
    }

    public int getMember_id() {
        return member_id;
    }

    public void setMember_id(int member_id) {
        this.member_id = member_id;
    }

    public int getBand_id() {
        return band_id;
    }

    public void setBand_id(int band_id) {
        this.band_id = band_id;
    }

    public String getMember_name() {
        return member_name;
    }

    public void setMember_name(String member_name) {
        this.member_name = member_name;
    }

    public String getMember_instrument() {
        return member_instrument;
    }

    public void setMember_instrument(String member_instrument) {
        this.member_instrument = member_instrument;
    }
}
