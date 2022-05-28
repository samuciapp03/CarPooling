<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 16/05/2022
  Time: 21:36
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.example.carpooling.Functions" %>
<%@include file="../../database.jsp" %>

<%
    if (session.getAttribute("usernameRecupero").equals("")) {
        response.sendRedirect("./index.jsp");
        return;
    }

    Functions f = new Functions();
    String newPassword = null;

    if (!request.getParameter("password").isEmpty()) {
        newPassword = request.getParameter("password");
    } else {
        response.sendRedirect("./nuovaPassword.jsp");
        return;
    }

    String sql = "UPDATE utenti SET password ='" + f.get_SHA_512_SecurePassword(newPassword, "amma") + "' WHERE username='" + session.getAttribute("usernameRecupero") + "'";
    int update = stmt.executeUpdate(sql);

    session.setAttribute("code", "");
    session.setAttribute("usernameRecupero", "");
    response.sendRedirect("../login/");
%>
