<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 26/05/2022
  Time: 22:37
  To change this template use File | Settings | File Templates.
--%>
<%@include file="../database.jsp" %>

<%
    if (!session.getAttribute("ruolo").equals("a")) {
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

    sql = "UPDATE prenotazioni p SET p.stato='r', p.votazioneA='" + grade + "', p.feedback='" + review + "' WHERE p.idUtente='" + session.getAttribute("idPasseggero") + "' AND p.idViaggio='" + session.getAttribute("idViaggio") + "'";
    prprstmt = cn.prepareStatement(sql);
    int row = prprstmt.executeUpdate();

    if (row > 0) {
        session.setAttribute("idPasseggero", "");
        session.setAttribute("idViaggio", "");
    }
    response.sendRedirect("index.jsp");
%>
