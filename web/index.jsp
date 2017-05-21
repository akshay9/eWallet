<%@ page import="com.app.App" %>
<%@ page import="com.app.controllers.IndexController" %>
<%--
  Created by IntelliJ IDEA.
  User: Akshay
  Date: 04-04-2017
  Time: 06:31 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% IndexController controller = new IndexController(session);%>
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
    <nav class="navbar navbar-toggleable-md navbar-inverse">
        <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
            <span class="navbar-toggler-icon"></span>
        </button>
        <a class="navbar-brand text-center" href="#">eWallet Software</a>

        <%--<div class="collapse navbar-collapse" id="navbarSupportedContent">--%>
            <%--<ul class="navbar-nav mr-auto">--%>
                <%--<li class="nav-item active">--%>
                    <%--<a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>--%>
                <%--</li>--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link" href="#">Link</a>--%>
                <%--</li>--%>
                <%--<li class="nav-item">--%>
                    <%--<a class="nav-link disabled" href="#">Disabled</a>--%>
                <%--</li>--%>
            <%--</ul>--%>
            <%--<form class="form-inline my-2 my-lg-0">--%>
                <%--<input class="form-control mr-sm-2" type="text" placeholder="Search">--%>
                <%--<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>--%>
            <%--</form>--%>
        <%--</div>--%>
    </nav>
    <div class="container">

        <div class="offset-md-3 col-md-6">
            <div id="main_content" class="text-center text-white mt-6">
                <h2>#GoCashless</h2>
                <hr>
                <h4>Smartest way without cash !</h4>
                <button id="startButton" class="btn btn-lg mt-4 btn-outline-white">Get Started</button>
            </div>
            <div id="login_block" class="card mt-5 hidden">
                <div class="card-block">
                    <div class="text-center"><h2>Login</h2></div>
                    <form action="#" class="mb-1">
                        <div class="response mt-3 mb-2"></div>
                        <div class="form-group">
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" id="email" name="email" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password">
                        </div>

                        <div class="text-center mt-2">
                            <button id="loginButton" type="submit" class="btn btn-primary center-block">Submit</button>
                        </div>
                        <div class="text-center mt-2">
                            <a class="register-now" href="#">New User? Register here.</a><br>
                            <a class="forgot-pass" onclick="alert('Eat Baadam');" href="#">Forgot Password?</a>
                        </div>
                    </form>
                </div>
            </div>
            <div id="register_block" class="card mt-5 hidden">
                <div class="card-block">
                    <div class="text-center"><h2>Register</h2></div>
                    <form action="#" class="mb-1">
                        <div class="response mt-3 mb-2"></div>
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" class="form-control" id="name" name="name" placeholder="Enter name">
                        </div>
                        <div class="form-group">
                            <label for="email">Email address</label>
                            <input type="email" class="form-control" id="newemail" name="email" placeholder="Enter email">
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone No.</label>
                            <input type="text" class="form-control" id="phone" name="phone" placeholder="Enter Phone Number.">
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="newpassword" name="password" placeholder="Enter password">
                        </div>
                        <div class="form-group">
                            <label for="repeatpassword">Repeat Password</label>
                            <input type="password" class="form-control" id="repeatpassword" name="repeatpassword" placeholder="Repeat password">
                        </div>

                        <div class="text-center mt-2">
                            <button id="registerButton" type="submit" class="btn btn-primary center-block">Register</button>
                        </div>
                    </form>
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
