// com/citywatch/config/DBConnection.java
package com.citywatch.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static DBConnection instance;
    private Connection connection;

    private static final String URL      = "jdbc:mysql://localhost:3306/citywatch_db?useSSL=false&serverTimezone=UTC";
    private static final String USER     = "root";
    private static final String PASSWORD = "";

    private DBConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to connect to the database.", e);
        }
    }

    public static DBConnection getInstance() {
        if (instance == null || isConnectionClosed()) {
            synchronized (DBConnection.class) {
                if (instance == null || isConnectionClosed()) {
                    instance = new DBConnection();
                }
            }
        }
        return instance;
    }

    private static boolean isConnectionClosed() {
        try {
            return instance == null || instance.connection == null || instance.connection.isClosed();
        } catch (SQLException e) {
            return true;
        }
    }

    public Connection getConnection() {
        return connection;
    }
}