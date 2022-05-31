<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %><%--
  Created by IntelliJ IDEA.
  User: marco
  Date: 22/05/2022
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../database.jsp" %>
<%@page import="com.example.carpooling.Functions" %>

<%
    if (session.getAttribute("username").equals("") || !session.getAttribute("ruolo").equals("p")) {
        response.sendRedirect("../../index.jsp");
        return;
    }

    DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
    LocalDateTime now = LocalDateTime.now();

    Functions f = new Functions();

    String departure = null;
    String destination = null;
    String date = null;

    int id = 0;
    String img = "";
    String sql = "SELECT idUtente, img FROM utenti WHERE username = '" + session.getAttribute("username") + "'";
    ResultSet rs = stmt.executeQuery(sql);

    if (rs.next()) {
        id = rs.getInt("idUtente");
        img = rs.getString("img");
    }

    sql = "UPDATE viaggi v INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile SET v.completato='y' WHERE v.completato='n' AND v.dataInizio<'" + dtf.format(now) + "'";
    prprstmt = cn.prepareStatement(sql);
    int row = prprstmt.executeUpdate();

    sql = "UPDATE viaggi v INNER JOIN prenotazioni p ON v.idViaggio=p.idViaggio SET p.stato='u' WHERE p.stato='y' AND v.completato='y'";
    prprstmt = cn.prepareStatement(sql);
    row = prprstmt.executeUpdate();

    sql = "SELECT * FROM comuni WHERE name='" + request.getParameter("departure") + "'";
    rs = stmt.executeQuery(sql);

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

    date = request.getParameter("date");
%>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <!-- Bootstrap CSS -->
    <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous"
    />

    <link href="../../css/style.css" rel="stylesheet"/>
    <link href="../../css/login.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Car Pooling - Search trip Passeggero</title>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
