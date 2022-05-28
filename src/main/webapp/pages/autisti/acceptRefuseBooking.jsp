<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 24/05/2022
  Time: 11:48
  To change this template use File | Settings | File Templates.
--%>

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

    String emailPasseggero = null;
    String cognome = null;
    String nome = null;
    String partenza = null;
    String arrivo = null;
    String data = null;
    String orario = null;
    String emailAutista = null;
    String telefonoAutista = null;

    String idViaggio = null;
    int nPasseggeri = 0;

    ResultSet rs = null;

    String policy = parameter.substring(0, 1);
    String idPrenotazione = parameter.substring(1);

    String sql = "UPDATE prenotazioni SET stato='" + policy + "'WHERE idPrenotazione='" + idPrenotazione + "'";
    prprstmt = cn.prepareStatement(sql);
    int row = prprstmt.executeUpdate();

    if (policy.equals("y")) {
        sql = "SELECT * FROM prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio WHERE idPrenotazione='" + idPrenotazione + "'";
        rs = stmt.executeQuery(sql);

        if (rs.next()) {
            idViaggio = rs.getString("idViaggio");
            nPasseggeri = rs.getInt("nPasseggeri") - 1;
        }

        sql = "UPDATE viaggi SET nPasseggeri='" + nPasseggeri + "'WHERE idViaggio='" + idViaggio + "'";
        prprstmt = cn.prepareStatement(sql);
        row = prprstmt.executeUpdate();
    }

    sql = "SELECT * FROM prenotazioni p INNER JOIN utenti u ON p.idUtente=u.idUtente WHERE p.idPrenotazione=" + idPrenotazione;
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        emailPasseggero = rs.getString("email");
    }

    sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE p.idPrenotazione=" + idPrenotazione;
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        cognome = rs.getString("cognome");
        nome = rs.getString("nome");
        partenza = rs.getString("partenza");
        arrivo = rs.getString("arrivo");
        data = rs.getString("dataInizio");
        orario = rs.getString("oraPartenza");
        emailAutista = rs.getString("email");
        telefonoAutista = rs.getString("tel");
    }

    if (policy.equals("y")) {
        f.send(emailPasseggero, "Riscontro per la tua prenotazione", "Ciao! L'autista "
                + nome + " " + cognome + " ha accettato la tua prenotazione per il viaggio da " + partenza + " a " + arrivo + " per il " + f.renderDate(data) + " alle " + orario + "." +
                " Se non ti ha ancora contattato, ecco i suoi recapiti! Email: " + emailAutista + "  Telefono: " + telefonoAutista);
    } else {
        f.send(emailPasseggero, "Riscontro per la tua prenotazione", "Ciao! L'autista "
                + nome + " " + cognome + " ha rifiutato la tua prenotazione per il viaggio da " + partenza + " a " + arrivo + " per il " + f.renderDate(data) + " alle " + orario + "." +
                " Non ti scoraggiare! Continua a cercare viaggi con noi!");

        sql = "DELETE FROM prenotazioni WHERE idPrenotazione = '" + idPrenotazione + "'";
        prprstmt = cn.prepareStatement(sql);
        row = prprstmt.executeUpdate();
    }

    response.sendRedirect("./index.jsp");

%>
