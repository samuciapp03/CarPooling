<html>
<body>
<%@include file="database.jsp" %>
<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("username").equals("") || !session.getAttribute("ruolo").equals("a") && !session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("../index.jsp");
        return;
    }

    String sql = "";
    ResultSet rs;

    String id = request.getParameter("id");
    String t = request.getParameter("type");

    if (t.equals("pas")) {
        sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE p.valutato = 'y' AND p.idUtente='" + id + "'";
        rs = stmt.executeQuery(sql);

        if (!rs.next()) {
            out.println("There are no review for this user");
        } else {
            rs.beforeFirst();
            while (rs.next()) {
%>
<div style="margin: 5px 0px 10px 0px">
    <%
        int voto = rs.getInt("votazioneA");

        for (int i = 0; i < 5; i++) {
            if (i < voto) {
                out.write("<span class=\"fa fa-star fa-lg checked\"></span>");
            } else {
                out.write("<span class=\"fa fa-star fa-lg nonchecked\"></span>");
            }
        }
    %>
</div>
<%="Review by " + rs.getString("cognome") + " " + rs.getString("nome") + ": "%>
<br>
<%=rs.getString("feedback")%>
<%
            if (!rs.isLast())
                out.write("<hr class=\"solid\">");
        }
    }

} else if (t.equals("aut")) {
    sql = "SELECT * FROM ((votazioniP vp INNER JOIN viaggi vi ON vp.idViaggio = vi.idViaggio) INNER JOIN automobili a ON a.idAutomobile = vi.idAutomobile) INNER JOIN utenti u ON u.idUtente = a.idUtente WHERE u.idUtente='" + id + "'";
    rs = stmt.executeQuery(sql);
    if (!rs.next()) {
        out.println("There are no review for this user");
    } else {
        rs.beforeFirst();
        while (rs.next()) {
%>
<div style="margin: 5px 0px 10px 0px">
    <%
        int voto = rs.getInt("vp.voto");

        for (int i = 0; i < 5; i++) {
            if (i < voto) {
                out.write("<span class=\"fa fa-star fa-lg checked\"></span>");
            } else {
                out.write("<span class=\"fa fa-star fa-lg nonchecked\"></span>");
            }
        }
    %>
</div>
<%="Review by " + rs.getString("cognome") + " " + rs.getString("nome") + ": "%>
<br>
<%=rs.getString("descrizione")%>
<%
            if (!rs.isLast())
                out.write("<hr class=\"solid\">");
        }
    }
} else {%>

Error

<%}%>
</body>
</html>