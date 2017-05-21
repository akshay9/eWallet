<%@ page import="com.app.controllers.TransactionController" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.function.Consumer" %>
<%@ page import="java.util.Iterator" %>
<%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 04-04-2017
  Time: 06:31 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    AdminController controller = new AdminController(session, response);
    if(session.getAttribute("redirect") != null) {
        session.removeAttribute("redirect");
        session.invalidate();
        return;
    }
%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="github.com/akshay9">
    <link rel="icon" href="favicon.ico">

    <title>E-Wallet Software</title>

    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" href="css/animate.min.css">
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
<%@include file="layout/nav.jsp"%>

<div class="container card mt-5 mb-5" style="min-height: 450px;">
    <%
        String s = request.getParameter("page");
        if(s.equals("transactions")){
            ArrayList<HashMap<String,String>> mList = controller.getTransactions(); %>
            <%@include file="admin/transactions.jsp"%>
    <%  } else if(s.equals("users")) { %>
            <%@include file="admin/users.jsp"%>
    <% } %>
</div>

<script src="js/jquery-3.2.0.min.js"></script>
<script src="js/tether.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>