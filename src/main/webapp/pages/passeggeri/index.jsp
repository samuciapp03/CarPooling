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
%>
<html>
<head>
    <script>
        function mostra(str, id) {
            if (str.length == 0) {
                document.getElementById("risposta" + id).innerHTML = "";
                return;
            }

            if (window.XMLHttpRequest) {
                ajax = new XMLHttpRequest();
            } else {
                ajax = new ActiveXObject("Microsoft.XMLHTTP");
            }

            ajax.onreadystatechange = function () {
                if (ajax.readyState == 4 && ajax.status == 200) {
                    document.getElementById("risposta" + id).innerHTML = ajax.responseText;
                }
            }
            ajax.open("POST", "../ricercaComuni.jsp?str=" + str, true);

            ajax.send();
        }

        function del1(btn) {
            const a = btn.id;
            document.location.href = "deleteBooking.jsp?id=" + a + "&add=n";
        }

        function del2(btn) {
            const a = btn.id;
            document.location.href = "deleteBooking.jsp?id=" + a + "&add=y";
        }
    </script>
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
    <title>Car Pooling - Passeggero</title>
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
</head>
<body>
<div class="bg-image">
    <div class="overflow-auto cont">
        <header>
            <br/>
            <nav id="navbar_top" class="navbar navbar-expand-lg navbar-dark">
                <div class="container">
                    <a class="navbar-brand" href="#">Car Pooling</a>
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
                                <a class="nav-link" href="#"> Your trips </a>
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
                                       placeholder="Departure" onkeyup="mostra(this.value,'1')"/>
                            </div>
                        </div>
                        <div class="col-lg p-1">
                            <div class="d-flex justify-content-center" style="align-items: center;">
                                <input type="text" list="cities2" id="destination" name="destination"
                                       placeholder="Destination" onkeyup="mostra(this.value,'2')"/>
                            </div>
                        </div>
                        <div class="col-lg p-1">
                            <div class="d-flex justify-content-center" style="align-items: center;">
                                <input type="date" name="date" id="date"/>
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
            <div class="height righe" id="pendingBookings">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Your pending bookings
                        </h1>
                        <div class="cont overflow-auto home">
                            <%
                                sql = "SELECT * FROM (prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN utenti u ON p.idUtente = u.idUtente WHERE p.idUtente = " + id + " AND v.completato='n' AND p.stato='?' ORDER BY v.dataInizio ASC";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">You have no pending bookings</div>");
                                } else {
                            %>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Cancel</th>
                                    <th scope="col" style="text-align: center">Departure</th>
                                    <th scope="col" style="text-align: center">Destination</th>
                                    <th scope="col" style="text-align: center">Date and Time</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    rs.beforeFirst();
                                    while (rs.next()) {
                                %>
                                <tr>

                                    <th scope="row"
                                        class="d-flex justify-content-center">
                                        <button type="button" id="<%=rs.getString("idPrenotazione")%>"
                                                onclick="del1(this)"
                                                style="background: none;padding: 0px;border: none">
                                            <i class="fas fa-trash" style="font-size:24px;color:red"></i>
                                        </button>
                                    </th>
                                    <td style="text-align: center"><%=rs.getString("partenza")%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("arrivo")%>
                                    </td>
                                    <td style="text-align: center"><%=f.renderDate(rs.getString("dataInizio")) + " " + rs.getString("oraPartenza")%>
                                    </td>
                                </tr>
                                <% }
                                }%>
                                </tbody>
                            </table>
                            <br/>
                        </div>
                        <br/><br/>
                    </div>
                </div>
            </div>
            <div class="height righe" id="nexttrips">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Your accepted bookings for your next trips
                        </h1>
                        <div class="cont overflow-auto home">
                            <%
                                sql = "SELECT * FROM (prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN utenti u ON p.idUtente = u.idUtente WHERE p.idUtente = " + id + " AND v.completato='n' AND p.stato='y' ORDER BY v.dataInizio ASC";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">You have no trips</div>");
                                } else {
                            %>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Cancel</th>
                                    <th scope="col" style="text-align: center">Departure</th>
                                    <th scope="col" style="text-align: center">Destination</th>
                                    <th scope="col" style="text-align: center">Date and Time</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    rs.beforeFirst();
                                    while (rs.next()) {
                                %>
                                <tr>

                                    <th scope="row"
                                        class="d-flex justify-content-center">
                                        <button type="button" id="<%=rs.getString("idPrenotazione")%>"
                                                onclick="del2(this)"
                                                style="background: none;padding: 0px;border: none">
                                            <i class="fas fa-trash" style="font-size:24px;color:red"></i>
                                        </button>
                                    </th>
                                    <td style="text-align: center"><%=rs.getString("partenza")%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("arrivo")%>
                                    </td>
                                    <td style="text-align: center"><%=f.renderDate(rs.getString("dataInizio")) + " " + rs.getString("oraPartenza")%>
                                    </td>
                                </tr>
                                <% }
                                }%>
                                </tbody>
                            </table>
                            <br/>
                        </div>
                        <br/><br/>
                    </div>
                </div>
            </div>
            <div class="height righe" id="lasttrips">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Your Last Trips
                        </h1>
                        <div class="cont overflow-auto home">
                            <%
                                sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON v.idViaggio = p.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE p.idUtente = " + id + " AND p.stato='r' ORDER BY v.dataInizio DESC LIMIT 5";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">You did no trips</div>");
                                } else {
                            %>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Departure</th>
                                    <th scope="col" style="text-align: center">Destination</th>
                                    <th scope="col" style="text-align: center">Date</th>
                                    <th scope="col" style="text-align: center">Driver</th>
                                    <th scope="col" style="text-align: center">Car</th>
                                </tr>
                                </thead>
                                <tbody>
                                <%
                                    rs.beforeFirst();
                                    while (rs.next()) {
                                %>
                                <tr>

                                    <th scope="row"
                                        class="d-flex justify-content-center">
                                        <%=rs.getString("partenza")%>
                                    </th>
                                    <td style="text-align: center"><%=rs.getString("arrivo")%>
                                    </td>
                                    <td style="text-align: center"><%=f.renderDate(rs.getString("dataInizio"))%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("cognome") + " " + rs.getString("nome")%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("marca") + " " + rs.getString("modello")%>
                                    </td>
                                </tr>
                                <% }
                                }%>
                                </tbody>
                            </table>
                            <br/>
                        </div>
                        <br/><br/>
                    </div>
                </div>
            </div>
        </div>
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
</body>
</html>
