package com.example.dalvhikkirecordsapp.DAO;

import com.example.dalvhikkirecordsapp.Connections.AdminConnection;
import com.example.dalvhikkirecordsapp.Connections.AuthorizedUserConnection;
import com.example.dalvhikkirecordsapp.Objects.LikedSongs;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import oracle.jdbc.OracleConnection;

import java.sql.CallableStatement;
import static java.sql.Types.REF_CURSOR;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class LikedSongsDAO {
    public void LikeSong(int user_id, int song_id){
        try(OracleConnection connection=AuthorizedUserConnection.getConn()){
            CallableStatement stat=connection.prepareCall("{call developer.LikeSong(?,?)}");
            stat.setInt(1,user_id);
            stat.setInt(2,song_id);
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public boolean LikedSong(int user_id, int song_id){
        boolean isLiked=false;
        LikedSongs likedSongs=new LikedSongs();
        try(OracleConnection connection=AuthorizedUserConnection.getConn()){
            CallableStatement stat=connection.prepareCall("{call developer.GetLikedSongBySongIdAndUserId(?,?,?)}");
            stat.setInt(1,user_id);
            stat.setInt(2,song_id);
            stat.registerOutParameter(3,REF_CURSOR);
            stat.executeUpdate();
            ResultSet rs= (ResultSet) stat.getObject(3);
            while(rs.next()){
                likedSongs=new LikedSongs(
                        rs.getInt("user_id"),
                        rs.getInt("liked_song_id")
                );
                isLiked=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isLiked;
    }

    public List<Songs> getLikedSongs(int id) {
        List<Songs>songs=new ArrayList<>();
        try(OracleConnection connection= AuthorizedUserConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer. GetAllLikedSongsById(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(2);
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
                songs.add(item);
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return songs;
    }
}
