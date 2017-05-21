<%@ page import="com.app.controllers.TransactionController" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Iterator" %>
<%--
  Created by IntelliJ IDEA.
  User: Yogesh
  Date: 04-04-2017
  Time: 06:31 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    TransactionController controller = new TransactionController(session, response);
    if(session.getAttribute("redirect") != null) {
        session.removeAttribute("redirect");
        session.invalidate();
        return;
    }
    ArrayList<HashMap<String,String>> mList = controller.getTransactions();
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

    <div class="row">
        <div class="offset-md-4 col-md-4 text-center mt-3">
            <h2>Transactions</h2>
        </div>
    </div>
    <div class="row mt-3">
        <div class="col-md-12">
            <table class="table">
                <thead class="thead-default">
                    <tr>
                        <th>Txn. Id</th>
                        <th>From</th>
                        <th>To</th>
                        <th>Amount</th>
                        <th>Comment</th>
                        <th>Date</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Iterator<HashMap<String, String>> it = mList.iterator();
                    int i =0;
                    while(it.hasNext()){
                        HashMap<String,String> row = it.next();
                        i++;
                %>
                <tr>
                    <th scope="row"><%=row.get("id")%></th
                    <td><%=row.get("from")%></td>
                    <td><%=row.get("to")%></td>
                    <%--<td><%=row.get("type").equals("Cr") ? row.get("sender_name")+"("+row.get("sender_phone")+")": "You"%></td>--%>
                    <%--<td><%=row.get("type").equals("Cr") ? "You": row.get("receiver_name")+"("+row.get("receiver_phone")+")"%></td>--%>
                    <td>&#8377; <%=row.get("amount")%></td>
                    <td><%=row.get("comment")%></td>
                    <td><%=row.get("time")%></td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script src="js/jquery-3.2.0.min.js"></script>
<script src="js/tether.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/main.js"></script>
</body>
</html>