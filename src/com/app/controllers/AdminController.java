package com.app.controllers;

import com.app.App;
import com.app.models.User;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Akshay on 30-04-2017.
 */
public class AdminController {

    public User user;

    public AdminController(HttpSession session, HttpServletResponse response) throws IOException, SQLException {
        if (!new AuthController(session).checkAdmin() ) {
            response.sendRedirect("index.jsp");
            session.setAttribute("redirect", "true");
            return;
        }
        user = (User) session.getAttribute("user");
        user.update();
        session.setAttribute("user", user);
    }

    public ArrayList<HashMap<String, String>> getTransactions() throws SQLException, User.NonSQLSyncedException {
        PreparedStatement preparedStatement = App.getDB()
                .prepareStatement("SELECT t.id AS 'id', t.amount AS 'amount', t.comment AS 'comment', t.time AS 'time', t.reversed AS 'reversed', receiver.id AS 'receiver_id', receiver.name AS 'receiver_name', receiver.phone AS 'receiver_phone', sender.id AS 'sender_id', sender.name AS 'sender_name', sender.phone AS 'sender_phone' " +
                        "FROM `transactions` t " +
                        "LEFT JOIN `users` receiver ON t.receiver=receiver.id " +
                        "LEFT JOIN `users` sender ON t.sender=sender.id ");

        ResultSet resultSet = preparedStatement.executeQuery();
        ResultSetMetaData md = resultSet.getMetaData();
        int columns = md.getColumnCount();
        ArrayList<HashMap<String,String>> list = new ArrayList<>(20);

        while(resultSet.next()) {
            HashMap<String,String> row = new HashMap<>(columns);

            row.put("type", "Cr");
            row.put("from", resultSet.getString("sender_name")+" ("+resultSet.getString("sender_phone")+")");
            row.put("to", resultSet.getString("receiver_name")+" ("+resultSet.getString("receiver_phone")+")");

            row.put("id", resultSet.getString("id"));
            row.put("amount", resultSet.getString("amount"));
            row.put("comment", resultSet.getString("comment"));
            row.put("time", resultSet.getString("time"));
            if(resultSet.getBoolean("reversed")) {
                row.put("reversed_class", "disabled");
                row.put("reversed", "Reversed");
            } else {
                row.put("reversed_class", "");
                row.put("reversed", "Reverse");
            }
            list.add(row);
        }

        resultSet.close();
        preparedStatement.close();
        return list;
    }

    public JSONObject reverseTranasaction(String txnId) throws SQLException, User.NonSQLSyncedException {
        JSONObject result = new JSONObject();

        PreparedStatement preparedStatement = App.getDB().prepareStatement("SELECT * FROM `transactions` WHERE `id`=?");
        preparedStatement.setInt(1, Integer.parseInt(txnId));
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();

        AccountController accController = new AccountController(resultSet.getInt("receiver"));
        try {
            accController.sendMoney(
                    new User(resultSet.getInt("sender")).getPhone(),
                    resultSet.getString("amount"),
                    "Reversed Txn Id:" + txnId);

            result.put("response", "success");
            result.put("value", "Transaction Successfully Reversed");

            PreparedStatement preparedStatement2 = App.getDB().prepareStatement("UPDATE `transactions` SET `reversed` = '1' WHERE `transactions`.`id` = ?");
            preparedStatement2.setInt(1, Integer.parseInt(txnId));
            preparedStatement2.executeUpdate();

        } catch (AccountController.InsufficientBalanceException e) {
            result.put("response", "error");
            result.put("value", "The other User does not have enough Balance.");
        } catch (User.UnknownUserException e){
            result.put("response", "error");
            result.put("value", e.getMessage());
        } catch (SQLException e) {
            result.put("response", "error");
            result.put("value", "DB Error: " + e.getMessage());
        }

        return result;
    }

    public ArrayList<User> getUsers() throws SQLException, User.NonSQLSyncedException {
        PreparedStatement preparedStatement = App.getDB()
                .prepareStatement("SELECT * FROM users");

        ResultSet resultSet = preparedStatement.executeQuery();
        ResultSetMetaData md = resultSet.getMetaData();
        int columns = md.getColumnCount();
        ArrayList<User> list = new ArrayList<>(20);

        while(resultSet.next()) {
            list.add(new User(resultSet));
        }

        resultSet.close();
        preparedStatement.close();
        return list;
    }

    public JSONObject setAccess(String userId, String access) throws SQLException {
        JSONObject result = new JSONObject();

        PreparedStatement preparedStatement = App.getDB().prepareStatement("SELECT * FROM `users` WHERE `id`=?");
        preparedStatement.setInt(1, Integer.parseInt(userId));
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        User targetUser = new User(resultSet);
        int intAccess = Integer.parseInt(access);
        targetUser.setAccess(intAccess);

        result.put("response", "success");
        result.put("value", "Access Changed Successfully.");
        return result;
    }
}
