<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="com.app.models.User" %>
<div class="row">
    <div class="offset-md-4 col-md-4 text-center mt-3">
        <h2>Users</h2>
    </div>
</div>
<div class="row mt-3">
    <div class="col-md-12">
        <table class="table">
            <thead class="thead-default">
            <tr>
                <th>#</th>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Balance</th>
                <th>Access</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                ArrayList<User> mList = controller.getUsers();
                Iterator<User> it = mList.iterator();
                int i =0;
                while(it.hasNext()){
                    User row = it.next();
                    i++;
            %>
            <tr>
                <th scope="row"><%=i%></th>
                <td><%=row.getName()%></td>
                <td><%=row.getEmail()%></td>
                <td><%=row.getPhone()%></td>
                <td>&#8377; <%=row.getBalance()%></td>
                <td class="<%=row.getAccessRole().toLowerCase()%>"><%=row.getAccessRole()%></td>
                <td>
                    <div class="dropdown">
                        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            Change Access
                        </button>
                        <div class="dropdown-menu change-access" aria-labelledby="dropdownMenuButton">
                            <a class="dropdown-item banned" href="ajax.jsp?type=setAccess&user=<%=row.getId()%>&access=0">Ban</a>
                            <a class="dropdown-item user" href="ajax.jsp?type=setAccess&user=<%=row.getId()%>&access=5">User</a>
                            <a class="dropdown-item moderator" href="ajax.jsp?type=setAccess&user=<%=row.getId()%>&access=50">Moderator</a>
                            <a class="dropdown-item admin" href="ajax.jsp?type=setAccess&user=<%=row.getId()%>&access=101">Admin</a>
                        </div>
                    </div>
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
