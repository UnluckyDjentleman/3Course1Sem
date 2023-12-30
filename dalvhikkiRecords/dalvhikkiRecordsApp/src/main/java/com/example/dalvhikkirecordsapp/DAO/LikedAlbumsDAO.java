package com.example.dalvhikkirecordsapp.DAO;

import com.example.dalvhikkirecordsapp.Connections.AuthorizedUserConnection;
import com.example.dalvhikkirecordsapp.Objects.Albums;
import com.example.dalvhikkirecordsapp.Objects.LikedAlbums;
import com.example.dalvhikkirecordsapp.Objects.LikedSongs;
import com.example.dalvhikkirecordsapp.Objects.Songs;
import oracle.jdbc.OracleConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static java.sql.Types.REF_CURSOR;

public class LikedAlbumsDAO {
    public boolean LikedAlbum(int idUser, int idAlbum) {
        boolean isLiked=false;
        LikedAlbums likedAlbums=new LikedAlbums();
        try(OracleConnection connection=AuthorizedUserConnection.getConn()){
            CallableStatement stat=connection.prepareCall("{call developer.GetLikedSongBySongIdAndUserId(?,?,?)}");
            stat.setInt(1,idUser);
            stat.setInt(2,idAlbum);
            stat.registerOutParameter(3,REF_CURSOR);
            stat.executeUpdate();
            ResultSet rs= (ResultSet) stat.getObject(3);
            while(rs.next()){
                likedAlbums=new LikedAlbums(
                        rs.getInt("user_id"),
                        rs.getInt("liked_album_id")
                );
                isLiked=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isLiked;
    }

    public void LikeAlbum(int idUser, int idAlbum) {
        try(OracleConnection connection= AuthorizedUserConnection.getConn()){
            CallableStatement stat=connection.prepareCall("{call developer.LikeAlbum(?,?)}");
            stat.setInt(1,idUser);
            stat.setInt(2,idAlbum);
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public List<Albums> getLikedAlbums(int id) {
        List<Albums>songs=new ArrayList<>();
        try(OracleConnection connection= AuthorizedUserConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer. GetAllLikedAlbumsById(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2,REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet)stat.getObject(2);
            while (set.next()) {
                Albums item=new Albums(
                        set.getInt("album_id"),
                        set.getString("album_name"),
                        set.getInt("band_id"),
                        set.getDate("release_date"),
                        set.getInt("album_likes_count"),
                        set.getString("album_photo")
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
