<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 26/05/2022
  Time: 17:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../database.jsp" %>
<%@page import="com.example.carpooling.Functions" %>

<%
    if (!session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Functions f = new Functions();

    String idViaggio = request.getParameter("id");

    int id = 0;
    String sql = "SELECT idUtente FROM utenti WHERE username = '" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        id = rs.getInt("idUtente");
    }
%>
<html>
<head>
    <title>Valutazione Viaggio</title>
</head>
<body>
<%
    sql = "SELECT * FROM (viaggi v INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE v.idViaggio='" + idViaggio + "'";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
%>
<center>
    <h4> Valutazione viaggio </h4> <br> <br>
    Viaggio da <%=rs.getString("partenza")%> a <%=rs.getString("arrivo")%> in
    data <%=f.renderDate(rs.getString("dataInizio"))%>. <br>
    Viaggio offerto dall'autista <%=rs.getString("cognome")%> <%=rs.getString("nome")%> <br> <br>
    <%
            session.setAttribute("idViaggio", idViaggio);
        }
    %>
    <form method="post" action="gradeAutistaCode.jsp">
        <label for="grade">Grade</label>
        <select id="grade" name="grade">
            <option>1</option>
            <option>2</option>
            <option>3</option>
            <option>4</option>
            <option>5</option>
            <option>6</option>
            <option>7</option>
            <option>8</option>
            <option>9</option>
            <option>10</option>
        </select>
        <br> <br>
        <label for="review">Review</label> <br>
        <textarea id="review" name="review" maxlength="300" style="width: 300px;height: 150px"></textarea> <br> <br>
        <input type="submit" value="Submit"/>
    </form>


</center>
</body>
</html>
