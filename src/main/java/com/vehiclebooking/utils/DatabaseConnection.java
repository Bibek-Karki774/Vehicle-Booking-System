package com.vehiclebooking.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * It is the Utility class used for managing database connections.
 * <p>
 * This class provides methods to create and close connections
 * to the MySQL database.
 * It also loads the JDBC driver automatically when the class is loaded.
 * </p>
 */
public class DatabaseConnection {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/vehicle_booking";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.out.println("MySQL Driver not found: " + e.getMessage());
        }
    }

    /**
     * It creates a connection and returns it to the database.
     * @return a Connection object.
     * @throws SQLException if connection fails.
     */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /**
     * This method closes the database connection.
     * @param connection is the Connection object that is needed to close.
     */
    public static void closeConnection(Connection connection)  {
        try{
            if(connection != null){
                connection.close();
            }
        } catch (SQLException e){
            System.out.println("Error closing connection: " +  e.getMessage());
        }
    }
}
