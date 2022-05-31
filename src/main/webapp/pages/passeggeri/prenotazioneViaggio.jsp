<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 22/05/2022
  Time: 22:01
  To change this template use File | Settings | File Templates.
--%>

<%@include file="../database.jsp" %>
<%@page import="com.example.carpooling.Functions" %>

<%
    if (!session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("index.jsp");
        return;
    }

    Functions f = new Functions();
    int idViaggio;

    if (request.getParameter("idViaggio").equals(null))
        idViaggio = Integer.parseInt(request.getParameter("idViaggioAltro"));
    else
        idViaggio = Integer.parseInt(request.getParameter("idViaggio"));

    int idUtente = 0;
    String nome = null;
    String cognome = null;
    String email = null;
    String tel = null;
    String partenza = null;
    String arrivo = null;
    String data = null;
    String orario = null;
    String emailAutista = null;

    String sql = "SELECT * FROM utenti WHERE username='" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    while (rs.next()) {
        idUtente = Integer.parseInt(rs.getString("idUtente"));
        nome = rs.getString("nome");
        cognome = rs.getString("cognome");
        email = rs.getString("email");
        tel = rs.getString("tel");
    }

    sql = "SELECT * FROM (viaggi v INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE idViaggio=" + idViaggio;
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        partenza = rs.getString("partenza");
        arrivo = rs.getString("arrivo");
        data = rs.getString("dataInizio");
        orario = rs.getString("oraPartenza");
        emailAutista = rs.getString("email");
    }

    f.send(emailAutista, "Prenotazione per un tuo viaggio", "Ciao! Il nostro utente passeggero "
            + nome + " " + cognome + " (telefono: " + tel + " , email: " + email + " ) desidera usufruire del tuo" +
            " viaggio da " + partenza + " a " + arrivo + " in data " + f.renderDate(data) + " alle " + orario + "." +
            " Accedi al nostro portale per poter accettare la sua prenotazione!");

    sql = "INSERT INTO prenotazioni(stato, idUtente, idViaggio, valutato) values (?, ?, ?, ?)";
    prprstmt = cn.prepareStatement(sql);
    prprstmt.setString(1, "?");
    prprstmt.setString(2, String.valueOf(idUtente));
    prprstmt.setString(3, String.valueOf(idViaggio));
    prprstmt.setString(4, "n");

    int row = prprstmt.executeUpdate();
    if (row > 0) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
