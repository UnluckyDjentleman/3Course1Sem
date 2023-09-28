package lab.p2p;

import java.io.Serializable;
public class Prospect implements Serializable{
    private int id;
    private int number;
    private String name;
    private String position;
    private String country;
    private String averageMark;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getAverageMark() {
        return averageMark;
    }

    public void setAverageMark(String averageMark) {
        this.averageMark = averageMark;
    }

    public Prospect() {
        this.id=-1;
        this.number=-1;
        this.name="";
        this.position="";
        this.country="";
        this.averageMark="";
    }

    @Override
    public String toString() {
        return "ex2.Operator{id: "+id+", №: "+number+", Name: "+name+", Position: "+position+", Country: "+country+", Average mark: "+averageMark;
    }

    public Prospect(int id, int number, String name, String position, String country, String averageMark) {
        this.id = id;
        this.number = number;
        this.name = name;
        this.position = position;
        this.country = country;
        this.averageMark = averageMark;
    }
}
