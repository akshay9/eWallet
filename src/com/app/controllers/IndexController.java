package com.app.controllers;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * Created by Akshay on 04-04-2017.
 */
public class IndexController {

    HttpSession session;

    public IndexController(HttpSession session) {
        this.session = session;
    }

    public String getDate(){
        return new Date().toString();
    }
}
