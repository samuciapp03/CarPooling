<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 26/05/2022
  Time: 22:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@include file="../database.jsp" %>

<%
    if (!session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("index.jsp");
        return;
    }

    String parameter = request.getParameter("id");
    String p[] = parameter.split("-");

    String idPasseggero = p[0];
    String idViaggio = p[1];

    session.setAttribute("idPasseggero", idPasseggero);
    session.setAttribute("idViaggio", idViaggio);

    int id = 0;
    String sql = "SELECT idUtente FROM utenti WHERE username = '" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        id = rs.getInt("idUtente");
    }
%>
<html>
<head>
    <title>Valutazione Passeggero</title>
</head>
<body>
<%
    sql = "SELECT * FROM (prenotazioni p INNER JOIN utenti u ON p.idUtente=u.idUtente) INNER JOIN viaggi v ON p.idViaggio=v.idViaggio WHERE p.idUtente='" + idPasseggero + "' AND p.idViaggio='" + idViaggio + "'";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
%>
<center>
    <h4> Valutazione Passeggero </h4> <br> <br>
    Viaggio condiviso con <%=rs.getString("nome")%> <%=rs.getString("cognome")%> da <%=rs.getString("partenza")%>
    a <%=rs.getString("arrivo")%> in data <%=f.renderDate(rs.getString("dataInizio"))%>. <br>
    <%
        }
    %>
    <form method="post" action="gradePassengerCode.jsp">
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
