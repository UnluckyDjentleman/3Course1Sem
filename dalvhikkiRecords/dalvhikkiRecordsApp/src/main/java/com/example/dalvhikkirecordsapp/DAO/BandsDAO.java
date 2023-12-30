package com.example.dalvhikkirecordsapp.DAO;

import com.example.dalvhikkirecordsapp.Connections.AdminConnection;
import com.example.dalvhikkirecordsapp.Connections.AuthorizedUserConnection;
import com.example.dalvhikkirecordsapp.Connections.GuestConnection;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import oracle.jdbc.OracleConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static java.sql.Types.REF_CURSOR;

public class BandsDAO {
    public List<Bands> getAllBands() {
        List<Bands> bands = new ArrayList<>();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetAllBands(?)}");
            stat.registerOutParameter(1, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(1);
            while (set.next()) {
                Bands item=new Bands(
                        set.getInt("band_id"),
                        set.getString("band_name"),
                        set.getString("band_location"),
                        set.getString("band_genre"),
                        set.getInt("band_year_of_creation"),
                        set.getString("band_logo")
                );
                bands.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return bands;
    }
    public String getBandNameByBandId(int id) {
        String bandName = null;
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetBandNameByBandId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                bandName=set.getString("band_name");
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return bandName;
    }
    public Bands getBandByBandId(int id){
        Bands band=new Bands();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetBandByBandId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                band=new Bands(
                        set.getInt("band_id"),
                        set.getString("band_name"),
                        set.getString("band_location"),
                        set.getString("band_genre"),
                        set.getInt("band_year_of_creation"),
                        set.getString("band_logo")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return band;
    }

    public Bands getBandByBandIdUser(int id) {
        Bands band=new Bands();
        try (OracleConnection connection = AuthorizedUserConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetBandByBandId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                band=new Bands(
                        set.getInt("band_id"),
                        set.getString("band_name"),
                        set.getString("band_location"),
                        set.getString("band_genre"),
                        set.getInt("band_year_of_creation"),
                        set.getString("band_logo")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return band;
    }

    public Bands getBandByBandIdAdmin(int id){
        Bands band=new Bands();
        try (OracleConnection connection = AdminConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetBandByBandId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                band=new Bands(
                        set.getInt("band_id"),
                        set.getString("band_name"),
                        set.getString("band_location"),
                        set.getString("band_genre"),
                        set.getInt("band_year_of_creation"),
                        set.getString("band_logo")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return band;
    }

    public List<Bands> getAllBandsUser() {
        List<Bands> bands = new ArrayList<>();
        try (OracleConnection connection = AuthorizedUserConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetAllBands(?)}");
            stat.registerOutParameter(1, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(1);
            while (set.next()) {
                Bands item=new Bands(
                        set.getInt("band_id"),
                        set.getString("band_name"),
                        set.getString("band_location"),
                        set.getString("band_genre"),
                        set.getInt("band_year_of_creation"),
                        set.getString("band_logo")
                );
                bands.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return bands;
    }

    public void AddBand(Bands band) {
        try(OracleConnection conn= AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.AddBand(?,?,?,?,?)}");
            stat.setString(1,band.getBand_name());
            stat.setString(2,band.getBand_location());
            stat.setString(3,band.getBand_genre());
            stat.setInt(4,band.getBand_year_of_creation());
            stat.setString(5,band.getBand_logo());
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void UpdateBand(Bands band) {
        try(OracleConnection conn= AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.UpdateBand(?,?,?,?,?,?)}");
            stat.setString(1,band.getBand_name());
            stat.setInt(2,band.getBand_id());
            stat.setString(3,band.getBand_location());
            stat.setString(4,band.getBand_genre());
            stat.setInt(5,band.getBand_year_of_creation());
            stat.setString(6,band.getBand_logo());
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void DeleteBand(int idBand) {
        try(OracleConnection conn= AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.DeleteBand(?)}");
            stat.setInt(1,idBand);
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Bands> fullTextSearchGuest(String nameCountry) {
        List<Bands>fullTextSearchBands=new ArrayList();
        try(OracleConnection conn= GuestConnection.getConn()){
            CallableStatement stat=conn.prepareCall("{call developer.FullTextSearchBands(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2,REF_CURSOR);
            if(nameCountry.equals("")){
                fullTextSearchBands=new BandsDAO().getAllBands();
            }
            else {
                stat.execute();
                ResultSet set = (java.sql.ResultSet) stat.getObject(2);
                while (set.next()) {
                    Bands item = new Bands(
                            set.getInt("band_id"),
                            set.getString("band_name"),
                            set.getString("band_location"),
                            set.getString("band_genre"),
                            set.getInt("band_year_of_creation"),
                            set.getString("band_logo")
                    );
                    fullTextSearchBands.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullTextSearchBands;
    }

    public List<Bands> fullTextSearchBandsUser(String nameCountry) {
        List<Bands>fullTextSearchBands=new ArrayList();
        try(OracleConnection conn= AuthorizedUserConnection.getConn()){
            CallableStatement stat=conn.prepareCall("{call developer.FullTextSearchBands(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2,REF_CURSOR);
            if(nameCountry.equals("")){
                fullTextSearchBands=new BandsDAO().getAllBands();
            }
            else {
                stat.execute();
                ResultSet set = (java.sql.ResultSet) stat.getObject(2);
                while (set.next()) {
                    Bands item = new Bands(
                            set.getInt("band_id"),
                            set.getString("band_name"),
                            set.getString("band_location"),
                            set.getString("band_genre"),
                            set.getInt("band_year_of_creation"),
                            set.getString("band_logo")
                    );
                    fullTextSearchBands.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullTextSearchBands;
    }

    public List<Bands> fullTextSearchBandsAdmin(String nameCountry) {
        List<Bands>fullTextSearchBands=new ArrayList();
        try(OracleConnection conn= AdminConnection.getConn()){
            CallableStatement stat=conn.prepareCall("{call developer.FullTextSearchBands(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2,REF_CURSOR);
            if(nameCountry.equals("")){
                fullTextSearchBands=new BandsDAO().getAllBands();
            }
            else {
                stat.execute();
                ResultSet set = (java.sql.ResultSet) stat.getObject(2);
                while (set.next()) {
                    Bands item = new Bands(
                            set.getInt("band_id"),
                            set.getString("band_name"),
                            set.getString("band_location"),
                            set.getString("band_genre"),
                            set.getInt("band_year_of_creation"),
                            set.getString("band_logo")
                    );
                    fullTextSearchBands.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullTextSearchBands;
    }
}