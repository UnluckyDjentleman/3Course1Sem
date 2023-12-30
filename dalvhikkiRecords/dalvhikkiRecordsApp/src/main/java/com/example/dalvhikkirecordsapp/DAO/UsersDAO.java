package com.example.dalvhikkirecordsapp.DAO;

import com.example.dalvhikkirecordsapp.Connections.AdminConnection;
import com.example.dalvhikkirecordsapp.Connections.AuthorizedUserConnection;
import com.example.dalvhikkirecordsapp.Connections.GuestConnection;
import com.example.dalvhikkirecordsapp.Objects.Users;
import oracle.jdbc.OracleConnection;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import static java.sql.Types.REF_CURSOR;

public class UsersDAO {
    public Users getCurrentUser(){
        Users currentUser=null;
        return currentUser;
    }
    public Users getUserByNameAndPassword(String name, String password){
        Users user=null;
        try(OracleConnection connection = GuestConnection.getConn()){
            CallableStatement stat=connection.prepareCall("{call developer.GetUserByNameAndPassword(?,?,?)}");
            stat.setString(1,name);
            stat.setString(2,password);
            stat.registerOutParameter(3,REF_CURSOR);
            stat.execute();
            ResultSet rs= (java.sql.ResultSet) stat.getObject(3);
            while(rs.next()){
                user=new Users();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }
        }
        catch(Exception e){
            e.printStackTrace();
        }
        return user;
    }
    public Users UserRegistration(String name, String email, String password){
        Users user=new Users();
        try(OracleConnection connection= GuestConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call developer.USER_REGISTRATION(?,?,?,?,?)}");
            stat.setString(1,name);
            stat.setString(2,email);
            stat.setString(3, password);
            stat.setString(4,"user");
            stat.registerOutParameter(5,REF_CURSOR);
            stat.executeUpdate();
            ResultSet rs= (ResultSet) stat.getObject(5);
            rs.next();
            user.setId(rs.getInt(1));
            user.setName(rs.getString(2));
            user.setEmail(rs.getString(3));
            user.setPassword(rs.getString(4));
            user.setRole(rs.getString(5));
            return user;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }
    public String UserRole(int id){
        String userRole="";
        try(OracleConnection connection= AdminConnection.getConn()) {
            CallableStatement stat=connection.prepareCall("{call getUserRoleByUserId(?,?)}");
            stat.setInt(1,id);
            stat.registerOutParameter(2,REF_CURSOR);
            stat.executeUpdate();
            ResultSet rs= (ResultSet) stat.getObject(2);
            rs.next();
            userRole=rs.getString("role");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userRole;
    }
}
