<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    session.setAttribute("username", "");
    session.setAttribute("ruolo", "");
    session.setAttribute("code", "");
    session.setAttribute("usernameRecupero", "");
    session.setAttribute("codeReg", "");
    session.setAttribute("emailReg", "");
    session.setAttribute("idViaggio", "");
    session.setAttribute("idPasseggero", "");

    response.sendRedirect("pages/auth/login/");
%>