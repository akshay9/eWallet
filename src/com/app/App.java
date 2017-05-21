package com.app;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 * Created by Akshay on 04-04-2017.
 */
public class App {

    public final static String DB_NAME = "ewalet";
    public final static String DB_USER = "root";
    public final static String DB_PASS = "";

    public static Connection conn;

    public synchronized static Connection getDB() throws SQLException {
        if(conn == null){
            try {
                Class.forName("com.mysql.jdbc.Driver");

                conn = DriverManager.getConnection("jdbc:mysql://localhost/"+ DB_NAME +"?"
                        + "user="+ DB_USER +"&password=" + DB_PASS);
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        }
        return conn;
    }

    public static String getDateTime() {
        DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd HH:mm:ss");
        LocalDateTime now = LocalDateTime.now(ZoneId.of("Asia/Kolkata"));
        return dtf.format(now);
    }
}
