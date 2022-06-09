<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 01/06/2022
  Time: 17:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="com.example.carpooling.Functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../database.jsp" %>


<%
    if (!session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Functions f = new Functions();

    String parameter = request.getParameter("id");

    ResultSet rs = null;

    String sql = "SELECT * FROM viaggi v INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile WHERE a.idAutomobile=" + parameter + " AND v.completato='n'";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        response.sendRedirect("detailsPage.jsp");
        return;
    }

    sql = "UPDATE automobili SET eliminata='y' WHERE idAutomobile = " + parameter;
    prprstmt = cn.prepareStatement(sql);
    int row = prprstmt.executeUpdate();

    response.sendRedirect("./detailsPage.jsp");
%>
