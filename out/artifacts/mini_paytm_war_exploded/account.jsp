<%@ page import="com.app.controllers.AccountController" %><%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 04-04-2017
  Time: 06:31 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    AccountController controller = new AccountController(session, response);
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

<div class="container card mt-5">

    <div class="row">
        <div class="offset-md-4 col-md-4 text-center mt-3">
            <h2>My Account</h2>
        </div>
    </div>
    <div class="row mt-3">
        <div id="quickTransfer" class="col-md-8">
            <div class="card mb-4" style="width: 100%;">
                <div class="card-block">
                    <h4 class="card-title">Quick Transfer</h4>
                    <form >
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="width-98" for="phone1">From: <span class="text-muted text-size-14"><%=controller.user.getName()%></span></label>
                                    <input type="number" class="form-control disabled" id="phone1" name="email" value="<%=controller.user.getPhone()%>" disabled>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="width-98" for="phone2">To: <span id="toPerson" class="text-muted text-size-14"></span></label>
                                    <input type="number" class="form-control" id="phone2" name="phone" placeholder="Enter phone">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="amount">Amount</label>
                                    <input type="number" class="form-control" id="amount" name="amount" placeholder="Enter amount">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="comment">Reason</label>
                                    <input type="text" maxlength="32" class="form-control" id="comment" name="comment" placeholder="Optional message">
                                </div>
                            </div>
                        </div>
                        <button type="submit" class="sendMoney btn btn-primary">Pay</button>
                        <div class="response mt-3 mb-2"></div>
                    </form>
                </div>
            </div>
        </div>
        <div id="balance_block" class="col-md-4">
            <div class="card mb-4" style="width: 100%;box-shadow: 0 5px 15px rgba(136, 136, 136, 0.25)">
                <div class="card-block">
                    <h4 class="card-title">Balance:</h4>
                    <p class="card-text">₹ <span id="accBalance" class="count"><%=controller.user.getBalance()%></span></p>
                    <a href="/addMoney.jsp" class="btn btn-primary">Add Money</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery-3.2.0.min.js"></script>
<script src="js/tether.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>
