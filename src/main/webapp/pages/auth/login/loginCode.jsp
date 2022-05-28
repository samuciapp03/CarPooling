<%@page import="com.example.carpooling.Functions" %>
<%@include file="../../database.jsp" %>

<%
    Functions f = new Functions();
    String username = null;
    String password = null;

    if (!request.getParameter("username").isEmpty()) {
        username = request.getParameter("username");
    } else {
        response.sendRedirect("index.jsp");
        return;
    }

    if (!request.getParameter("password").isEmpty()) {
        password = request.getParameter("password");
    } else {
        response.sendRedirect("index.jsp");
        return;
    }

    String sql = "SELECT * FROM utenti WHERE username='" + username + "' AND password='" + f.get_SHA_512_SecurePassword(password, "amma") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        session.setAttribute("username", username);
        session.setAttribute("ruolo", rs.getString("ruolo"));
        switch (rs.getString("ruolo")) {
            case "a":
                response.sendRedirect("../../autisti/");
                break;
            case "p":
                response.sendRedirect("../../passeggeri/");
                break;
            case "x":
                response.sendRedirect("../../admin/");
                break;

        }
        return;
    } else {
        response.sendRedirect("index.jsp");
    }
%>
