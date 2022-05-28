<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 27/05/2022
  Time: 21:08
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

    String cognome = null;
    String nome = null;
    String partenza = null;
    String arrivo = null;
    String data = null;

    ResultSet rs = null;

    String sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE v.idViaggio=" + parameter;
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        nome = rs.getString("nome");
        cognome = rs.getString("cognome");
        partenza = rs.getString("partenza");
        arrivo = rs.getString("arrivo");
        data = rs.getString("dataInizio");
    }

    sql = "SELECT * FROM prenotazioni p INNER JOIN utenti u ON p.idUtente=u.idUtente WHERE p.idViaggio=" + parameter;
    rs = stmt.executeQuery(sql);

    while (rs.next()) {
        f.send(rs.getString("email"), "Cancellazione viaggio", "Ciao! L'autista "
                + nome + " " + cognome + " ha appena cancellato il viaggio a cui ti eri prenotato da " + partenza + " a " + arrivo + " per il " + f.renderDate(data) + ".");
    }

    sql = "DELETE FROM prenotazioni WHERE idViaggio = '" + parameter + "'";
    prprstmt = cn.prepareStatement(sql);
    int row = prprstmt.executeUpdate();

    sql = "DELETE FROM viaggi WHERE idViaggio = '" + parameter + "'";
    prprstmt = cn.prepareStatement(sql);
    row = prprstmt.executeUpdate();

    response.sendRedirect("./index.jsp");
%>

</body>
</html>
