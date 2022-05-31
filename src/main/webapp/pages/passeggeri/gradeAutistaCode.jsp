<%@include file="../database.jsp" %>

<%
    if (!session.getAttribute("ruolo").equals("p")) {
        session.setAttribute("idViaggio", "");
        response.sendRedirect("index.jsp");
        return;
    }

    String grade = null;
    String review = null;

    int id = 0;
    String sql = "SELECT idUtente FROM utenti WHERE username = '" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        id = rs.getInt("idUtente");
    }

    grade = request.getParameter("grade");
    review = request.getParameter("review");

    sql = "INSERT INTO votazioniP(idViaggio, idPasseggero, voto, descrizione) values (?, ?, ?, ?)";
    prprstmt = cn.prepareStatement(sql);
    prprstmt.setString(1, String.valueOf(session.getAttribute("idViaggio")));
    prprstmt.setString(2, String.valueOf(id));
    prprstmt.setString(3, String.valueOf(grade));
    prprstmt.setString(4, review);

    int row = prprstmt.executeUpdate();
    if (row > 0) {

        sql = "UPDATE viaggi v INNER JOIN prenotazioni p ON v.idViaggio=p.idViaggio SET p.valutato='y' WHERE v.completato='y' AND p.idViaggio='" + session.getAttribute("idViaggio") + "' AND p.idUtente='" + id + "'";
        prprstmt = cn.prepareStatement(sql);
        row = prprstmt.executeUpdate();

        session.setAttribute("idViaggio", "");

        response.sendRedirect("index.jsp");
        return;
    }

%>