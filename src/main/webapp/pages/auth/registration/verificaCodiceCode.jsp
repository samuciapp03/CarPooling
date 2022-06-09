<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 09/06/2022
  Time: 10:48
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.example.carpooling.Functions" %>
<%@include file="../../database.jsp" %>

<%
    if (session.getAttribute("code").equals("") && session.getAttribute("username").equals("")) {
        response.sendRedirect("./index.jsp");
        return;
    }

    Functions f = new Functions();
    String codice = null;

    if (!request.getParameter("codice").isEmpty()) {
        codice = request.getParameter("codice");
    } else {
        response.sendRedirect("index.jsp");
        return;
    }

    if (codice.equals(session.getAttribute("code"))) {
        session.setAttribute("code", "");
        session.setAttribute("username", "");
        response.sendRedirect("../../../index.jsp");
        return;
    } else {
        String sql = "DELETE FROM utenti WHERE username='" + session.getAttribute("username") + "'";
    }
%>
