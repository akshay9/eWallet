package com.app.controllers;

import com.app.App;
import com.app.models.User;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpSession;
import java.sql.*;

/**
 * Created by Akshay on 11-04-2017.
 */
public class AuthController {

    HttpSession session;

    public AuthController(HttpSession session) {
        this.session = session;
    }

    public boolean check() {
        if (session.getAttribute("user") == null)
            return false;

        if (((User) session.getAttribute("user")).isBanned()) {
            return false;
        }
        return true;
    }

    public boolean checkAdmin() {
        if(check() && ((User) session.getAttribute("user")).getAccess() > 100){
            return true;
        } else
            return false;
    }

    public JSONObject login(String email, String pass) {
        JSONObject result = new JSONObject();
        try {
            PreparedStatement preparedStatement = App.getDB()
                    .prepareStatement("SELECT * FROM `users` WHERE email=? AND password=?");

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, pass);

            ResultSet resultSet = preparedStatement.executeQuery();
            //auth logic
            if (resultSet.next()) {
                User user = new User(resultSet);
                if(user.isBanned()) {
                    result.put("response", "error");
                    result.put("message", "Your Account is Banned. Please contact Support.");
                    return result;
                }
                session.setAttribute("user", user);
                result.put("response", "success");
                return result;
            } else {
                result.put("response", "error");
                result.put("message", "Invalid Username or Password.");
                return result;
            }
        } catch (SQLException e){
            e.printStackTrace();
            result.put("response", "error");
            result.put("message", "Database Error.");
            return result;
        }
    }

    public JSONObject register(String name, String email, String phone, String pass) {
        JSONObject result = new JSONObject();

        try {
            if(duplicateEmail(email)){
                result.put("response", "error");
                result.put("message", "The Email is already registered.");
                return result;
            }
            if(duplicatePhone(phone)){
                result.put("response", "error");
                result.put("message", "The Phone is already registered.");
                return result;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("response", "error");
            result.put("message", "Something Went Wrong!");
            return result;
        }

        User user = new User(name, email, phone);
        try {
            user.addToDB(pass);
            result.put("response", "success");
            result.put("message", "You successfully registered, redirecting you to your account.");
            session.setAttribute("user", user);

        } catch (SQLException e) {
            e.printStackTrace();
            result.put("response", "error");
            result.put("message", "Something Went Wrong!");

        }
        return result;
    }

    public void logout(){
        session.invalidate();
    }

    private boolean duplicateEmail(String email) throws SQLException {
        PreparedStatement preparedStatement = App.getDB().prepareStatement("SELECT COUNT(*) FROM `users` WHERE `email`=?");
        preparedStatement.setString(1, email);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        int count = resultSet.getInt(1);
        resultSet.close();
        preparedStatement.close();
        return count != 0;
    }

    private boolean duplicatePhone(String phone) throws SQLException {
        PreparedStatement preparedStatement = App.getDB().prepareStatement("SELECT COUNT(*) FROM `users` WHERE `phone`=?");
        preparedStatement.setString(1, phone);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        int count = resultSet.getInt(1);
        resultSet.close();
        preparedStatement.close();
        return count != 0;
    }
}
