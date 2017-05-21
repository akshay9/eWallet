<%@ page import="com.app.controllers.AuthController" %>
<%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 11-04-2017
  Time: 12:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
    response.setContentType("application/json");
    response.setHeader("Content-Disposition", "inline");
    AuthController controller = new AuthController(session);
    if(request.getParameter("logout") != null){
        controller.logout();
        response.sendRedirect("index.jsp");
        return;
    }
    out.clear();
    out.print(controller.login(request.getParameter("email"), request.getParameter("password")));
%>