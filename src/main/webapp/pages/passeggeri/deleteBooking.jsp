<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 27/05/2022
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@page import="com.example.carpooling.Functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../database.jsp" %>

<%
    if (!session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Functions f = new Functions();

    String parameter = request.getParameter("id");

    String cognome = null;
    String nome = null;
    String partenza = null;
    String arrivo = null;
    String data = null;
    String emailAutista = null;

    String idViaggio = null;
    int nPasseggeri = 0;

    ResultSet rs = null;

    String sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE p.idPrenotazione=" + parameter;
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        partenza = rs.getString("partenza");
        arrivo = rs.getString("arrivo");
        data = rs.getString("dataInizio");
        emailAutista = rs.getString("email");
    }

    sql = "SELECT * FROM prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio WHERE idPrenotazione='" + parameter + "'";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        idViaggio = rs.getString("idViaggio");
        nPasseggeri = rs.getInt("nPasseggeri") + 1;
    }

    sql = "UPDATE viaggi SET nPasseggeri='" + nPasseggeri + "' WHERE idViaggio='" + idViaggio + "'";
    prprstmt = cn.prepareStatement(sql);
    int row = prprstmt.executeUpdate();

    sql = "SELECT * FROM prenotazioni p INNER JOIN utenti u ON p.idUtente=u.idUtente WHERE p.idPrenotazione=" + parameter;
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        nome = rs.getString("nome");
        cognome = rs.getString("cognome");
    }

    sql = "DELETE FROM prenotazioni WHERE idPrenotazione = '" + parameter + "'";
    prprstmt = cn.prepareStatement(sql);
    row = prprstmt.executeUpdate();

    f.send(emailAutista, "Cancellazione prenotazione", "Ciao! Il passeggero "
            + nome + " " + cognome + " ha cancellato la sua prenotazione per il viaggio da " + partenza + " a " + arrivo + " per il " + f.renderDate(data) + ".");

    response.sendRedirect("./index.jsp");
%>

</body>
</html>
