package com.app.controllers;

import com.app.App;
import com.app.models.User;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * Created by Yogesh on 14-04-2017.
 */
public class TransactionController {

    public User user;

    public TransactionController(HttpSession session, HttpServletResponse response) throws IOException, SQLException, User.NonSQLSyncedException {
        if (!new AuthController(session).check() ) {
            response.sendRedirect("index.jsp");
            session.setAttribute("redirect", "true");
            return;
        }
        user = (User) session.getAttribute("user");
        user.update();
        session.setAttribute("user", user);
    }

    public ArrayList<HashMap<String,String>> getTransactions() throws SQLException, User.NonSQLSyncedException {
        PreparedStatement preparedStatement = App.getDB()
                .prepareStatement("SELECT t.id AS 'id', t.amount AS 'amount', t.comment AS 'comment', t.time AS 'time', receiver.id AS 'receiver_id', receiver.name AS 'receiver_name', receiver.phone AS 'receiver_phone', sender.id AS 'sender_id', sender.name AS 'sender_name', sender.phone AS 'sender_phone' " +
                                "FROM `transactions` t " +
                                "LEFT JOIN `users` receiver ON t.receiver=receiver.id " +
                                "LEFT JOIN `users` sender ON t.sender=sender.id " +
                                "WHERE t.receiver=? OR t.sender=? ");

        preparedStatement.setInt(1, user.getId());
        preparedStatement.setInt(2, user.getId());

        ResultSet resultSet = preparedStatement.executeQuery();
        ResultSetMetaData md = resultSet.getMetaData();
        int columns = md.getColumnCount();
        ArrayList<HashMap<String,String>> list = new ArrayList<>(20);

        while(resultSet.next()) {
            HashMap<String,String> row = new HashMap<>(columns);

            if(resultSet.getInt("receiver_id") == user.getId()){
                row.put("type", "Cr");
                row.put("from", resultSet.getString("sender_name")+" ("+resultSet.getString("sender_phone")+")");
                row.put("to", "You");
            } else {
                row.put("type", "Dr");
                row.put("from", "You");
                row.put("to", resultSet.getString("receiver_name")+" ("+resultSet.getString("receiver_phone")+")");
            }

            row.put("id", resultSet.getString("id"));
            row.put("amount", resultSet.getString("amount"));
            row.put("comment", resultSet.getString("comment"));
            row.put("time", resultSet.getString("time"));

            list.add(row);
        }

        resultSet.close();
        preparedStatement.close();
        return list;
    }
}
