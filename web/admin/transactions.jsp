<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
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
                <th>Reverse</th>
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
                <th scope="row"><%=row.get("id")%></th>
                <td><%=row.get("from")%></td>
                <td><%=row.get("to")%></td>
                <%--<td><%=row.get("type").equals("Cr") ? row.get("sender_name")+"("+row.get("sender_phone")+")": "You"%></td>--%>
                <%--<td><%=row.get("type").equals("Cr") ? "You": row.get("receiver_name")+"("+row.get("receiver_phone")+")"%></td>--%>
                <td>&#8377; <%=row.get("amount")%></td>
                <td><%=row.get("comment")%></td>
                <td><%=row.get("time")%></td>
                <td>
                    <a class="reverseTxn btn btn-danger <%=row.get("reversed_class")%>" href="ajax.jsp?type=revTxn&txnId=<%=row.get("id")%>"><%=row.get("reversed")%></a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
<div class="floating-alert-holder"></div>