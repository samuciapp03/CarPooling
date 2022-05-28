<%@ page import="java.time.format.*" %>
<%@ page import="java.time.*" %>
<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 22/05/2022
  Time: 14:39
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../database.jsp" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.carpooling.Functions" %>

<html>
<head>
    <script>
        $('input[type=radio]').on('change', function () {
            $(this).closest("form").submit();
        });
    </script>

</head>
<body>
<%
    if (!session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Functions f = new Functions();
    String departure = null;
    String destination = null;
    String date = null;

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
    LocalDateTime now = LocalDateTime.now();

    String sql = "SELECT * FROM comuni WHERE name='" + request.getParameter("departure") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        departure = request.getParameter("departure");
    } else {
        response.sendRedirect("index.jsp");
        return;
    }

    sql = "SELECT * FROM comuni WHERE name='" + request.getParameter("destination") + "'";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        destination = request.getParameter("destination");
    } else {
        response.sendRedirect("index.jsp");
        return;
    }

    if (!request.getParameter("date").isEmpty()) {
        date = request.getParameter("date");
    } else {
        response.sendRedirect("index.jsp");
        return;
    }
%>
<center>
    <h3>These are the results for your search</h3> <br>
    <%

        sql = "SELECT u.username,u.cognome,u.nome, v.idViaggio, v.partenza,v.arrivo,v.oraPartenza,v.dataInizio,v.durata, v.nPasseggeri, v.contributo, v.animali, v.bagagli, v.sosta, v.fermata1, v.fermata2, a.marca,a.modello FROM (viaggi v INNER JOIN automobili a ON a.idAutomobile=v.idAutomobile) INNER JOIN utenti u ON u.idUtente=a.idUtente WHERE v.partenza='" + departure + "' AND v.arrivo='" + destination + "' AND v.dataInizio='" + date + "' AND v.dataInizio>'" + dtf.format(now) + "' AND v.nPasseggeri>0 AND v.idViaggio NOT IN (SELECT idViaggio FROM prenotazioni WHERE idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "'))";
        rs = stmt.executeQuery(sql);
    %>
    <table border="1">
        <thead>
        <tr>
            <th>Descrizione</th>
            <th>Prenota</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (!rs.next()) {
        %>
        <tr>
            <td style="text-align: center">Non sembrano esserci viaggi corrispondenti alle tue necessita'
            </td>
            <td style="text-align: center">):</td>
        </tr>
        <%
        } else {
            rs.beforeFirst();
            while (rs.next()) {
        %>
        <form method="post" action="prenotazioneViaggio.jsp">
            <tr>
                <td style="text-align: center">
                    Viaggio predisposto da: <%=rs.getString("u.nome")%> <%=rs.getString("cognome")%>
                    (username: <%=rs.getString("username")%>) <br>
                    Giorno: <%=f.renderDate(rs.getString("dataInizio"))%> <br>
                    Alle <%=rs.getString("oraPartenza")%> da <%=rs.getString("partenza")%>  ----
                    (<%=rs.getString("durata")%> h) ----> <%=rs.getString("arrivo")%> <br>
                    Macchina: <%=rs.getString("marca")%> <%=rs.getString("modello")%> <br>
                    Contributo economico: <%=rs.getString("contributo")%> € Posti
                    Rimanenti: <%=rs.getString("nPasseggeri")%> <br>
                    Animali: <% if (rs.getString("animali").equals("y")) {%> consentiti <%} else { %> non
                    consentiti <% } %>
                    <br>
                    Bagagli: <% if (rs.getString("bagagli").equals("y")) {%> consentiti <%} else { %> non
                    consentiti <% } %>
                    <br>
                    Sosta: <% if (rs.getString("sosta").equals("y")) {%> prevista <br>
                    Fermata1: <%=rs.getString("fermata1")%> <br>
                    Fermata2: <%=rs.getString("fermata2")%>
                    <%} else { %> non prevista <% } %> <br>
                </td>

                <td align="center">
                    <input type="radio" id="check<%=rs.getString("idViaggio")%>" name="radios"
                           onclick="this.form.submit()"
                           value="<%=rs.getString("idViaggio")%>"> <br> <br>
                </td>
            </tr>
            <input type="submit" hidden>
        </form>
        <% }
        }
        %>
        </tbody>
    </table>
    <br> <br>

    <h3>Other trips you might be interested in</h3> <br>
    <%

        sql = "SELECT u.username,u.cognome,u.nome, v.idViaggio, v.partenza,v.arrivo,v.oraPartenza,v.dataInizio,v.durata, v.nPasseggeri, v.contributo, v.animali, v.bagagli, v.sosta, v.fermata1, v.fermata2, a.marca,a.modello FROM (viaggi v INNER JOIN automobili a ON a.idAutomobile=v.idAutomobile) INNER JOIN utenti u ON u.idUtente=a.idUtente WHERE v.dataInizio>'" + dtf.format(now) + "' AND v.nPasseggeri>0 AND (v.partenza ='" + departure + "' OR v.arrivo='" + destination + "' OR v.dataInizio='" + date + "') AND v.idViaggio NOT IN (SELECT idViaggio FROM prenotazioni WHERE idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "')) ORDER BY v.dataInizio ASC";
        rs = stmt.executeQuery(sql);
    %>
    <table border="1">
        <thead>
        <tr>
            <th>Descrizione</th>
            <th>Prenota</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (!rs.next()) {
        %>
        <tr>
            <td style="text-align: center">Non sembrano esserci viaggi corrispondenti alle tue necessita'
            </td>
            <td style="text-align: center">):</td>
        </tr>
        <%
        } else {
            rs.beforeFirst();
            while (rs.next()) {
        %>
        <form method="post" action="prenotazioneViaggio.jsp">
            <tr>
                <td style="text-align: center">
                    Viaggio predisposto da: <%=rs.getString("u.nome")%> <%=rs.getString("cognome")%>
                    (username: <%=rs.getString("username")%>) <br>
                    Giorno: <%=f.renderDate(rs.getString("dataInizio"))%> <br>
                    Alle <%=rs.getString("oraPartenza")%> da <%=rs.getString("partenza")%>  ----
                    (<%=rs.getString("durata")%> h) ----> <%=rs.getString("arrivo")%> <br>
                    Macchina: <%=rs.getString("marca")%> <%=rs.getString("modello")%> <br>
                    Contributo economico: <%=rs.getString("contributo")%> € Posti
                    Rimanenti: <%=rs.getString("nPasseggeri")%> <br>
                    Animali: <% if (rs.getString("animali").equals("y")) {%> consentiti <%} else { %> non
                    consentiti <% } %>
                    <br>
                    Bagagli: <% if (rs.getString("bagagli").equals("y")) {%> consentiti <%} else { %> non
                    consentiti <% } %>
                    <br>
                    Sosta: <% if (rs.getString("sosta").equals("y")) {%> prevista <br>
                    Fermata1: <%=rs.getString("fermata1")%> <br>
                    Fermata2: <%=rs.getString("fermata2")%>
                    <%} else { %> non prevista <% } %> <br>
                </td>

                <td align="center">
                    <input type="radio" id="check<%=rs.getString("idViaggio")%>" name="radios"
                           onclick="this.form.submit()"
                           value="<%=rs.getString("idViaggio")%>"> <br> <br>
                </td>
            </tr>
            <input type="submit" hidden>
        </form>
        <% }
        }
        %>
        </tbody>
    </table>
</center>
</body>
</html>
