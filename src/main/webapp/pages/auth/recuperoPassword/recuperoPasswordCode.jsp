<%@page import="com.example.carpooling.Functions" %>
<%@include file="../../database.jsp" %>

<%
    Functions f = new Functions();
    String username = null;
    String code;

    if (!request.getParameter("username").isEmpty()) {
        username = request.getParameter("username");
        session.setAttribute("usernameRecupero", username);
    } else {
        response.sendRedirect("index.jsp");
        return;
    }

    String sql = "SELECT * FROM utenti WHERE username='" + username + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        code = f.generateRandomPassword(8);
        session.setAttribute("code", code);
        f.send(rs.getString("email"), "Recupero Password Pooling", "Il codice di verifica per recuperare la password e': " + code);
        response.sendRedirect("verificaCodice.jsp");
        return;
    } else {
        response.sendRedirect("index.jsp");
    }
%>



