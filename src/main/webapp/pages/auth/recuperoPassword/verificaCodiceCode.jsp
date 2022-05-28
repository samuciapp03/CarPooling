<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 16/05/2022
  Time: 20:10
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.example.carpooling.Functions" %>
<%@include file="../../database.jsp" %>

<%
    if (session.getAttribute("code").equals("")) {
        response.sendRedirect("./index.jsp");
        return;
    }

    Functions f = new Functions();
    String codice = null;

    if (!request.getParameter("codice").isEmpty()) {
        codice = request.getParameter("codice");
    } else {
        response.sendRedirect("verificaCodice.jsp");
        return;
    }

    if (codice.equals(session.getAttribute("code"))) {
        session.setAttribute("code", "");
        response.sendRedirect("nuovaPassword.jsp");
        return;
    } else {
        response.sendRedirect("index.jsp");
    }
%>
