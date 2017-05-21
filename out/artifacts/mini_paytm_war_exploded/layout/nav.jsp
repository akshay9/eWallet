<%@ page import="com.app.controllers.AdminController" %>
<%@ page import="com.app.controllers.AccountController" %>
<%@ page import="com.app.controllers.TransactionController" %>
<%@ page import="com.app.controllers.BankController" %>
<nav class="navbar navbar-toggleable-md navbar-inverse">
    <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarSupportedContent">
        <span class="navbar-toggler-icon"></span>
    </button>
    <a class="navbar-brand ml-2" href="#">eWallet</a>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item <%=(AccountController.class.isInstance(controller)) ? "active":""%>">
                <a class="nav-link" href="account.jsp">My Account</a>
            </li>
            <li class="nav-item <%=(BankController.class.isInstance(controller)) ? "active":""%>">
                <a class="nav-link" href="addMoney.jsp">Add Money</a>
            </li>
            <li class="nav-item <%=(TransactionController.class.isInstance(controller)) ? "active":""%>">
                <a class="nav-link" href="transactions.jsp">Transactions</a>
            </li>
            <% if(controller.user.isAdmin()){ %>
            <li class="nav-item <%=(AdminController.class.isInstance(controller)) ? "active":""%>">
                <div class="dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown">Admin Panel</a>

                    <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                        <a class="dropdown-item" href="admin.jsp?page=transactions">Transactions</a>
                        <a class="dropdown-item" href="admin.jsp?page=users">Users</a>
                    </div>

                </div>
            </li>
            <% } %>
        </ul>
        <form class="form-inline my-2 my-lg-0">

            <div class="btn-group" role="group">
                <%--<button id="btnGroupDrop1" type="button" class="btn btn-secondary" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">--%>
                <%--Dropdown--%>
                <%--</button>--%>
                <button id="btnGroupDrop1" class="btn btn-outline-white dropdown-toggle my-2 my-sm-0" data-toggle="dropdown" type="button">Hey <%=controller.user.getName()%></button>
                <div class="dropdown-menu dropdown-menu-right" aria-labelledby="btnGroupDrop1">
                    <a class="dropdown-item" href="account.jsp">Account</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="login.jsp?logout=true">Logout</a>
                </div>
            </div>
        </form>
    </div>
</nav>