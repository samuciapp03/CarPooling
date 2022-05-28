<%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 21/05/2022
  Time: 21:51
  To change this template use File | Settings | File Templates.
--%>

<%@include file="../database.jsp" %>

<%
    if (!session.getAttribute("ruolo").equals("a")) {
        response.sendRedirect("index.jsp");
        return;
    }

    String departure = null;
    String destination = null;
    String date = null;
    String time = null;
    int duration = 0;
    int idAutomobile = 0;
    int contribution = 0;
    int spots = 0;
    String checkboxes[] = request.getParameterValues("checkboxes");
    char backpacks = 'n';
    char animals = 'n';
    char stops = 'n';
    String stop1 = null;
    String stop2 = null;

    String sql = "SELECT * FROM comuni WHERE name='" + request.getParameter("departure") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        departure = request.getParameter("departure");
        rs.close();
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    sql = "SELECT * FROM comuni WHERE name='" + request.getParameter("destination") + "'";
    rs = stmt.executeQuery(sql);

    if (rs.next()) {
        destination = request.getParameter("destination");
        rs.close();
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    if (!request.getParameter("date").isEmpty()) {
        date = request.getParameter("date");
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    if (!request.getParameter("time").isEmpty()) {
        time = request.getParameter("time");
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    if (!request.getParameter("car").isEmpty()) {
        idAutomobile = Integer.valueOf(request.getParameter("car"));
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    if (!request.getParameter("duration").isEmpty() || Integer.valueOf(request.getParameter("duration")) <= 0) {
        duration = Integer.valueOf(request.getParameter("duration"));
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    if (!request.getParameter("contribution").isEmpty() || Integer.valueOf(request.getParameter("contribution")) <= 0) {
        contribution = Integer.valueOf(request.getParameter("contribution"));
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    if (!request.getParameter("spots").isEmpty() || Integer.valueOf(request.getParameter("spots")) <= 0) {
        spots = Integer.valueOf(request.getParameter("spots"));
    } else {
        response.sendRedirect("inserimentoViaggio.jsp");
        return;
    }

    if (checkboxes != null) {
        for (int i = 0; i < checkboxes.length; i++) {
            switch (checkboxes[i]) {
                case "backpacks":
                    backpacks = 'y';
                    break;
                case "animals":
                    animals = 'y';
                    break;
                case "stops":
                    stops = 'y';
                    stop1 = request.getParameter("stop1");
                    stop2 = request.getParameter("stop2");
                    break;
            }
        }
    }

    sql = "INSERT INTO viaggi(partenza, arrivo, dataInizio, oraPartenza, idAutomobile, contributo, durata, nPasseggeri, bagagli, animali, sosta, fermata1, fermata2, completato) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    prprstmt = cn.prepareStatement(sql);
    prprstmt.setString(1, departure);
    prprstmt.setString(2, destination);
    prprstmt.setString(3, date);
    prprstmt.setString(4, time);
    prprstmt.setString(5, String.valueOf(idAutomobile));
    prprstmt.setString(6, String.valueOf(contribution));
    prprstmt.setString(7, String.valueOf(duration));
    prprstmt.setString(8, String.valueOf(spots));
    prprstmt.setString(9, String.valueOf(backpacks));
    prprstmt.setString(10, String.valueOf(animals));
    prprstmt.setString(11, String.valueOf(stops));
    prprstmt.setString(12, stop1);
    prprstmt.setString(13, stop2);
    prprstmt.setString(14, "n");

    int row = prprstmt.executeUpdate();
    if (row > 0) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
