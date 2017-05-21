<%@ page import="com.app.controllers.AuthController" %><%@ page import="org.json.simple.JSONObject"%>
<%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 11-04-2017
  Time: 12:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" %>
<%
   // Returns all employees (active and terminated) as json.
   response.setContentType("application/json");
   response.setHeader("Content-Disposition", "inline");
%>
<% AuthController controller = new AuthController(session);
    JSONObject result = controller.register(request.getParameter("name"), request.getParameter("email"), request.getParameter("phone"), request.getParameter("password"));
%>
<%=result%>