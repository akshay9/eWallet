package com.app.controllers;

import com.app.models.User;
import org.json.simple.JSONObject;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

/**
 * Created by Akshay on 28-04-2017.
 */
public class BankController {

    public User user;

    public BankController(HttpSession session, HttpServletResponse response) throws IOException, SQLException, User.NonSQLSyncedException {
        if (!new AuthController(session).check() ) {
            response.sendRedirect("index.jsp");
            session.setAttribute("redirect", "true");
            return;
        }
        user = (User) session.getAttribute("user");
        user.update();
        session.setAttribute("user", user);
    }

    public JSONObject addMoney(String amount) {
        JSONObject result = new JSONObject();

        try {
            user.update();
            Double amountInt = Double.parseDouble(amount);
            user.setBalance(user.getBalance() + amountInt);
            result.put("response", "success");
            result.put("value", "Money Added Successfully.");
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("response", "error");
            result.put("value", "Something went wrong!");
        }

        return result;
    }
}
