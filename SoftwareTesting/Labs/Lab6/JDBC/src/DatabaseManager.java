import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseManager {
    private static final String DRIVER_CLASS = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String CONNECTION_URL = "jdbc:sqlserver://DESKTOP-F3UPU25;databaseName=JDBC;" +
            "trustServerCertificate=true;encrypt=false;IntegratedSecurity=false";
    private static final String USERNAME = "gvscore";
    private static final String PASSWORD = "8800";

    public static Connection getConnection() {
        try {
            Class.forName(DRIVER_CLASS);
            return DriverManager.getConnection(CONNECTION_URL, USERNAME, PASSWORD);
        } catch (Exception ex) {
            System.out.println("Connection error: " + ex.getMessage());
            ex.printStackTrace();
            throw new RuntimeException("Failed to connect to the database.", ex);
        }
    }
}
