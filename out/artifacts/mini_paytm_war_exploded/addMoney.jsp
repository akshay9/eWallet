<%@ page import="com.app.controllers.AccountController" %>
<%@ page import="com.app.controllers.BankController" %><%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 04-04-2017
  Time: 06:31 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    BankController controller = new BankController(session, response);
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
            <h2>Add Money</h2>
        </div>
    </div>
    <div class="row mt-3">
        <div id="quickTransfer" class="col-md-8">
            <div class="card mb-4" style="width: 100%;">
                <div class="card-block">
                    <h4 class="card-title">Credit Card</h4>
                    <form >
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="width-98" for="ccno">Credit Card Number:</label>
                                    <input type="number" class="form-control disabled" id="ccno" name="ccno">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="width-98" for="expiry">Expiry: </label>
                                    <input type="number" class="form-control" id="expiry" name="expiry" min="1" max="12" placeholder="Month">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="width-98" for="expiry2">&nbsp;</label>
                                    <input type="number" class="form-control" id="expiry2" name="expiry2" min="2017" max="2025" placeholder="Year">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="width-98" for="cvv">CVV: </label>
                                    <input type="number" class="form-control" id="cvv" name="cvv" min="100" max="999" placeholder="">
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
                        </div>
                        <button type="submit" class="addMoney btn btn-primary">Recharge</button>
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
