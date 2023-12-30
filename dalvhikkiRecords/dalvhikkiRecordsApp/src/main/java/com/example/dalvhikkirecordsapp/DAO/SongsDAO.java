package com.example.dalvhikkirecordsapp.DAO;

import com.example.dalvhikkirecordsapp.Connections.AdminConnection;
import com.example.dalvhikkirecordsapp.Connections.GuestConnection;
import com.example.dalvhikkirecordsapp.Connections.AuthorizedUserConnection;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import oracle.jdbc.OracleConnection;

import java.sql.CallableStatement;
import oracle.jdbc.OracleConnection;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static java.sql.Types.REF_CURSOR;

public class SongsDAO {
    public List<Songs>getAllSongsGuest(){
        List<Songs>songs=new ArrayList<>();
        try(OracleConnection connection= GuestConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.GetAllSongs(?)}");
            stat.registerOutParameter(1,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(1);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }
    public static List<Songs>getBestSongsGuest(){
        List<Songs>songs=new ArrayList<>();
        try(OracleConnection connection= GuestConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.GetBestSongs(?)}");
            stat.registerOutParameter(1,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(1);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }
    public static List<Songs>getBestSongsUser(){
        List<Songs>songs=new ArrayList<>();
        try(OracleConnection connection= AuthorizedUserConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.GetBestSongs(?)}");
            stat.registerOutParameter(1,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(1);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }
    public List<Songs>getSongsByAlbumId(int id){
        List<Songs>songs=new ArrayList<>();
        try (OracleConnection connection = GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetSongsByAlbumId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }

    public void DeleteSong(int idSong) {
        try(OracleConnection conn= AdminConnection.getConn()) {
            CallableStatement stat= conn.prepareCall("{call developer.DeleteSong(?)}");
            stat.setInt(1,idSong);
            stat.executeUpdate();
        } catch (Exception e){
            e.printStackTrace();
        }
    }

    public List<Songs> getBestSongsAdmin() {
        List<Songs>songs=new ArrayList<>();
        try(OracleConnection connection= AdminConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.GetBestSongs(?)}");
            stat.registerOutParameter(1,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(1);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }

    public Songs getSongById(int id) {
        Songs song=new Songs();
        try(OracleConnection connection= AdminConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.GetSongBySongId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(2);
            while (set.next()) {
                song = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return song;
    }

    public void UpdateSong(Songs song) {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try(OracleConnection conn=AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.UpdateSong(?,?,?)}");
            stat.setInt(1,song.getSong_id());
            stat.setString(2,song.getSong_name());
            stat.setString(3, song.getSong_file());
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Songs> getNewSongs() {
        List<Songs>songs=new ArrayList<>();
        try(OracleConnection connection= GuestConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.GetNewSongs(?)}");
            stat.registerOutParameter(1,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(1);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }

    public List<Songs> getSongsByAlbumIdAdmin(int id) {
        List<Songs>songs=new ArrayList<>();
        try (OracleConnection connection = AdminConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetSongsByAlbumId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        } catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }

    public void AddSong(Songs song) {
        try(OracleConnection conn=AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.AddSong(?,?,?,?,?)}");
            stat.setInt(1,song.getAlbum_id());
            stat.setString(2,song.getSong_name());
            stat.setInt(3,song.getBand_id());
            stat.setDate(4,song.getSong_release());
            stat.setString(5, song.getSong_file());
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Songs> getAllSongsAdmin() {
        List<Songs>songs=new ArrayList<>();
        try(OracleConnection connection= AdminConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.GetAllSongs(?)}");
            stat.registerOutParameter(1,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(1);
            while (set.next()) {
                Songs item = new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                songs.add(item);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }

    public List<Songs> fullTextSearchSongsGuest(String nameCountry) {
        List<Songs>fullTextSearchSongs=new ArrayList();
        try(OracleConnection conn= GuestConnection.getConn()){
            CallableStatement stat=conn.prepareCall("{call developer.FullTextSearchSongs(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Songs item=new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                fullTextSearchSongs.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullTextSearchSongs;
    }

    public List<Songs> fullTextSearchSongsUser(String nameCountry) {
        List<Songs>fullTextSearchSongs=new ArrayList();
        try(OracleConnection conn= AuthorizedUserConnection.getConn()){
            CallableStatement stat=conn.prepareCall("{call developer.FullTextSearchSongs(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Songs item=new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                fullTextSearchSongs.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullTextSearchSongs;
    }

    public List<Songs> fullTextSearchSongsAdmin(String nameCountry) {
        List<Songs>fullTextSearchSongs=new ArrayList();
        try(OracleConnection conn= AdminConnection.getConn()){
            CallableStatement stat=conn.prepareCall("{call developer.FullTextSearchSongs(?,?)}");
            stat.setString(1,nameCountry);
            stat.registerOutParameter(2,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while (set.next()) {
                Songs item=new Songs(
                        set.getInt("song_id"),
                        set.getInt("band_id"),
                        set.getInt("album_id"),
                        set.getString("song_name"),
                        set.getDate("song_release"),
                        set.getInt("song_likes_count"),
                        set.getString("song_file")
                );
                fullTextSearchSongs.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return fullTextSearchSongs;
    }
}
