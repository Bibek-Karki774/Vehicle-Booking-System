package com.vehiclebooking.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/vehicle_booking";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";


    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

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
