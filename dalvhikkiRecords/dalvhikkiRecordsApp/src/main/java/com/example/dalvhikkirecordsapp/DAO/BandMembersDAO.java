package com.example.dalvhikkirecordsapp.DAO;

import com.example.dalvhikkirecordsapp.Connections.AdminConnection;
import com.example.dalvhikkirecordsapp.Connections.AuthorizedUserConnection;
import com.example.dalvhikkirecordsapp.Connections.GuestConnection;
import com.example.dalvhikkirecordsapp.Objects.BandMembers;
import com.example.dalvhikkirecordsapp.Objects.Bands;
import oracle.jdbc.OracleConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static java.sql.Types.REF_CURSOR;

public class BandMembersDAO {
    public List<BandMembers> getMembersOfBand(int id){
        List<BandMembers>bandMembers=new ArrayList<>();
        try(OracleConnection connection= GuestConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetMembersOfBand(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while(set.next()){
                BandMembers bandMem=new BandMembers(
                        set.getInt("member_id"),
                        set.getInt("band_id"),
                        set.getString("member_name"),
                        set.getString("member_instrument")
                );
                bandMembers.add(bandMem);
            }

        } catch (Exception e){
            e.printStackTrace();
        }
        return bandMembers;
    }

    public List<BandMembers> getMembersOfBandUser(int id) {
        List<BandMembers>bandMembers=new ArrayList<>();
        try(OracleConnection connection= AuthorizedUserConnection.getConn()) {
            CallableStatement stat = connection.prepareCall("{call developer.GetMembersOfBand(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(2);
            while(set.next()){
                BandMembers bandMem=new BandMembers(
                        set.getInt("member_id"),
                        set.getInt("band_id"),
                        set.getString("member_name"),
                        set.getString("member_instrument")
                );
                bandMembers.add(bandMem);
            }

        } catch (Exception e){
            e.printStackTrace();
        }
        return bandMembers;
    }

    public void AddMemberInBand(BandMembers bandMem) {
        try(OracleConnection conn=AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.AddMemberInBand(?,?,?)}");
            stat.setInt(1,bandMem.getBand_id());
            stat.setString(2,bandMem.getMember_name());
            stat.setString(3,bandMem.getMember_instrument());
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void UpdateMemberInBand(BandMembers bandMem) {
        try(OracleConnection conn=AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.UpdateMemberInBand(?,?,?)}");
            stat.setInt(1,bandMem.getMember_id());
            stat.setString(2,bandMem.getMember_name());
            stat.setString(3,bandMem.getMember_instrument());
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public BandMembers getMember(int band_id,int id) {
        BandMembers bandMem=new BandMembers();
        try(OracleConnection conn=AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.GetMemberOfBand(?,?,?)}");
            stat.setInt(1,band_id);
            stat.setInt(2,id);
            stat.registerOutParameter(3, REF_CURSOR);
            stat.execute();
            ResultSet set = (java.sql.ResultSet) stat.getObject(3);
            while(set.next()){
                bandMem=new BandMembers(
                        set.getInt("member_id"),
                        set.getInt("band_id"),
                        set.getString("member_name"),
                        set.getString("member_instrument")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bandMem;
    }

    public void DeleteBandMember(int idBand) {
        try(OracleConnection conn= AdminConnection.getConn()) {
            CallableStatement stat=conn.prepareCall("{call developer.DeleteMemberOfBand(?)}");
            stat.setInt(1,idBand);
            stat.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
