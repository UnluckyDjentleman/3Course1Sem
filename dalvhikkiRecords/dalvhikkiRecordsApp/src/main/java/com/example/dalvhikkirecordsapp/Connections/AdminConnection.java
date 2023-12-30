package com.example.dalvhikkirecordsapp.Connections;

import oracle.jdbc.OracleConnection;
import oracle.jdbc.pool.OracleDataSource;

import java.sql.SQLException;

public class AdminConnection {
    final static String DB_URL= "jdbc:oracle:thin:@localhost:1521/FREEPDB1";
    final static String DB_USER = "admin";
    final static String DB_PASSWORD = "asdfg";
    public static OracleConnection getConn() throws SQLException, ClassNotFoundException {
        OracleDataSource ods=new OracleDataSource();
        ods.setURL(DB_URL);
        ods.setUser(DB_USER);
        ods.setPassword(DB_PASSWORD);
        OracleConnection con = (OracleConnection)ods.getConnection();
        return con;
    }
}
