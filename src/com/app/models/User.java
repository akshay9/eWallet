package com.app.models;

import com.app.App;

import java.io.Serializable;
import java.sql.*;

/**
 * Created by Akshay on 13-04-2017.
 */
public class User implements Serializable {

    private int _id;
    private String name;
    private String email;
    private String phone;
    private double balance;
    private int access;

    public User(String name, String email, String phone, double balance, int access) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.balance = balance;
        this.access = access;
    }

    public User(String name, String email, String phone) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.balance = 0;
        this.access = 5;
    }

    public User(ResultSet resultSet) throws SQLException {
        updateFromResultSet(resultSet);
    }

    public User(int id) throws SQLException {
        PreparedStatement preparedStatement = App.getDB().prepareStatement("SELECT * FROM `users` WHERE `id`=?");
        preparedStatement.setInt(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        updateFromResultSet(resultSet);
        resultSet.close();
        preparedStatement.close();
    }

    private void updateFromResultSet(ResultSet resultSet) throws SQLException {
        this._id = resultSet.getInt("id");
        this.name = resultSet.getString("name");
        this.email = resultSet.getString("email");
        this.phone = resultSet.getString("phone");
        this.balance = resultSet.getDouble("balance");
        this.access = resultSet.getInt("access");
    }

    public boolean isAddedToDB(){
        return _id != 0;
    }

    public void addToDB(String password) throws SQLException {
        Connection connect = App.getDB();
        PreparedStatement statement = connect.prepareStatement("INSERT INTO `users` (`name`, `phone`, `email`, `password`) VALUES (?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
        statement.setString(1, name);
        statement.setString(2, phone);
        statement.setString(3, email);
        statement.setString(4, password);
        statement.executeUpdate();

        try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                _id = generatedKeys.getInt(1);
                balance = 0;
                access = 5;
            }
            else {
                throw new SQLException("Creating user failed, no ID obtained.");
            }
        }
        statement.close();
    }

    public void update() throws SQLException {
        PreparedStatement preparedStatement = App.getDB()
                .prepareStatement("SELECT * FROM `users` WHERE id=?");

        preparedStatement.setInt(1, _id);

        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        updateFromResultSet(resultSet);
    }

    public int getId() throws NonSQLSyncedException {
        if(isAddedToDB())
            return _id;
        else
            throw new NonSQLSyncedException("The User Object is not associated with any SQL DB row");
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public double getBalance() {
        return balance;
    }

    public int getAccess() {
        return access;
    }

    public String getAccessRole() {
        if(access > 100) {
            return "Admin";
        } else if (access >= 50) {
            return "Moderator";
        } else if (access >= 5) {
            return "User";
        } else {
            return "Banned";
        }
    }

    public boolean isAdmin() {
        return getAccess() > 100;
    }

    public boolean isBanned() {
        return getAccess() == 0;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setBalance(double balance) throws SQLException {
        Connection connect = App.getDB();
        PreparedStatement statement = connect.prepareStatement("UPDATE `users` SET `balance` = ? WHERE `users`.`id` = ?");
        statement.setDouble(1, balance);
        statement.setInt(2, _id);
        statement.executeUpdate();
        this.balance = balance;
    }

    public void setAccess(int access) throws SQLException {
        Connection connect = App.getDB();
        PreparedStatement statement = connect.prepareStatement("UPDATE `users` SET `access` = ? WHERE `users`.`id` = ?");
        statement.setInt(1, access);
        statement.setInt(2, _id);
        statement.executeUpdate();
        this.access = access;
    }

    public class NonSQLSyncedException extends Exception {
        NonSQLSyncedException(String s) {
            super(s);
        }
    }

    public static class UnknownUserException extends Exception {
        public UnknownUserException(String message) {
            super(message);
        }
    }
}
