package com.example.dalvhikkirecordsapp.DAO;

import com.example.dalvhikkirecordsapp.Connections.AdminConnection;
import com.example.dalvhikkirecordsapp.Connections.AuthorizedUserConnection;
import com.example.dalvhikkirecordsapp.Connections.GuestConnection;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import oracle.jdbc.OracleConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static java.sql.Types.REF_CURSOR;

public class AlbumsDAO {
    public List<Albums>getAllAlbums(){
        List<Albums>albums=new ArrayList<>();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetAllAlbums(?)}");
            stat.registerOutParameter(1, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(1);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
                albums.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return albums;
    }
    public List<Albums>getAlbumsByBandId(int id){
        List<Albums>albums=new ArrayList<>();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetAlbumByBandId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
                albums.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return albums;
    }

    public Albums getAlbumByAlbumId(int id) {
        Albums album=new Albums();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetAlbumById(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                album=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return album;
    }

    public List<Albums> getBestAlbums() {
        List<Albums>albums=new ArrayList<>();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetBestAlbums(?)}");
            stat.registerOutParameter(1, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(1);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
                albums.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return albums;
    }

    public List<Albums> getNewAlbums() {
        List<Albums>albums=new ArrayList<>();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetNewAlbums(?)}");
            stat.registerOutParameter(1, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(1);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
                albums.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return albums;
    }

    public Albums getAlbumByAlbumIdAdmin(int id) {
        Albums album=new Albums();
        try (OracleConnection connection = AdminConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetAlbumById(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                album=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return album;
    }

    public void AddAlbumToBand(Albums album) {
        try (OracleConnection connection = AdminConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.AddAlbum(?,?,?,?)}");
            stat.setString(1,album.getAlbum_name());
            stat.setInt(2,album.getBand_id());
            stat.setDate(3,new java.sql.Date(System.currentTimeMillis()));
            stat.setString(4,album.getAlbum_photo());
            stat.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public void UpdateAlbum(Albums album) {
        try (OracleConnection connection = AdminConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.UpdateAlbum(?,?,?)}");
            stat.setString(1,album.getAlbum_name());
            stat.setInt(2,album.getBand_id());
            stat.setString(3,album.getAlbum_photo());
            stat.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
    }



    public List<Albums> fullTextSearchGuest(String nameCountry) {
        List<Albums>albums=new ArrayList<>();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.FullTextSearchAlbums(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
                albums.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return albums;
    }

    public List<Albums> fullTextSearchAlbumsUser(String nameCountry) {
        List<Albums>albums=new ArrayList<>();
        try (OracleConnection connection = AuthorizedUserConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.FullTextSearchAlbums(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
                albums.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return albums;
    }

    public List<Albums> fullTextSearchAlbumsAdmin(String nameCountry) {
        List<Albums>albums=new ArrayList<>();
        try (OracleConnection connection = AdminConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.FullTextSearchAlbums(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
                );
                albums.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return albums;
    }

    public void DeleteAlbum(int idBand) {
        try(OracleConnection conn= AdminConnection.getConn()) {
            CallableStatement stat= conn.prepareCall("{call developer.DeleteAlbum(?)}");
            stat.setInt(1,idBand);
            stat.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
    }
}
