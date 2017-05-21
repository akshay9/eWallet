package com.app.controllers;

import com.app.App;
import com.app.models.User;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created by Akshay on 13-04-2017.
 */
public class AccountController {
    private HttpSession session;
    private HttpServletResponse response;

    public User user;

    public AccountController(int forUser) throws SQLException {
        user = new User(forUser);
    }

    public AccountController(HttpSession session, HttpServletResponse response) throws IOException, SQLException, User.NonSQLSyncedException {
        this.session = session;
        this.response = response;
        if (!new AuthController(session).check() ) {
            response.sendRedirect("index.jsp");
            session.setAttribute("redirect", "true");
            return;
        }
        user = (User) session.getAttribute("user");
        user.update();
        session.setAttribute("user", user);
    }

    public JSONObject getNameFromPhone(String phone) throws SQLException {
        JSONObject result = new JSONObject();

        PreparedStatement preparedStatement = App.getDB()
                .prepareStatement("SELECT `name` FROM `users` WHERE `phone`=?");

        preparedStatement.setString(1, phone);

        ResultSet resultSet = preparedStatement.executeQuery();
        if(resultSet.next()) {
            result.put("response", "success");
            result.put("value", resultSet.getString(1));

        } else {
            result.put("response", "error");
        }

        resultSet.close();
        preparedStatement.close();
        return result;
    }

    public JSONObject getBalance() throws SQLException {
        JSONObject result = new JSONObject();
        user.update();
        result.put("response", "success");
        result.put("value", user.getBalance());

        return result;
    }

    public JSONObject sendMoney(String to, String amount, String comment) throws SQLException, InsufficientBalanceException, User.UnknownUserException, User.NonSQLSyncedException {
        user.update();
        Double amountInt = Double.parseDouble(amount);
        if (user.getBalance() < amountInt || amountInt < 0){
            throw new InsufficientBalanceException("Not enough Money.");
        }
        if(getNameFromPhone(to).get("response") == "error"){
            throw new User.UnknownUserException("User Not Found");
        }
        if(comment.length() > 32){
            throw new User.UnknownUserException("Comment too large");
        }

        PreparedStatement preparedStatement = App.getDB().prepareStatement("SELECT * FROM `users` WHERE `phone`=?");
        preparedStatement.setString(1, to);
        ResultSet resultSet = preparedStatement.executeQuery();
        resultSet.next();
        User toUser = new User(resultSet);

        user.setBalance(user.getBalance() - amountInt);
        toUser.setBalance(toUser.getBalance() + amountInt);

        PreparedStatement statement = App.getDB().prepareStatement("INSERT INTO `transactions` ( `sender`, `receiver`, `amount`, `comment`, `time`) VALUES ( ?, ?, ?, ?, ?)");
        statement.setInt(1, user.getId());
        statement.setInt(2, toUser.getId());
        statement.setDouble(3, amountInt);
        statement.setString(4, comment);
        statement.setString(5, App.getDateTime());
        statement.executeUpdate();

        JSONObject result = new JSONObject();
        result.put("response", "success");
        result.put("value", "Money Transfered Successfully.");
        return result;
    }

    public class InsufficientBalanceException extends Exception {
        public InsufficientBalanceException(String message) {
            super(message);
        }
    }
}
