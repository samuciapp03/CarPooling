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
        function grade(btn) {
            const a = btn.id;
            document.location.href = "gradeAutista.jsp?id=" + a;
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
    <link rel="shortcut icon" href="../../icons/logo.png">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <title>Car Pooling - Grades Passeggero</title>
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
                                <a class="nav-link" href="#"> Grades </a>
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
                                                    out.write("http://carpooling.samuelciappesoni.it:8080/images/CarPooling/profile/" + img);
                                                else
                                                    out.write("http://carpooling.samuelciappesoni.it:8080/images/CarPooling/profile/default.jpg");
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
            <div class="height righe" id="gradethetrips">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Grade the trips you took part in
                        </h1>
                        <div class="cont overflow-auto home">
                            <%
                                sql = "SELECT * FROM ((prenotazioni p INNER JOIN viaggi v ON p.idViaggio=v.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE p.idUtente = " + id + " AND v.completato='y' AND p.valutato='n' ORDER BY v.dataInizio DESC";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">You did no trips</div>");
                                } else {
                            %>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Driver</th>
                                    <th scope="col" style="text-align: center">Trip</th>
                                    <th scope="col" style="text-align: center">Date</th>
                                    <th scope="col" style="text-align: center">Grade</th>
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
                                        <%=rs.getString("cognome") + " " + rs.getString("nome")%>
                                    </th>
                                    <td style="text-align: center"><%=rs.getString("partenza") + " - " + rs.getString("arrivo")%>
                                    </td>
                                    <td style="text-align: center"><%=f.renderDate(rs.getString("dataInizio"))%>
                                    </td>
                                    <td style="text-align: center">
                                        <button type="button" id="<%=rs.getString("idViaggio")%>"
                                                onclick="grade(this)"
                                                style="background: none;padding: 0px;border: none">
                                            <i class="fas fa-vote-yea" style="font-size:24px;color:darkgoldenrod"></i>
                                        </button>
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
            <div class="height righe" id="yourgrades">
                <div class="wrapper fadeInDown">
                    <div class="homeDiv">
                        <br/>
                        <h1
                                class="fadeIn first"
                                style="padding: 0px 10px 10px 10px; color: rgb(97, 95, 133)"
                        >
                            Your ratings given by the drivers of your trips
                        </h1>
                        <div class="cont overflow-auto home">
                            <%
                                sql = "SELECT * FROM ((viaggi v INNER JOIN prenotazioni p ON v.idViaggio = p.idViaggio) INNER JOIN automobili a ON v.idAutomobile=a.idAutomobile) INNER JOIN utenti u ON a.idUtente=u.idUtente WHERE p.idUtente = " + id + " AND p.stato='r' ORDER BY v.dataInizio DESC";
                                rs = stmt.executeQuery(sql);
                                if (!rs.next()) {
                                    out.write("<div class=\"container d-flex justify-content-center\">You have no ratings</div>");
                                } else {
                            %>
                            <table class="table">
                                <thead>
                                <tr>
                                    <th scope="col" style="text-align: center">Driver</th>
                                    <th scope="col" style="text-align: center">Trip</th>
                                    <th scope="col" style="text-align: center">Grade</th>
                                    <th scope="col" style="text-align: center">Review</th>
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
                                        <%=rs.getString("cognome") + " " + rs.getString("nome")%>
                                    </th>
                                    <td style="text-align: center"><%=rs.getString("partenza") + "-" + rs.getString("arrivo") + " in data " + f.renderDate(rs.getString("dataInizio"))%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("votazioneA")%>
                                    </td>
                                    <td style="text-align: center"><%=rs.getString("feedback")%>
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
