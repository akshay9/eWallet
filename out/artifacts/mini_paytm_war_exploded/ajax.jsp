<%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 14-04-2017
  Time: 01:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.app.controllers.AuthController" %><%@ page import="org.json.simple.JSONObject"%><%@ page import="com.app.controllers.AccountController"%><%@ page import="com.app.controllers.BankController"%><%@ page import="com.app.controllers.AdminController"%>
<%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 11-04-2017
  Time: 12:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    out.clear();
    response.setContentType("application/json");
    response.setHeader("Content-Disposition", "inline");
    JSONObject result = new JSONObject();

    String s = request.getParameter("type");
    if (s.equals("getNameFromPhone")) {
        AccountController accController = new AccountController(session, response);
        if(session.getAttribute("redirect") != null) {
            session.removeAttribute("redirect");
            session.invalidate();
            out.print("{\"response\": \"error\"}");
            return;
        }
        result = accController.getNameFromPhone(request.getParameter("phone"));

    } else if (s.equals("getBalance")) {
        AccountController accController = new AccountController(session, response);
        if(session.getAttribute("redirect") != null) {
            session.removeAttribute("redirect");
            session.invalidate();
            out.print("{\"response\": \"error\"}");
            return;
        }
        result = accController.getBalance();
    } else if (s.equals("sendMoney")) {
        AccountController accController = new AccountController(session, response);
        if(session.getAttribute("redirect") != null) {
            session.removeAttribute("redirect");
            session.invalidate();
            out.print("{\"response\": \"error\"}");
            return;
        }
        result = accController.sendMoney(request.getParameter("to"), request.getParameter("amount"), request.getParameter("comment"));
    } else if (s.equals("addMoney")) {
        BankController accController = new BankController(session, response);
        if(session.getAttribute("redirect") != null) {
            session.removeAttribute("redirect");
            session.invalidate();
            out.print("{\"response\": \"error\"}");
            return;
        }
        result = accController.addMoney(request.getParameter("amount"));
    } else if (s.equals("setAccess")) {
        AdminController controller = new AdminController(session, response);
        if(session.getAttribute("redirect") != null) {
            result.put("response", "error");
            result.put("value", "Session Expired.");
            out.print((result));
            return;
        }
        result = controller.setAccess(request.getParameter("user"), request.getParameter("access"));
    } else if (s.equals("revTxn")) {
        AdminController controller = new AdminController(session, response);
        if(session.getAttribute("redirect") != null) {
            result.put("response", "error");
            result.put("value", "Session Expired.");
            out.print((result));
            return;
        }
        result = controller.reverseTranasaction(request.getParameter("txnId"));
    }

    out.print(result);
%>