<div class="bg-image">
    <div class="overflow-auto cont">
        <header>
            <br/>
            <nav id="navbar_top" class="navbar navbar-expand-lg navbar-dark">
                <div class="container">
                    <a class="navbar-brand" href="index.jsp">Car Pooling</a>
                    <button
                            class="navbar-toggler"
                            type="button"
                            data-bs-toggle="collapse"
                            data-bs-target="#main_nav"
                    >
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="main_nav">
                        <ul class="navbar-nav">
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="index.jsp"> Your trips </a>
                            </li>
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="grades.jsp"> Grades </a>
                            </li>
                            <li class="nav-item d-flex align-items-center">
                                <a class="nav-link" href="allTrips.jsp"> Other trips </a>
                            </li>
                        </ul>
                        <ul class="navbar-nav ms-auto">
                            <div class="dropdown profileIcon">
                                <a
                                        class="nav-link d-flex align-items-center nav-link dropdown-toggle"
                                        routerLink="/backoffice/jobs"
                                        routerLinkActive="active"
                                        data-bs-toggle="dropdown"
                                >
                                    <img
                                            src="<%
                                                if (!img.equals(""))
                                                    //out.write("http://gigachungus.duckdns.org/images/CarPooling/profile/" + img);
                                                    out.write("../../img/propic/" + img);
                                                else
                                                    //out.write("http://gigachungus.duckdns.org/images/CarPooling/profile/default.jpg");
                                                    out.write("../../img/default.jpeg");
                                            %>"
                                            class="iconos profileImage cursor"
                                            alt="hammer"
                                    />
                                    <text
                                            class="my-0"
                                            style="padding-left: 10px; cursor: pointer"
                                    ><%=session.getAttribute("username")%>
                                    </text>
                                </a>
                                <div class="dropdown-menu">
                                    <a href="detailsPage.jsp" class="dropdown-item">Details</a>
                                    <div class="dropdown-divider"></div>
                                    <a href="../../index.jsp" class="dropdown-item">Logout</a>
                                </div>
                            </div>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
        <br>
        <div class="row">
            <div class="container fadeInDown" style="width: 80%">
                <form action="ricercaViaggi.jsp" method="post">
                    <div class="row p-2" style="background-color: var(--myPurple); border-radius: 25px">
                        <div class="col-lg p-1">
                            <div class="d-flex justify-content-center" style="align-items: center;">
                                <input type="text" list="cities1" id="departure" name="departure"
                                       placeholder="Departure" onkeyup="mostra(this.value,'1')" value="<%=departure%>"/>
                            </div>
                        </div>
                        <div class="col-lg p-1">
                            <div class="d-flex justify-content-center" style="align-items: center;">
                                <input type="text" list="cities2" id="destination" name="destination"
                                       placeholder="Destination" onkeyup="mostra(this.value,'2')"
                                       value="<%=destination%>"/>
                            </div>
                        </div>
                        <div class="col-lg p-1">
                            <div class="d-flex justify-content-center" style="align-items: center;">
                                <input type="date" name="date" id="date" value="<%=date%>"/>
                            </div>
                        </div>
                        <div class="col-lg p-1">
                            <div class="d-flex justify-content-center" style="align-items: center; height: 100%;">
                                <input type="submit" value="Search trip"
                                       style="background-color: var(--myOrange); margin: 5px;"/>
                            </div>
                        </div>
                    </div>

                    <datalist id="cities1">
                        <option id="risposta1"></option>
                    </datalist>
                    <datalist id="cities2">
                        <option id="risposta2"></option>
                    </datalist>
                </form>
            </div>
            <div class="height righe">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Trips available
                        </h1>
                        <div class="cont overflow-auto cont">
                            <%
                                if (!date.equals("")) {
                                    sql = "SELECT u.username,u.idUtente,u.cognome,u.nome, v.idViaggio, v.partenza,v.arrivo,v.oraPartenza,v.dataInizio,v.durata, v.nPasseggeri, v.contributo, v.animali, v.bagagli, v.sosta, v.fermata1, v.fermata2, a.marca,a.modello FROM (viaggi v INNER JOIN automobili a ON a.idAutomobile=v.idAutomobile) INNER JOIN utenti u ON u.idUtente=a.idUtente WHERE v.partenza='" + departure + "' AND v.arrivo='" + destination + "' AND v.dataInizio='" + date + "' AND v.dataInizio>'" + dtf.format(now) + "' AND v.nPasseggeri>0 AND v.idViaggio NOT IN (SELECT idViaggio FROM prenotazioni WHERE idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "'))";
                                } else {
                                    sql = "SELECT u.username,u.idUtente,u.cognome,u.nome, v.idViaggio, v.partenza,v.arrivo,v.oraPartenza,v.dataInizio,v.durata, v.nPasseggeri, v.contributo, v.animali, v.bagagli, v.sosta, v.fermata1, v.fermata2, a.marca,a.modello FROM (viaggi v INNER JOIN automobili a ON a.idAutomobile=v.idAutomobile) INNER JOIN utenti u ON u.idUtente=a.idUtente WHERE v.partenza='" + departure + "' AND v.arrivo='" + destination + "' AND v.nPasseggeri>0 AND v.idViaggio NOT IN (SELECT idViaggio FROM prenotazioni WHERE idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "'))";
                                }
                                rs = stmt.executeQuery(sql);

                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">There are no trips that corresponding to your needs</div>");
                                } else {
                            %>

                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Driver</th>
                                    <th scope="col" style="text-align: center">Day - Time</th>
                                    <th scope="col" style="text-align: center">Duration</th>
                                    <th scope="col" style="text-align: center">From</th>
                                    <th scope="col" style="text-align: center">To</th>
                                    <th scope="col" style="text-align: center">Open</th>
                                </tr>
                                </thead>
                                <tbody>
                                <form method="post" action="prenotazioneViaggio.jsp" id="formViaggio">
                                    <%
                                        rs.beforeFirst();
                                        while (rs.next()) {
                                    %>
                                    <tr>
                                        <th scope="row"
                                            class="d-flex justify-content-center">
                                            <text data-toggle="modal"
                                                  data-target="#modalDivAut"
                                                  class="cursor"
                                                  onclick="popModal('<%=rs.getString("idUtente")%>', '<%=rs.getString("cognome") + " " + rs.getString("u.nome")%>');"
                                                  style="text-decoration-line: underline;"><%=rs.getString("cognome") + " " + rs.getString("u.nome")%>
                                            </text>
                                        </th>
                                        <td style="text-align: center"><%=rs.getString("dataInizio") + " " + rs.getString("oraPartenza")%>
                                        </td>
                                        <td style="text-align: center"><%=rs.getString("durata") + "h"%>
                                        </td>
                                        <td style="text-align: center"><%=rs.getString("partenza")%>
                                        </td>
                                        <td style="text-align: center"><%=rs.getString("arrivo")%>
                                        </td>
                                        <td style="text-align: center">
                                            <a data-toggle="modal" data-target="#modalDiv"><img
                                                    src="../../img/open.webp" class="cursor"
                                                    style="height: 15px; width: 15px;margin-top: 2px"
                                                    onclick='showModal("From <%=rs.getString("partenza")%> to <%=rs.getString("arrivo")%>",
                                                            "<%=rs.getString("cognome")%> <%=rs.getString("u.nome")%>",
                                                            "<%=rs.getString("dataInizio")%>",
                                                            "<%=rs.getString("oraPartenza")%>",
                                                            "<%=rs.getString("durata") + "h"%>",
                                                            "<%=rs.getString("marca")%> <%=rs.getString("modello")%>",
                                                            "<%=rs.getString("contributo")%> €",
                                                            "<%=rs.getString("animali")%>",
                                                            "<%=rs.getString("bagagli")%>",
                                                            "<%=rs.getString("sosta")%>",
                                                            "<%=rs.getString("fermata1")%>",
                                                            "<%=rs.getString("fermata2")%>",
                                                            "<%=rs.getString("idViaggio")%>",
                                                            "")'
                                            /></a>
                                        </td>
                                        <input type="text" style="display: none" name="idViaggio"
                                               id="idViaggio"/>
                                    </tr>
                                    <% }
                                    }%>
                                </form>
                                </tbody>
                            </table>
                            <br/>
                        </div>
                        <br/><br/>
                    </div>
                </div>
            </div>
            <div class="height righe">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Some other trips
                        </h1>
                        <div class="cont overflow-auto cont">
                            <%
                                sql = "SELECT u.username,u.idUtente,u.cognome,u.nome, v.idViaggio, v.partenza,v.arrivo,v.oraPartenza,v.dataInizio,v.durata, v.nPasseggeri, v.contributo, v.animali, v.bagagli, v.sosta, v.fermata1, v.fermata2, a.marca,a.modello FROM (viaggi v INNER JOIN automobili a ON a.idAutomobile=v.idAutomobile) INNER JOIN utenti u ON u.idUtente=a.idUtente WHERE v.dataInizio>'" + dtf.format(now) + "' AND v.nPasseggeri>0 AND (v.partenza ='" + departure + "' OR v.arrivo='" + destination + "' OR v.dataInizio='" + date + "') AND v.idViaggio NOT IN (SELECT idViaggio FROM prenotazioni WHERE idUtente IN (SELECT idUtente FROM utenti WHERE username='" + session.getAttribute("username") + "')) ORDER BY v.dataInizio ASC";
                                rs = stmt.executeQuery(sql);

                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">There are no available trips</div>");
                                } else {
                            %>

                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Driver</th>
                                    <th scope="col" style="text-align: center">Day - Time</th>
                                    <th scope="col" style="text-align: center">Duration</th>
                                    <th scope="col" style="text-align: center">From</th>
                                    <th scope="col" style="text-align: center">To</th>
                                    <th scope="col" style="text-align: center">Open</th>
                                </tr>
                                </thead>
                                <tbody>
                                <form method="post" action="prenotazioneViaggio.jsp" id="formViaggioAltro">
                                    <%
                                        rs.beforeFirst();
                                        while (rs.next()) {
                                    %>
                                    <tr>
                                        <th scope="row"
                                            class="d-flex justify-content-center">
                                            <text data-toggle="modal"
                                                  data-target="#modalDivAut"
                                                  class="cursor"
                                                  onclick="popModal('<%=rs.getString("idUtente")%>', '<%=rs.getString("cognome") + " " + rs.getString("u.nome")%>');"
                                                  style="text-decoration-line: underline;"><%=rs.getString("cognome") + " " + rs.getString("u.nome")%>
                                            </text>
                                        </th>
                                        <td style="text-align: center"><%=rs.getString("dataInizio") + " " + rs.getString("oraPartenza")%>
                                        </td>
                                        <td style="text-align: center"><%=rs.getString("durata") + "h"%>
                                        </td>
                                        <td style="text-align: center"><%=rs.getString("partenza")%>
                                        </td>
                                        <td style="text-align: center"><%=rs.getString("arrivo")%>
                                        </td>
                                        <td style="text-align: center">
                                            <a data-toggle="modal" data-target="#modalDiv"><img
                                                    src="../../img/open.webp" class="cursor"
                                                    style="height: 15px; width: 15px;margin-top: 2px"
                                                    onclick='showModal("From <%=rs.getString("partenza")%> to <%=rs.getString("arrivo")%>",
                                                            "<%=rs.getString("cognome")%> <%=rs.getString("u.nome")%>",
                                                            "<%=rs.getString("dataInizio")%>",
                                                            "<%=rs.getString("oraPartenza")%>",
                                                            "<%=rs.getString("durata") + "h"%>",
                                                            "<%=rs.getString("marca")%> <%=rs.getString("modello")%>",
                                                            "<%=rs.getString("contributo")%> €",
                                                            "<%=rs.getString("animali")%>",
                                                            "<%=rs.getString("bagagli")%>",
                                                            "<%=rs.getString("sosta")%>",
                                                            "<%=rs.getString("fermata1")%>",
                                                            "<%=rs.getString("fermata2")%>",
                                                            "<%=rs.getString("idViaggio")%>",
                                                            "a")'
                                            /></a>
                                        </td>
                                        <input type="text" style="display: none" name="idViaggio"
                                               id="idViaggioAltro"/>
                                    </tr>
                                    <% }
                                    }%>
                                </form>
                                </tbody>
                            </table>
                            <br/>
                        </div>
                        <br/><br/>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function popModal(id, nome) {
                document.getElementById('modalLabelAut').innerText = 'Reviews of ' + nome;
                $('#modalBodyAut').load("../reviewUser.jsp?id=" + id + "&type=aut");
            }
        </script>

        <!-- Modal -->
        <div
                class="modal fade"
                id="modalDivAut"
                tabindex="-1"
                role="dialog"
                aria-labelledby="modalLabelAut"
                aria-hidden="true"
        >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalLabelAut"></h5>
                        <button
                                type="button"
                                class="close"
                                data-dismiss="modal"
                                aria-label="Close"
                        >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="modalBodyAut">Loading...</div>
                    </div>
                    <div class="modal-footer">
                        <button
                                type="button"
                                class="btn btn-secondary"
                                data-dismiss="modal"
                        >
                            Close
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div
                class="modal fade"
                id="modalDiv"
                tabindex="-1"
                role="dialog"
                aria-labelledby="modalLabel"
                aria-hidden="true"
        >
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalLabel"></h5>
                        <button
                                type="button"
                                class="close"
                                data-dismiss="modal"
                                aria-label="Close"
                        >
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Driver:
                        <text id="drivModal"></text>
                        <br>
                        Day:
                        <text id="dayModal"></text>
                        <br>
                        Time:
                        <text id="timeModal"></text>
                        <br>
                        Duration:
                        <text id="durModal"></text>
                        <br>
                        Car:
                        <text id="carModal"></text>
                        <br>
                        Economy:
                        <text id="ecoModal"></text>
                        <br>
                        Animals:
                        <text id="animModal"></text>
                        <br>
                        Bagagli:
                        <text id="bagaModal"></text>
                        <br>
                        Stops:
                        <text id="stopsModal"></text>
                        <text class="hide" id="stop1Modal"></text>
                        <text class="hide" id="stop2Modal"></text>
                    </div>
                    <div class="modal-footer">
                        <button
                                type="button"
                                class="btn btn-secondary"
                                data-dismiss="modal"
                        >
                            Close
                        </button>
                        <button type="button" class="btn btn-primary" id="buttonSubmitModal" onclick="">
                            Book
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function showModal(title, driv, day, time, dur, car, eco, anim, baga, stops, stop1, stop2, idViaggio, altro) {
                document.getElementById("modalLabel").innerText = title;
                document.getElementById("drivModal").innerText = driv;
                document.getElementById("dayModal").innerText = day;
                document.getElementById("timeModal").innerText = time;
                document.getElementById("durModal").innerText = dur;
                document.getElementById("carModal").innerText = car;
                document.getElementById("ecoModal").innerText = eco;

                if (anim === "y")
                    document.getElementById("animModal").innerText = "Consentiti";
                else
                    document.getElementById("animModal").innerText = "Non consentiti";

                if (baga === "y")
                    document.getElementById("bagaModal").innerText = "Consentiti";
                else
                    document.getElementById("bagaModal").innerText = "Non consentiti";

                if (stops === "y") {
                    document.getElementById("stopsModal").innerText = "Consentiti"

                    if (stop1 != "") {
                        document.getElementById("stop1Modal").innerText = "Stop 1: " + stop1;
                        document.getElementById("stop1Modal").style.display = "block";
                    }

                    if (stop2 != "") {
                        document.getElementById("stop2Modal").innerText = "Stop 2: " + stop2;
                        document.getElementById("stop2Modal").style.display = "block";
                    }
                } else
                    document.getElementById("stopsModal").innerText = "Non consentiti";


                if (altro === "") {
                    document.getElementById("buttonSubmitModal").onclick = function () {
                        document.getElementById("formViaggio").submit();
                    }
                    document.getElementById("idViaggio").value = idViaggio;
                } else {
                    document.getElementById("buttonSubmitModal").onclick = function () {
                        document.getElementById("formViaggioAltro").submit();
                    }
                    document.getElementById("idViaggioAltro").value = idViaggio;

                }
            }
        </script>
    </div>
</div>

<script
        src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"
></script>
<script
        src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"
></script>
<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"
></script>

<script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"
></script>
<script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</body>
</html>

